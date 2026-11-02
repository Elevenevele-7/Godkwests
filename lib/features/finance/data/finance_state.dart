import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/clock.dart';
import '../../../core/time/day.dart';
import '../domain/finance.dart';
import 'finance_repository.dart';

class FinanceState {
  const FinanceState({
    required this.settings,
    required this.snapshot,
    required this.savedTotal,
    required this.savedToday,
    required this.weekExpenses,
    required this.daysTracked,
    required this.daysWithinAllowance,
    required this.funBudgetReduced,
  });

  final FinanceSettings settings;
  final BudgetSnapshot snapshot;
  final int savedTotal;
  final int savedToday;
  final List<Expense> weekExpenses;

  /// Days in the last 30 with any expense or saving logged.
  final Set<DateTime> daysTracked;
  final Set<DateTime> daysWithinAllowance;

  /// This week's fun budget was reduced by last week's overspend.
  final bool funBudgetReduced;

  bool get savedTodayTarget =>
      settings.dailySavingsTarget > 0 &&
      savedToday >= settings.dailySavingsTarget;
}

/// Null until the user sets up a budget.
final financeStateProvider = Provider<AsyncValue<FinanceState?>>((ref) {
  final settingsAsync = ref.watch(financeSettingsProvider);
  final expensesAsync = ref.watch(expensesProvider);
  final savingsAsync = ref.watch(savingsProvider);
  final weeksAsync = ref.watch(budgetWeeksProvider);
  for (final a in [settingsAsync, expensesAsync, savingsAsync, weeksAsync]) {
    if (a.hasError) return AsyncError(a.error!, a.stackTrace!);
    if (!a.hasValue) return const AsyncLoading();
  }
  final settings = settingsAsync.value;
  if (settings == null) return const AsyncData(null);

  final today = ref.watch(clockProvider)().dateOnly;
  final expenses = expensesAsync.value!;
  final savings = savingsAsync.value!;
  final weeks = weeksAsync.value!;

  int funBudgetFor(DateTime weekStart) =>
      weeks[weekStart] ?? settings.funWeekly;
  List<Expense> weekOf(DateTime weekStart) =>
      expenses.where((e) => e.day.weekStart == weekStart).toList();

  final weekStart = today.weekStart;
  final weekExpenses = weekOf(weekStart);
  final funBudget = funBudgetFor(weekStart);

  final tracked = <DateTime>{};
  final within = <DateTime>{};
  for (var age = 1; age <= 30; age++) {
    final d = today.addDays(-age);
    final logged =
        expenses.any((e) => e.day == d) || savings.any((s) => s.day == d);
    if (!logged) continue;
    tracked.add(d);
    if (withinAllowance(
      settings: settings,
      funBudget: funBudgetFor(d.weekStart),
      weekExpenses: weekOf(d.weekStart),
      day: d,
    )) {
      within.add(d);
    }
  }

  return AsyncData(
    FinanceState(
      settings: settings,
      snapshot: BudgetSnapshot.compute(
        settings: settings,
        funBudget: funBudget,
        weekExpenses: weekExpenses,
        today: today,
      ),
      savedTotal: savings.fold(0, (s, d) => s + d.amount),
      savedToday: savings
          .where((s) => s.day == today)
          .fold(0, (s, d) => s + d.amount),
      weekExpenses: weekExpenses,
      daysTracked: tracked,
      daysWithinAllowance: within,
      funBudgetReduced: funBudget < settings.funWeekly,
    ),
  );
});
