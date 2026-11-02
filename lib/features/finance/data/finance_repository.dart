import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/sync_columns.dart';
import '../../../core/time/day.dart';
import '../domain/finance.dart';

const _settingsId = 'me';

/// Budgets, expenses and savings. Stored in plain form on this device;
/// encrypted before syncing (docs/database.md).
class FinanceRepository {
  FinanceRepository(this._db);

  final AppDatabase _db;

  Stream<FinanceSettings?> watchSettings() =>
      (_db.select(_db.financeSettingsTable)
            ..where((s) => s.id.equals(_settingsId) & s.deleted.equals(false)))
          .watchSingleOrNull()
          .map((r) => r == null ? null : _settings(r));

  Future<FinanceSettings?> settings() async {
    final r =
        await (_db.select(
              _db.financeSettingsTable,
            )..where((s) => s.id.equals(_settingsId) & s.deleted.equals(false)))
            .getSingleOrNull();
    return r == null ? null : _settings(r);
  }

  FinanceSettings _settings(FinanceSettingsRow r) => FinanceSettings(
    essentialsWeekly: r.essentialsWeekly,
    funWeekly: r.funWeekly,
    dailySavingsTarget: r.dailySavingsTarget,
    penaltiesEnabled: r.penaltiesEnabled,
    currency: r.currency,
  );

  Future<void> saveSettings(FinanceSettings s) => _db
      .into(_db.financeSettingsTable)
      .insertOnConflictUpdate(
        FinanceSettingsTableCompanion.insert(
          id: _settingsId,
          updatedAt: DateTime.now(),
          dirty: const Value(true),
          essentialsWeekly: s.essentialsWeekly,
          funWeekly: s.funWeekly,
          dailySavingsTarget: s.dailySavingsTarget,
          penaltiesEnabled: Value(s.penaltiesEnabled),
          currency: Value(s.currency),
        ),
      );

  // Expenses

  Stream<List<Expense>> watchExpenses() =>
      (_db.select(_db.expenses)
            ..where((e) => e.deleted.equals(false))
            ..orderBy([(e) => OrderingTerm.desc(e.day)]))
          .watch()
          .map((rows) => rows.map(_expense).toList());

  Future<List<Expense>> expenses() async => (await (_db.select(
    _db.expenses,
  )..where((e) => e.deleted.equals(false))).get()).map(_expense).toList();

  Expense _expense(ExpenseRow r) => Expense(
    id: r.id,
    amount: r.amount,
    category: SpendCategory.values.byName(r.category),
    day: r.day.dateOnly,
    note: r.note,
  );

  Future<void> addExpense(Expense e) => _db
      .into(_db.expenses)
      .insertOnConflictUpdate(
        ExpensesCompanion.insert(
          id: e.id,
          updatedAt: DateTime.now(),
          dirty: const Value(true),
          amount: e.amount,
          category: e.category.name,
          day: e.day.dateOnly,
          note: Value(e.note),
        ),
      );

  Future<void> deleteExpense(String id) =>
      (_db.update(_db.expenses)..where((e) => e.id.equals(id))).write(
        ExpensesCompanion(
          deleted: const Value(true),
          dirty: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );

  // Savings

  Stream<List<SavingsDeposit>> watchSavings() =>
      (_db.select(_db.savingsDeposits)
            ..where((s) => s.deleted.equals(false))
            ..orderBy([(s) => OrderingTerm.desc(s.day)]))
          .watch()
          .map((rows) => rows.map(_deposit).toList());

  Future<List<SavingsDeposit>> savings() async => (await (_db.select(
    _db.savingsDeposits,
  )..where((s) => s.deleted.equals(false))).get()).map(_deposit).toList();

  SavingsDeposit _deposit(SavingsDepositRow r) => SavingsDeposit(
    id: r.id,
    amount: r.amount,
    day: r.day.dateOnly,
    visionId: r.visionId,
  );

  Future<void> addSaving(SavingsDeposit s) => _db
      .into(_db.savingsDeposits)
      .insertOnConflictUpdate(
        SavingsDepositsCompanion.insert(
          id: s.id,
          updatedAt: DateTime.now(),
          dirty: const Value(true),
          amount: s.amount,
          day: s.day.dateOnly,
          visionId: Value(s.visionId),
        ),
      );

  Future<void> deleteSaving(String id) =>
      (_db.update(_db.savingsDeposits)..where((e) => e.id.equals(id))).write(
        SavingsDepositsCompanion(
          deleted: const Value(true),
          dirty: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );

  // Weekly fun budget

  Stream<Map<DateTime, int>> watchBudgetWeeks() =>
      (_db.select(
        _db.budgetWeeks,
      )..where((w) => w.deleted.equals(false))).watch().map(
        (rows) => {for (final r in rows) r.weekStart.dateOnly: r.funBudget},
      );

  Future<int?> funBudgetFor(DateTime weekStart) async =>
      (await (_db.select(_db.budgetWeeks)..where(
                (w) => w.id.equals(isoDay(weekStart)) & w.deleted.equals(false),
              ))
              .getSingleOrNull())
          ?.funBudget;

  Future<void> setFunBudget(DateTime weekStart, int funBudget) => _db
      .into(_db.budgetWeeks)
      .insertOnConflictUpdate(
        BudgetWeeksCompanion.insert(
          id: isoDay(weekStart),
          updatedAt: DateTime.now(),
          dirty: const Value(true),
          weekStart: weekStart.dateOnly,
          funBudget: funBudget,
        ),
      );
}

final financeRepositoryProvider = Provider(
  (ref) => FinanceRepository(ref.watch(databaseProvider)),
);

final financeSettingsProvider = StreamProvider<FinanceSettings?>(
  (ref) => ref.watch(financeRepositoryProvider).watchSettings(),
);

final expensesProvider = StreamProvider<List<Expense>>(
  (ref) => ref.watch(financeRepositoryProvider).watchExpenses(),
);

final savingsProvider = StreamProvider<List<SavingsDeposit>>(
  (ref) => ref.watch(financeRepositoryProvider).watchSavings(),
);

final budgetWeeksProvider = StreamProvider<Map<DateTime, int>>(
  (ref) => ref.watch(financeRepositoryProvider).watchBudgetWeeks(),
);
