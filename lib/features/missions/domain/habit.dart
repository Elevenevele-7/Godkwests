import '../../../core/time/day.dart';

/// A recurring commitment. Each scheduled day it becomes one of the day's
/// missions.
class Habit {
  const Habit({
    required this.id,
    required this.name,
    required this.baseXp,
    required this.weekdays,
    required this.createdOn,
    this.area,
    this.visionId,
    this.target,
    this.unit,
    this.previousTarget,
    this.previousBaseXp,
    this.evolvedOn,
    this.evolveDeclinedOn,
    this.archivedOn,
  });

  final String id;
  final String name;

  /// 1–5, from the habit's difficulty.
  final int baseXp;

  /// Days of the week it's scheduled, using [DateTime.monday]..[DateTime.sunday].
  final Set<int> weekdays;
  final DateTime createdOn;

  /// Growth area this habit counts toward (identity progress).
  final String? area;
  final String? visionId;

  /// Optional measurable target, e.g. 20 (pages).
  final int? target;
  final String? unit;

  /// Values before the last Evolve, so the user can step back.
  final int? previousTarget;
  final int? previousBaseXp;
  final DateTime? evolvedOn;
  final DateTime? evolveDeclinedOn;
  final DateTime? archivedOn;

  bool get isDaily => weekdays.length == 7;

  bool isScheduledOn(DateTime day) {
    final d = day.dateOnly;
    if (d.isBefore(createdOn.dateOnly)) return false;
    if (archivedOn != null && !d.isBefore(archivedOn!.dateOnly)) return false;
    return weekdays.contains(d.weekday);
  }

  /// Display label such as "Read 20 pages".
  String get missionLabel => name;

  Habit copyWith({
    String? name,
    int? baseXp,
    Set<int>? weekdays,
    String? area,
    String? visionId,
    bool clearVision = false,
    int? target,
    String? unit,
    int? previousTarget,
    int? previousBaseXp,
    DateTime? evolvedOn,
    DateTime? evolveDeclinedOn,
    DateTime? archivedOn,
    bool clearEvolution = false,
  }) => Habit(
    id: id,
    name: name ?? this.name,
    baseXp: baseXp ?? this.baseXp,
    weekdays: weekdays ?? this.weekdays,
    createdOn: createdOn,
    area: area ?? this.area,
    visionId: clearVision ? null : (visionId ?? this.visionId),
    target: target ?? this.target,
    unit: unit ?? this.unit,
    previousTarget: clearEvolution
        ? null
        : (previousTarget ?? this.previousTarget),
    previousBaseXp: clearEvolution
        ? null
        : (previousBaseXp ?? this.previousBaseXp),
    evolvedOn: clearEvolution ? null : (evolvedOn ?? this.evolvedOn),
    evolveDeclinedOn: evolveDeclinedOn ?? this.evolveDeclinedOn,
    archivedOn: archivedOn ?? this.archivedOn,
  );
}
