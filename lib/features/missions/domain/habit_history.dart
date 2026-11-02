import 'dart:math';

import '../../../core/time/day.dart';
import 'excuse.dart';
import 'habit.dart';

/// Completions and excuses, with the day-by-day questions the scoring
/// rules ask of them (spec §5–§7).
class HabitHistory {
  HabitHistory({
    required this.completions,
    Iterable<Excuse> excuses = const [],
    this.forgivenMisses = const {},
  }) : excuses = ExcuseLedger(excuses);

  /// Habit id → days completed.
  final Map<String, Set<DateTime>> completions;
  final ExcuseLedger excuses;

  /// (habit id, day) misses forgiven by a completed recovery challenge.
  final Set<(String, DateTime)> forgivenMisses;

  bool isCompleted(String habitId, DateTime day) =>
      completions[habitId]?.contains(day.dateOnly) ?? false;

  bool isPenaltyFree(DateTime day) =>
      excuses.penaltyFreeDays.contains(day.dateOnly);

  /// A passed, scheduled, uncompleted day that isn't excused within the
  /// monthly allowance.
  bool isMiss(Habit habit, DateTime day, DateTime today) {
    final d = day.dateOnly;
    return d.isBefore(today.dateOnly) &&
        habit.isScheduledOn(d) &&
        !isCompleted(habit.id, d) &&
        !isPenaltyFree(d);
  }

  /// Whether this habit-day counts in completion rates: scheduled, not
  /// excused within the allowance, and either over or already completed.
  bool _counts(Habit habit, DateTime day, DateTime today) =>
      habit.isScheduledOn(day) &&
      !isPenaltyFree(day) &&
      (day.isBefore(today) || isCompleted(habit.id, day));

  /// Consecutive scheduled days completed, counting back from today.
  /// Unscheduled and excused days are skipped; a miss ends the streak.
  int streak(Habit habit, DateTime today) {
    final t = today.dateOnly;
    var day = t;
    var count = 0;
    final start = habit.createdOn.dateOnly;
    while (!day.isBefore(start)) {
      final skip =
          !habit.isScheduledOn(day) ||
          excuses.allDays.contains(day) ||
          (day == t && !isCompleted(habit.id, day));
      if (!skip) {
        if (!isCompleted(habit.id, day)) break;
        count++;
      }
      day = day.addDays(-1);
    }
    return count;
  }

  /// Share of countable scheduled days completed in [from]..[to] inclusive,
  /// or null when nothing was countable.
  double? completionRate(
    Iterable<Habit> habits,
    DateTime from,
    DateTime to,
    DateTime today,
  ) {
    var scheduled = 0;
    var done = 0;
    for (final h in habits) {
      for (var d = from.dateOnly; !d.isAfter(to.dateOnly); d = d.addDays(1)) {
        if (!_counts(h, d, today.dateOnly)) continue;
        scheduled++;
        if (isCompleted(h.id, d)) done++;
      }
    }
    return scheduled == 0 ? null : done / scheduled;
  }

  /// Unforgiven misses of [habit] in [from]..[to].
  int missCount(Habit habit, DateTime from, DateTime to, DateTime today) =>
      unforgivenMisses([habit], from, to, today);

  /// Unforgiven misses across [habits] in [from]..[to].
  int unforgivenMisses(
    Iterable<Habit> habits,
    DateTime from,
    DateTime to,
    DateTime today,
  ) {
    var n = 0;
    for (final h in habits) {
      for (var d = from.dateOnly; !d.isAfter(to.dateOnly); d = d.addDays(1)) {
        if (isMiss(h, d, today) && !forgivenMisses.contains((h.id, d))) n++;
      }
    }
    return n;
  }

  /// Longest run of consecutive completed scheduled days starting on or
  /// after [from], skipping excused and unscheduled days.
  int consecutiveFrom(Habit habit, DateTime from, DateTime today) {
    var best = 0;
    var run = 0;
    for (var d = from.dateOnly; !d.isAfter(today.dateOnly); d = d.addDays(1)) {
      if (!habit.isScheduledOn(d) || excuses.allDays.contains(d)) continue;
      if (isCompleted(habit.id, d)) {
        run++;
        best = max(best, run);
      } else if (d.isBefore(today.dateOnly)) {
        run = 0;
      }
    }
    return best;
  }
}
