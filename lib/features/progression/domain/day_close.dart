import '../../../core/time/day.dart';
import '../../missions/domain/habit.dart';
import '../../missions/domain/habit_history.dart';
import 'accountability_mode.dart';
import 'reward.dart';
import 'scoring_rules.dart';

/// Penalties for every miss on [day], once that day is over (spec §3).
List<Reward> missPenalties({
  required Iterable<Habit> habits,
  required HabitHistory history,
  required DateTime day,
  required DateTime today,
  required AccountabilityMode mode,
}) {
  final d = day.dateOnly;
  final overBudgetExcuse = history.excuses.allDays.contains(d);
  return [
    for (final h in habits)
      if (history.isMiss(h, d, today))
        Reward(
          key: 'miss:${h.id}:${dayKey(d)}',
          currency: Currency.xp,
          kind: RewardKind.missPenalty,
          amount: -mode.xpLossForMiss(h.baseXp),
          day: d,
          refId: h.id,
          explanation: [
            'Missed "${h.name}"',
            mode.xpLossForMiss(h.baseXp) == 0
                ? 'no XP lost (${mode.label} mode)'
                : '−${mode.xpLossForMiss(h.baseXp)} XP (${mode.label} mode)',
            'Momentum −${mode.momentumPenaltyPerMiss} for 7 days',
            if (overBudgetExcuse)
              'excused, but this month\'s ${ScoringRules.excusesPerMonth} '
                  'penalty-free excuses were used',
          ].join(' · '),
        ),
  ];
}

/// Habits with a miss pattern: 3+ misses in the 7 days before [today].
List<Habit> habitsWithMissPattern({
  required Iterable<Habit> habits,
  required HabitHistory history,
  required DateTime today,
}) {
  final t = today.dateOnly;
  return [
    for (final h in habits)
      if (history.missCount(
            h,
            t.addDays(-ScoringRules.patternWindowDays),
            t.addDays(-1),
            t,
          ) >=
          ScoringRules.patternMisses)
        h,
  ];
}

/// Whether a recovery challenge started on [startedOn] is complete: the
/// habit was done on 3 scheduled days in a row.
bool isRecoveryComplete({
  required Habit habit,
  required HabitHistory history,
  required DateTime startedOn,
  required DateTime today,
}) =>
    history.consecutiveFrom(habit, startedOn, today) >=
    ScoringRules.recoveryStreak;

/// Misses forgiven by a recovery started on [startedOn]: the habit's misses
/// in the pattern window before it.
Set<(String, DateTime)> missesForgivenByRecovery({
  required Habit habit,
  required HabitHistory history,
  required DateTime startedOn,
}) {
  final s = startedOn.dateOnly;
  return {
    for (
      var d = s.addDays(-ScoringRules.patternWindowDays);
      d.isBefore(s);
      d = d.addDays(1)
    )
      if (history.isMiss(habit, d, s)) (habit.id, d),
  };
}

Reward recoveryBonus(Habit habit, DateTime day) => Reward(
  key: 'recovery:${habit.id}:${dayKey(day)}',
  currency: Currency.xp,
  kind: RewardKind.recoveryBonus,
  amount: ScoringRules.recoveryBonusXp,
  day: day.dateOnly,
  refId: habit.id,
  explanation:
      'Recovered "${habit.name}": ${ScoringRules.recoveryStreak} days in a '
      'row. Earlier misses no longer drag Momentum.',
);

/// DP for a streak reaching a milestone (spec §8). Keyed per habit and
/// milestone, so each is awarded once.
Reward? streakMilestone(Habit habit, int streak, DateTime day) {
  if (!ScoringRules.streakMilestones.contains(streak)) return null;
  return Reward(
    key: 'dp:streak:${habit.id}:$streak',
    currency: Currency.dp,
    kind: RewardKind.streakMilestone,
    amount: 1,
    day: day.dateOnly,
    refId: habit.id,
    explanation: '$streak-day streak on "${habit.name}"',
  );
}

/// DP for a perfect Monday–Sunday week, once the week is over (spec §8).
Reward? perfectWeek({
  required Iterable<Habit> habits,
  required HabitHistory history,
  required DateTime weekStart,
  required DateTime today,
}) {
  final start = weekStart.dateOnly.weekStart;
  final end = start.addDays(6);
  if (!end.isBefore(today.dateOnly)) return null;
  final rate = history.completionRate(habits, start, end, today);
  if (rate != 1.0) return null;
  return Reward(
    key: 'dp:week:${dayKey(start)}',
    currency: Currency.dp,
    kind: RewardKind.perfectWeek,
    amount: 1,
    day: end,
    explanation: 'Perfect week starting ${dayKey(start)}',
  );
}
