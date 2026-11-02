import '../../../core/time/day.dart';
import '../../missions/domain/habit.dart';
import '../../missions/domain/habit_history.dart';
import 'accountability_mode.dart';
import 'scoring_rules.dart';

/// Momentum, 0–100 (spec §6).
int momentum({
  required Iterable<Habit> habits,
  required HabitHistory history,
  required DateTime today,
  required AccountabilityMode mode,
}) {
  final t = today.dateOnly;
  const window = ScoringRules.momentumWindowDays;
  var weighted = 0.0;
  var weightedDone = 0.0;
  for (var age = 0; age < window; age++) {
    final day = t.addDays(-age);
    final weight = window - age;
    for (final h in habits) {
      if (!h.isScheduledOn(day) || history.isPenaltyFree(day)) continue;
      final done = history.isCompleted(h.id, day);
      if (age == 0 && !done) continue; // today isn't over yet
      weighted += weight;
      if (done) weightedDone += weight;
    }
  }
  if (weighted == 0) return 0;

  final misses = history.unforgivenMisses(
    habits,
    t.addDays(-(window - 1)),
    t,
    t,
  );
  final raw =
      roundHalfUp(100 * weightedDone / weighted) -
      misses * mode.momentumPenaltyPerMiss;
  return raw.clamp(0, 100);
}

/// Discipline Score, 0–100: share of scheduled habit-days completed over the
/// last 30 days, excused days left out (spec §7).
int disciplineScore({
  required Iterable<Habit> habits,
  required HabitHistory history,
  required DateTime today,
}) {
  final t = today.dateOnly;
  final rate = history.completionRate(
    habits,
    t.addDays(-(ScoringRules.disciplineWindowDays - 1)),
    t,
    t,
  );
  return rate == null ? 0 : roundHalfUp(rate * 100);
}
