import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'tables.dart';

part 'app_database.g.dart';

/// The on-device database. Every read and write goes here first; the sync
/// service copies dirty rows to Supabase when online (docs/database.md).
@DriftDatabase(
  tables: [
    Profiles,
    Habits,
    Completions,
    Excuses,
    Rewards,
    Recoveries,
    Visions,
    Milestones,
    FinanceSettingsTable,
    Expenses,
    SavingsDeposits,
    BudgetWeeks,
    Books,
    Annotations,
    CouncilMessages,
    AppMeta,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'ascension'));

  @override
  int get schemaVersion => 1;

  Future<String?> meta(String key) async => (await (select(
    appMeta,
  )..where((m) => m.key.equals(key))).getSingleOrNull())?.value;

  Future<void> setMeta(String key, String value) => into(
    appMeta,
  ).insertOnConflictUpdate(AppMetaRow(key: key, value: value));
}

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
