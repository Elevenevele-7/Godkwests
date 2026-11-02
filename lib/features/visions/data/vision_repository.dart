import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/time/day.dart';
import '../domain/vision.dart';

class VisionRepository {
  VisionRepository(this._db);

  final AppDatabase _db;

  /// Re-reads visions whenever visions or milestones change.
  Stream<List<Vision>> watchAll() => _db
      .customSelect('SELECT 1', readsFrom: {_db.visions, _db.milestones})
      .watch()
      .asyncMap((_) => all());

  Future<List<Vision>> all() async => _combine(
    await (_db.select(
      _db.visions,
    )..where((v) => v.deleted.equals(false))).get(),
    await (_db.select(_db.milestones)
          ..where((m) => m.deleted.equals(false))
          ..orderBy([(m) => OrderingTerm.asc(m.position)]))
        .get(),
  );

  List<Vision> _combine(List<VisionRow> rows, List<MilestoneRow> ms) => [
    for (final r in rows)
      Vision(
        id: r.id,
        title: r.title,
        why: r.why,
        category: VisionCategory.values.byName(r.category),
        targetValue: r.targetValue,
        unit: r.unit,
        currentValue: r.currentValue,
        startedOn: r.startedOn.dateOnly,
        deadline: r.deadline.dateOnly,
        ambition: r.ambition,
        completedOn: r.completedOn?.dateOnly,
        milestones: [
          for (final m in ms.where((m) => m.visionId == r.id))
            Milestone(
              id: m.id,
              title: m.title,
              targetValue: m.targetValue,
              completedOn: m.completedOn?.dateOnly,
            ),
        ],
      ),
  ]..sort((a, b) => a.deadline.compareTo(b.deadline));

  Future<void> save(Vision v) => _db.transaction(() async {
    await _db
        .into(_db.visions)
        .insertOnConflictUpdate(
          VisionsCompanion.insert(
            id: v.id,
            updatedAt: DateTime.now(),
            dirty: const Value(true),
            title: v.title,
            why: Value(v.why),
            category: v.category.name,
            targetValue: Value(v.targetValue),
            unit: Value(v.unit),
            currentValue: Value(v.currentValue),
            startedOn: v.startedOn.dateOnly,
            deadline: v.deadline.dateOnly,
            ambition: Value(v.ambition),
            completedOn: Value(v.completedOn),
          ),
        );
    for (final (i, m) in v.milestones.indexed) {
      await _db
          .into(_db.milestones)
          .insertOnConflictUpdate(
            MilestonesCompanion.insert(
              id: m.id,
              updatedAt: DateTime.now(),
              dirty: const Value(true),
              visionId: v.id,
              title: m.title,
              targetValue: Value(m.targetValue),
              position: Value(i),
              completedOn: Value(m.completedOn),
            ),
          );
    }
  });

  /// Only unfinished visions can be deleted; completed ones are permanent.
  Future<void> delete(Vision v) async {
    if (v.isCompleted) return;
    await (_db.update(_db.visions)..where((r) => r.id.equals(v.id))).write(
      VisionsCompanion(
        deleted: const Value(true),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

final visionRepositoryProvider = Provider(
  (ref) => VisionRepository(ref.watch(databaseProvider)),
);

final visionsProvider = StreamProvider<List<Vision>>(
  (ref) => ref.watch(visionRepositoryProvider).watchAll(),
);
