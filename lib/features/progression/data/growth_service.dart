import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/clock.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/sync_columns.dart';
import '../../../core/time/day.dart';
import '../../finance/data/finance_repository.dart';
import '../../finance/domain/finance.dart';
import '../../missions/data/habit_repository.dart';
import '../../missions/domain/excuse.dart';
import '../../missions/domain/habit.dart';
import '../../missions/domain/habit_history.dart';
import '../../profile/data/profile_repository.dart';
import '../../visions/data/vision_repository.dart';
import '../../visions/domain/vision.dart';
import '../../visions/domain/vision_points.dart';
import '../domain/day_close.dart' as close;
import '../domain/evolution.dart' as evo;
import '../domain/reward.dart';
import '../domain/scores.dart';
import '../domain/xp_calculator.dart';
import 'reward_repository.dart';

const _closedThroughKey = 'closedThrough';

/// Trusted application logic: every XP, DP and VP award and every penalty
/// goes through here, using the rules in the domain layer.
class GrowthService {
  GrowthService(this._ref);

  final Ref _ref;

  AppDatabase get _db => _ref.read(databaseProvider);
  HabitRepository get _habits => _ref.read(habitRepositoryProvider);
  RewardRepository get _rewards => _ref.read(rewardRepositoryProvider);
  VisionRepository get _visions => _ref.read(visionRepositoryProvider);
  FinanceRepository get _finance => _ref.read(financeRepositoryProvider);
  DateTime get _today => _ref.read(clockProvider)().dateOnly;

  Future<HabitHistory> _history() async {
    final recoveries = await _habits.recoveries();
    return HabitHistory(
      completions: await _habits.completions(),
      excuses: await _habits.excuses(),
      forgivenMisses: {
        for (final r in recoveries)
          for (final d in r.forgiven) (r.habitId, d),
      },
    );
  }

  // Missions

  /// Ticks [habit] for today and awards its XP (spec §1).
  Future<XpBreakdown?> completeMission(Habit habit) async {
    final today = _today;
    if (!habit.isScheduledOn(today)) return null;
    final before = await _history();
    if (before.isCompleted(habit.id, today)) return null;

    final habits = await _habits.habits();
    final profile = await _ref.read(profileRepositoryProvider).get();
    final currentMomentum = momentum(
      habits: habits,
      history: before,
      today: today,
      mode: profile.mode,
    );
    final completedToday = habits
        .where((h) => before.isCompleted(h.id, today))
        .length;
    final visions = await _visions.all();
    final linked = visions.any((v) => v.id == habit.visionId && !v.isCompleted);

    await _habits.setCompleted(habit.id, today, true);
    final after = await _history();
    final streak = after.streak(habit, today);
    final xp = xpForCompletion(
      baseXp: habit.baseXp,
      streak: streak,
      momentum: currentMomentum,
      linkedToVision: linked,
      completedToday: completedToday,
      habitAgeDays: habit.createdOn.daysUntil(today),
    );
    await _rewards.award(
      Reward(
        key: _completionKey(habit, today),
        currency: Currency.xp,
        kind: RewardKind.missionCompleted,
        amount: xp.xp,
        day: today,
        refId: habit.id,
        explanation: '"${habit.name}": ${xp.explanation}',
      ),
    );

    final milestone = close.streakMilestone(habit, streak, today);
    if (milestone != null) await _rewards.award(milestone);
    await _checkRecovery(habit, after);
    return xp;
  }

  /// Un-ticks a mission done today and withdraws today's awards for it.
  Future<void> undoMission(Habit habit) async {
    final today = _today;
    await _habits.setCompleted(habit.id, today, false);
    await _rewards.revoke(_completionKey(habit, today));
    final streakAward = (await _rewards.watchAll().first).where(
      (r) =>
          r.kind == RewardKind.streakMilestone &&
          r.refId == habit.id &&
          r.day == today,
    );
    for (final r in streakAward) {
      await _rewards.revoke(r.key);
    }
  }

  String _completionKey(Habit h, DateTime day) => dailyId('xp:${h.id}', day);

  Future<void> _checkRecovery(Habit habit, HabitHistory history) async {
    final active = (await _habits.recoveries()).where(
      (r) => r.habitId == habit.id && r.isActive,
    );
    for (final r in active) {
      if (!close.isRecoveryComplete(
        habit: habit,
        history: history,
        startedOn: r.startedOn,
        today: _today,
      )) {
        continue;
      }
      final forgiven = close.missesForgivenByRecovery(
        habit: habit,
        history: history,
        startedOn: r.startedOn,
      );
      await _habits.saveRecovery(
        Recovery(
          id: r.id,
          habitId: r.habitId,
          startedOn: r.startedOn,
          completedOn: _today,
          forgiven: forgiven.map((m) => m.$2).toSet(),
        ),
      );
      await _rewards.award(close.recoveryBonus(habit, r.startedOn));
    }
  }

  // Excuses

  Future<void> excuseToday(ExcuseReason reason, String? note) => _habits
      .setExcused(Excuse(day: _today, reason: reason, note: note), _today);

  Future<void> clearExcuse(DateTime day) => _habits.setExcused(null, day);

  // Day close

