import '../../progression/domain/scoring_rules.dart';

enum ExcuseReason { sick, travel, emergency, other }

/// A day marked as excused (spec §4).
class Excuse {
  const Excuse({required this.day, required this.reason, this.note});

  final DateTime day;
  final ExcuseReason reason;
  final String? note;
}

/// Splits excused days into those within the monthly allowance (no
/// penalties) and the rest (streak pauses, penalties still apply).
class ExcuseLedger {
  ExcuseLedger(Iterable<Excuse> excuses) {
    final sorted = [...excuses]..sort((a, b) => a.day.compareTo(b.day));
    final perMonth = <(int, int), int>{};
    for (final e in sorted) {
      allDays.add(e.day);
      final month = (e.day.year, e.day.month);
      final used = perMonth[month] ?? 0;
      if (used < ScoringRules.excusesPerMonth) penaltyFreeDays.add(e.day);
      perMonth[month] = used + 1;
    }
  }

  final Set<DateTime> allDays = {};
  final Set<DateTime> penaltyFreeDays = {};

  int remainingIn(int year, int month) {
    final used = allDays
        .where((d) => d.year == year && d.month == month)
        .length;
    return (ScoringRules.excusesPerMonth - used).clamp(
      0,
      ScoringRules.excusesPerMonth,
    );
  }
}
