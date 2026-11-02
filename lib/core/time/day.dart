/// Calendar-day helpers. The app reasons in whole local days; dates are kept
/// as UTC midnight values so day arithmetic is safe across daylight saving.
extension DayX on DateTime {
  /// This date with the time removed.
  DateTime get dateOnly => DateTime.utc(year, month, day);

  DateTime addDays(int n) => DateTime.utc(year, month, day + n);

  /// Monday of this date's week.
  DateTime get weekStart => addDays(-(weekday - DateTime.monday));

  /// Whole days from this date to [other] (negative if [other] is earlier).
  int daysUntil(DateTime other) => other.dateOnly.difference(dateOnly).inDays;

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}

/// Today's local date.
DateTime currentDay() => DateTime.now().dateOnly;