  /// Applies everything owed for days that ended since the app last ran:
  /// miss penalties, budget outcomes, perfect weeks, patterns and
  /// evolution DP. Safe to call repeatedly.
  Future<void> closePastDays() async {
    final today = _today;
    final yesterday = today.addDays(-1);
    final stored = await _db.meta(_closedThroughKey);
    if (stored == null) {
      await _db.setMeta(_closedThroughKey, isoDay(yesterday));
      return;
    }
    var day = parseDay(stored).addDays(1);
    // Cap catch-up at 60 days after a long absence.
    if (day.daysUntil(yesterday) > 60) day = yesterday.addDays(-60);

    final habits = await _habits.habits();
    final profile = await _ref.read(profileRepositoryProvider).get();
    final history = await _history();
    final settings = await _finance.settings();
    final expenses = await _finance.expenses();
    final savings = await _finance.savings();

    for (; !day.isAfter(yesterday); day = day.addDays(1)) {
      for (final p in close.missPenalties(
        habits: habits,
        history: history,
        day: day,
        today: today,
        mode: profile.mode,
      )) {
        await _rewards.award(p);
      }
      if (settings != null) {
        await _closeFinanceDay(settings, day, expenses, savings);
      }
      if (day.weekday == DateTime.sunday) {
        final week = close.perfectWeek(
          habits: habits,
          history: history,
          weekStart: day.weekStart,
          today: today,
        );
        if (week != null) await _rewards.award(week);
      }
      await _db.setMeta(_closedThroughKey, isoDay(day));
    }

    await _startRecoveries(habits, history, today);
    for (final h in habits) {
      final dp = evo.evolveSuccess(habit: h, history: history, today: today);
      if (dp != null) await _rewards.award(dp);
    }
    if (settings != null) await ensureBudgetWeek(settings);
  }

  Future<void> _closeFinanceDay(
    FinanceSettings settings,
    DateTime day,
    List<Expense> expenses,
    List<SavingsDeposit> savings,
  ) async {
    final weekStart = day.weekStart;
    final weekExpenses = expenses
        .where((e) => e.day.weekStart == weekStart)
        .toList();
    final tracked =
        weekExpenses.any((e) => e.day == day) ||
        savings.any((s) => s.day == day);
    final funBudget =
        await _finance.funBudgetFor(weekStart) ?? settings.funWeekly;
    // Only days with something logged count, so the reward is for tracking.
    if (tracked &&
        withinAllowance(
          settings: settings,
          funBudget: funBudget,
          weekExpenses: weekExpenses,
          day: day,
        )) {
      await _rewards.award(withinAllowanceReward(day));
    }
    if (day.weekday == DateTime.sunday &&
        settings.penaltiesEnabled &&
        funBudget < settings.funWeekly) {
      final funSpent = weekExpenses
          .where((e) => e.category == SpendCategory.fun)
          .fold(0, (s, e) => s + e.amount);
      if (funSpent <= funBudget) {
        await _rewards.award(budgetRecoveryReward(weekStart));
      }
    }
  }

  Future<void> _startRecoveries(
    List<Habit> habits,
    HabitHistory history,
    DateTime today,
  ) async {
    final active = (await _habits.recoveries())
        .where((r) => r.isActive)
        .map((r) => r.habitId)
        .toSet();
    for (final h in close.habitsWithMissPattern(
      habits: habits,
      history: history,
      today: today,
    )) {
      if (active.contains(h.id)) continue;
      await _habits.saveRecovery(
        Recovery(id: newId(), habitId: h.id, startedOn: today),
      );
    }
  }

  /// Fixes this week's fun budget, applying any opt-in overspend
  /// adjustment from last week (spec §11).
  Future<int> ensureBudgetWeek(FinanceSettings settings) async {
    final weekStart = _today.weekStart;
    final existing = await _finance.funBudgetFor(weekStart);
    if (existing != null) return existing;
    final lastWeek = weekStart.addDays(-7);
    final lastBudget =
        await _finance.funBudgetFor(lastWeek) ?? settings.funWeekly;
    final lastExpenses = (await _finance.expenses())
        .where((e) => e.day.weekStart == lastWeek)
        .toList();
    final budget = effectiveFunBudget(
      settings: settings,
      lastWeekExpenses: lastExpenses,
      lastWeekFunBudget: lastBudget,
    );
    await _finance.setFunBudget(weekStart, budget);
    return budget;
  }

  // Evolution

  Future<void> acceptEvolve(Habit habit) =>
      _habits.saveHabit(evo.evolve(habit, _today));

  Future<void> declineEvolve(Habit habit) =>
      _habits.saveHabit(habit.copyWith(evolveDeclinedOn: _today));

  Future<void> stepBack(Habit habit) => _habits.saveHabit(evo.stepBack(habit));

  // Visions

  /// Saves a new vision with its ambition fixed against completed visions.
  Future<void> createVision(Vision draft) async {
    final completed = (await _visions.all()).where((v) => v.isCompleted);
    await _visions.save(
      draft.copyWith(
        ambition: ambitionFor(
          category: draft.category,
          targetValue: draft.targetValue,
          unit: draft.unit,
          completed: completed,
        ),
      ),
    );
  }

  Future<void> completeMilestone(Vision vision, Milestone milestone) async {
    if (milestone.isDone) return;
    final updated = vision.copyWith(
      milestones: [
        for (final m in vision.milestones)
          m.id == milestone.id
              ? Milestone(
                  id: m.id,
                  title: m.title,
                  targetValue: m.targetValue,
                  completedOn: _today,
                )
              : m,
      ],
    );
    await _visions.save(updated);
    await _rewards.award(milestoneReward(updated, milestone, _today));
  }

  /// Completes [vision]. Its record and VP are permanent from now on.
  Future<void> completeVision(Vision vision) async {
    if (vision.isCompleted) return;
    await _visions.save(vision.copyWith(completedOn: _today));
    for (final r in completionRewards(vision, _today)) {
      await _rewards.award(r);
    }
  }
}

final growthServiceProvider = Provider(GrowthService.new);
