import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/sync_columns.dart';
import '../../../core/time/day.dart';
import '../domain/excuse.dart';
import '../domain/habit.dart';

class Recovery {
  const Recovery({
    required this.id,
    required this.habitId,
    required this.startedOn,
    this.completedOn,
    this.forgiven = const {},
  });

  final String id;
  final String habitId;
  final DateTime startedOn;
  final DateTime? completedOn;
  final Set<DateTime> forgiven;

  bool get isActive => completedOn == null;
}

/// Habits, completions, excuses and recovery challenges.
class HabitRepository {
  HabitRepository(this._db);

  final AppDatabase _db;

  // Habits

  Stream<List<Habit>> watchHabits() =>
      (_db.select(_db.habits)
            ..where((h) => h.deleted.equals(false))
            ..orderBy([(h) => OrderingTerm.asc(h.createdOn)]))
          .watch()
          .map((rows) => rows.map(_habit).toList());

  Future<List<Habit>> habits() async => (await (_db.select(
    _db.habits,
  )..where((h) => h.deleted.equals(false))).get()).map(_habit).toList();

  Future<void> saveHabit(Habit h) => _db
      .into(_db.habits)
      .insertOnConflictUpdate(
        HabitsCompanion.insert(
          id: h.id,
          updatedAt: DateTime.now(),
          dirty: const Value(true),
          name: h.name,
          baseXp: h.baseXp,
          weekdays: encodeWeekdays(h.weekdays),
          createdOn: h.createdOn.dateOnly,
          area: Value(h.area),
          visionId: Value(h.visionId),
          target: Value(h.target),
          unit: Value(h.unit),
          previousTarget: Value(h.previousTarget),
          previousBaseXp: Value(h.previousBaseXp),
          evolvedOn: Value(h.evolvedOn),
          evolveDeclinedOn: Value(h.evolveDeclinedOn),
          archivedOn: Value(h.archivedOn),
        ),
      );

  Habit _habit(HabitRow r) => Habit(
    id: r.id,
    name: r.name,
    baseXp: r.baseXp,
    weekdays: decodeWeekdays(r.weekdays),
    createdOn: r.createdOn.dateOnly,
    area: r.area,
    visionId: r.visionId,
    target: r.target,
    unit: r.unit,
    previousTarget: r.previousTarget,
    previousBaseXp: r.previousBaseXp,
    evolvedOn: r.evolvedOn?.dateOnly,
    evolveDeclinedOn: r.evolveDeclinedOn?.dateOnly,
    archivedOn: r.archivedOn?.dateOnly,
  );

  // Completions

  Stream<Map<String, Set<DateTime>>> watchCompletions() => (_db.select(
    _db.completions,
  )..where((c) => c.deleted.equals(false))).watch().map(_groupCompletions);

  Future<Map<String, Set<DateTime>>> completions() async => _groupCompletions(
    await (_db.select(
      _db.completions,
    )..where((c) => c.deleted.equals(false))).get(),
  );

  Map<String, Set<DateTime>> _groupCompletions(List<CompletionRow> rows) {
    final map = <String, Set<DateTime>>{};
    for (final r in rows) {
      map.putIfAbsent(r.habitId, () => {}).add(r.day.dateOnly);
    }
    return map;
  }

  Future<void> setCompleted(String habitId, DateTime day, bool done) => _db
      .into(_db.completions)
      .insertOnConflictUpdate(
        CompletionsCompanion.insert(
          id: dailyId(habitId, day),
          updatedAt: DateTime.now(),
          dirty: const Value(true),
          deleted: Value(!done),
          habitId: habitId,
          day: day.dateOnly,
        ),
      );

  // Excuses

  Stream<List<Excuse>> watchExcuses() =>
      (_db.select(_db.excuses)..where((e) => e.deleted.equals(false)))
          .watch()
          .map((rows) => rows.map(_excuse).toList());

  Future<List<Excuse>> excuses() async => (await (_db.select(
    _db.excuses,
  )..where((e) => e.deleted.equals(false))).get()).map(_excuse).toList();

  Excuse _excuse(ExcuseRow r) => Excuse(
    day: r.day.dateOnly,
    reason: ExcuseReason.values.byName(r.reason),
    note: r.note,
  );

  Future<void> setExcused(Excuse? excuse, DateTime day) => _db
      .into(_db.excuses)
      .insertOnConflictUpdate(
        ExcusesCompanion.insert(
          id: dailyId('excuse', day),
          updatedAt: DateTime.now(),
          dirty: const Value(true),
          deleted: Value(excuse == null),
          day: day.dateOnly,
          reason: (excuse?.reason ?? ExcuseReason.other).name,
          note: Value(excuse?.note),
        ),
      );

  // Recoveries

  Stream<List<Recovery>> watchRecoveries() =>
      (_db.select(_db.recoveries)..where((r) => r.deleted.equals(false)))
          .watch()
          .map((rows) => rows.map(_recovery).toList());

  Future<List<Recovery>> recoveries() async => (await (_db.select(
    _db.recoveries,
  )..where((r) => r.deleted.equals(false))).get()).map(_recovery).toList();

  Recovery _recovery(RecoveryRow r) => Recovery(
    id: r.id,
    habitId: r.habitId,
    startedOn: r.startedOn.dateOnly,
    completedOn: r.completedOn?.dateOnly,
    forgiven: (jsonDecode(r.forgiven) as List)
        .cast<String>()
        .map(parseDay)
        .toSet(),
  );

  Future<void> saveRecovery(Recovery r) => _db
      .into(_db.recoveries)
      .insertOnConflictUpdate(
        RecoveriesCompanion.insert(
          id: r.id,
          updatedAt: DateTime.now(),
          dirty: const Value(true),
          habitId: r.habitId,
          startedOn: r.startedOn.dateOnly,
          completedOn: Value(r.completedOn),
          forgiven: Value(jsonEncode(r.forgiven.map(isoDay).toList())),
        ),
      );
}

final habitRepositoryProvider = Provider(
  (ref) => HabitRepository(ref.watch(databaseProvider)),
);

final habitsProvider = StreamProvider<List<Habit>>(
  (ref) => ref.watch(habitRepositoryProvider).watchHabits(),
);

final completionsProvider = StreamProvider<Map<String, Set<DateTime>>>(
  (ref) => ref.watch(habitRepositoryProvider).watchCompletions(),
);

final excusesProvider = StreamProvider<List<Excuse>>(
  (ref) => ref.watch(habitRepositoryProvider).watchExcuses(),
);

final recoveriesProvider = StreamProvider<List<Recovery>>(
  (ref) => ref.watch(habitRepositoryProvider).watchRecoveries(),
);
