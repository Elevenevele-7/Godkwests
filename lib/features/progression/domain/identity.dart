import '../../../core/time/day.dart';
import '../../missions/domain/habit.dart';
import '../../missions/domain/habit_history.dart';
import 'scoring_rules.dart';

/// Growth area used for finance, measured from budget days instead of
/// habits (spec §12).
const financialResponsibility = 'Financial responsibility';

const suggestedAreas = [
  'Discipline',
  financialResponsibility,
  'Lifelong learning',
  'Health & fitness',
  'Relationships',
  'Career',
  'Mindfulness',
];

/// Progress per chosen area (0–100), or null when there's no data yet.
Map<String, int?> identityProgress({
  required List<String> areas,
  required Iterable<Habit> habits,
  required HabitHistory history,
  required DateTime today,
  required Set<DateTime> daysWithinAllowance,
  required Set<DateTime> daysTracked,
}) {
  final t = today.dateOnly;
  final from = t.addDays(-(ScoringRules.identityWindowDays - 1));
  return {
    for (final area in areas)
      area: area == financialResponsibility
          ? _financeProgress(from, t, daysWithinAllowance, daysTracked)
          : _percent(
              history.completionRate(
                habits.where((h) => h.area == area),
                from,
                t,
                t,
              ),
            ),
  };
}

int? _financeProgress(
  DateTime from,
  DateTime to,
  Set<DateTime> within,
  Set<DateTime> tracked,
) {
  final inWindow = tracked.where((d) => !d.isBefore(from) && !d.isAfter(to));
  if (inWindow.isEmpty) return null;
  return _percent(inWindow.where(within.contains).length / inWindow.length);
}

int? _percent(double? rate) => rate == null ? null : roundHalfUp(rate * 100);

/// Average of the areas that have data, or null.
int? lifeScore(Map<String, int?> progress) {
  final values = progress.values.whereType<int>().toList();
  if (values.isEmpty) return null;
  return roundHalfUp(values.reduce((a, b) => a + b) / values.length);
}
