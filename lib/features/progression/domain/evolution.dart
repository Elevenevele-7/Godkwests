import '../../../core/time/day.dart';
import '../../missions/domain/habit.dart';
import '../../missions/domain/habit_history.dart';
import 'reward.dart';
import 'scoring_rules.dart';

enum EvolutionAdvice { none, offerEvolve, offerStepBack }

/// What the Challenge & Evolution system suggests for [habit] today
/// (spec §9).
EvolutionAdvice evolutionAdvice({
  required Habit habit,
  required HabitHistory history,
  required DateTime today,
}) {
  final t = today.dateOnly;

  if (habit.evolvedOn != null) {
    final since = habit.evolvedOn!.daysUntil(t);
    if (since >= ScoringRules.stepBackWindowDays &&
        since < ScoringRules.evolveSuccessDays &&
        habit.previousTarget != null) {
      final rate = history.completionRate(
        [habit],
        habit.evolvedOn!,
        habit.evolvedOn!.addDays(ScoringRules.stepBackWindowDays - 1),
        t,
      );
      if (rate != null && rate < ScoringRules.stepBackThreshold) {
        return EvolutionAdvice.offerStepBack;
      }
    }
    if (since < ScoringRules.evolveRetryDays) return EvolutionAdvice.none;
  }

  if (habit.target == null) return EvolutionAdvice.none;
  if (habit.createdOn.daysUntil(t) < ScoringRules.evolveMinAgeDays) {
    return EvolutionAdvice.none;
  }
  if (habit.evolveDeclinedOn != null &&
      habit.evolveDeclinedOn!.daysUntil(t) < ScoringRules.evolveRetryDays) {
    return EvolutionAdvice.none;
  }
  final rate = history.completionRate(
    [habit],
    t.addDays(-ScoringRules.evolveWindowDays),
    t.addDays(-1),
    t,
  );
  return rate != null && rate >= ScoringRules.evolveThreshold
      ? EvolutionAdvice.offerEvolve
      : EvolutionAdvice.none;
}

/// The harder version offered by Evolve: target × 1.5 (rounded up) and
/// base XP + 1, max 5.
Habit evolve(Habit habit, DateTime today) => habit.copyWith(
  previousTarget: habit.target,
  previousBaseXp: habit.baseXp,
  target: (habit.target! * ScoringRules.evolveTargetFactor).ceil(),
  baseXp: (habit.baseXp + 1).clamp(
    ScoringRules.minBaseXp,
    ScoringRules.maxBaseXp,
  ),
  evolvedOn: today.dateOnly,
);

/// Returns to the pre-Evolve target and XP, with no penalty.
Habit stepBack(Habit habit) => habit.copyWith(
  target: habit.previousTarget,
  baseXp: habit.previousBaseXp,
  clearEvolution: true,
);

/// +1 DP when an evolved target was held at ≥90% for its first 14 days.
Reward? evolveSuccess({
  required Habit habit,
  required HabitHistory history,
  required DateTime today,
}) {
  final evolvedOn = habit.evolvedOn;
  if (evolvedOn == null) return null;
  if (evolvedOn.daysUntil(today) < ScoringRules.evolveSuccessDays) {
    return null;
  }
  final rate = history.completionRate(
    [habit],
    evolvedOn,
    evolvedOn.addDays(ScoringRules.evolveSuccessDays - 1),
    today,
  );
  if (rate == null || rate < ScoringRules.evolveThreshold) return null;
  return Reward(
    key: 'dp:evolve:${habit.id}:${dayKey(evolvedOn)}',
    currency: Currency.dp,
    kind: RewardKind.evolveSuccess,
    amount: 1,
    day: today.dateOnly,
    refId: habit.id,
    explanation:
        'Held the evolved "${habit.name}" target for '
        '${ScoringRules.evolveSuccessDays} days',
  );
}
