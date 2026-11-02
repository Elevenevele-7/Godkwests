import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/clock.dart';
import '../../../core/time/day.dart';
import '../../finance/data/finance_state.dart';
import '../../missions/data/habit_repository.dart';
import '../../missions/domain/habit.dart';
import '../../missions/domain/habit_history.dart';
import '../../profile/data/profile_repository.dart';
import '../../profile/domain/profile.dart';
import '../../visions/data/vision_repository.dart';
import '../domain/evolution.dart';
import '../domain/identity.dart';
import '../domain/levels.dart';
import '../domain/reward.dart';
import '../domain/scores.dart';
import '../domain/xp_calculator.dart';
import 'reward_repository.dart';

class MissionView {
  const MissionView({
    required this.habit,
    required this.done,
    required this.streak,
    required this.xp,
    required this.advice,
    required this.inRecovery,
  });

  final Habit habit;
  final bool done;
  final int streak;

  /// XP earned (if done) or that completing it now would earn.
  final int xp;
  final EvolutionAdvice advice;
  final bool inRecovery;
}

class GrowthState {
  const GrowthState({
    required this.profile,
    required this.today,
    required this.habits,
    required this.history,
    required this.totals,
    required this.level,
    required this.momentum,
    required this.discipline,
    required this.missions,
    required this.bestStreak,
    required this.identity,
    required this.lifeScore,
    required this.rewards,
    required this.excusedToday,
    required this.excusesLeft,
  });

  final Profile profile;
  final DateTime today;
  final List<Habit> habits;
  final HabitHistory history;
  final RewardTotals totals;
  final LevelProgress level;
  final int momentum;
  final int discipline;

  /// Today's scheduled missions.
  final List<MissionView> missions;
  final int bestStreak;
  final Map<String, int?> identity;
  final int? lifeScore;
  final List<Reward> rewards;
  final bool excusedToday;
  final int excusesLeft;

  int get missionsDone => missions.where((m) => m.done).length;
}

final growthStateProvider = Provider<AsyncValue<GrowthState>>((ref) {
  final inputs = (
    ref.watch(profileProvider),
    ref.watch(habitsProvider),
    ref.watch(completionsProvider),
    ref.watch(excusesProvider),
    ref.watch(recoveriesProvider),
    ref.watch(rewardsProvider),
    ref.watch(visionsProvider),
    ref.watch(financeStateProvider),
  );
  final all = <AsyncValue<Object?>>[
    inputs.$1,
    inputs.$2,
    inputs.$3,
    inputs.$4,
    inputs.$5,
    inputs.$6,
    inputs.$7,
    inputs.$8,
  ];
  for (final a in all) {
    if (a.hasError) return AsyncError(a.error!, a.stackTrace!);
    if (!a.hasValue) return const AsyncLoading();
  }

  final profile = inputs.$1.value!;
  final habits = inputs.$2.value!.where((h) => h.archivedOn == null).toList();
  final recoveries = inputs.$5.value!;
  final rewards = inputs.$6.value!;
  final visions = inputs.$7.value!;
  final finance = inputs.$8.value;
  final today = ref.watch(clockProvider)().dateOnly;

  final history = HabitHistory(
    completions: inputs.$3.value!,
    excuses: inputs.$4.value!,
    forgivenMisses: {
      for (final r in recoveries)
        for (final d in r.forgiven) (r.habitId, d),
    },
  );
  final totals = totalsOf(rewards);
  final currentMomentum = momentum(
    habits: habits,
    history: history,
    today: today,
    mode: profile.mode,
  );
  final activeVisionIds = visions
      .where((v) => !v.isCompleted)
      .map((v) => v.id)
      .toSet();
  final recovering = recoveries
      .where((r) => r.isActive)
      .map((r) => r.habitId)
      .toSet();

  final todays = habits.where((h) => h.isScheduledOn(today)).toList();
  final doneCount = todays
      .where((h) => history.isCompleted(h.id, today))
      .length;
  final xpByKey = {for (final r in rewards) r.key: r.amount};

  final missions = [
    for (final h in todays)
      () {
        final done = history.isCompleted(h.id, today);
        final streak = history.streak(h, today);
        final earned = xpByKey['xp:${h.id}:${dayKey(today)}'];
        return MissionView(
          habit: h,
          done: done,
          streak: streak,
          xp: done && earned != null
              ? earned
              : xpForCompletion(
                  baseXp: h.baseXp,
                  streak: streak + 1,
                  momentum: currentMomentum,
                  linkedToVision: activeVisionIds.contains(h.visionId),
                  completedToday: doneCount,
                  habitAgeDays: h.createdOn.daysUntil(today),
                ).xp,
          advice: evolutionAdvice(habit: h, history: history, today: today),
          inRecovery: recovering.contains(h.id),
        );
      }(),
  ];

  final identity = identityProgress(
    areas: profile.areas,
    habits: habits,
    history: history,
    today: today,
    daysWithinAllowance: finance?.daysWithinAllowance ?? const {},
    daysTracked: finance?.daysTracked ?? const {},
  );

  return AsyncData(
    GrowthState(
      profile: profile,
      today: today,
      habits: habits,
      history: history,
      totals: totals,
      level: LevelProgress.fromTotalXp(totals.xp),
      momentum: currentMomentum,
      discipline: disciplineScore(
        habits: habits,
        history: history,
        today: today,
      ),
      missions: missions,
      bestStreak: habits.fold(
        0,
        (best, h) =>
            history.streak(h, today) > best ? history.streak(h, today) : best,
      ),
      identity: identity,
      lifeScore: lifeScore(identity),
      rewards: rewards,
      excusedToday: history.excuses.allDays.contains(today),
      excusesLeft: history.excuses.remainingIn(today.year, today.month),
    ),
  );
});
