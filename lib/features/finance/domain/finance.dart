import 'dart:math';

import '../../../core/time/day.dart';
import '../../progression/domain/reward.dart';
import '../../progression/domain/scoring_rules.dart';

enum SpendCategory {
  essential('Essential'),
  fun('Fun');

  const SpendCategory(this.label);
  final String label;
}

/// Weekly budget settings (spec §11). Amounts are whole shillings.
class FinanceSettings {
  const FinanceSettings({
    required this.essentialsWeekly,
    required this.funWeekly,
    required this.dailySavingsTarget,
    this.penaltiesEnabled = false,
    this.currency = 'KSh',
  });

  final int essentialsWeekly;
  final int funWeekly;
  final int dailySavingsTarget;

  /// Opt-in overspend adjustment of the fun budget.
  final bool penaltiesEnabled;
  final String currency;
}

class Expense {
  const Expense({
    required this.id,
    required this.amount,
    required this.category,
    required this.day,
    this.note,
  });

  final String id;
  final int amount;
  final SpendCategory category;
  final DateTime day;
  final String? note;
}

class SavingsDeposit {
  const SavingsDeposit({
    required this.id,
    required this.amount,
    required this.day,
    this.visionId,
  });

  final String id;
  final int amount;
  final DateTime day;
  final String? visionId;
}

enum BudgetStatus {
  onTrack('On track'),
  overPace('Over pace'),
  overBudget('Over budget');

  const BudgetStatus(this.label);
  final String label;
}

/// This week's fun budget after any opt-in overspend adjustment from last
/// week: reduced by last week's fun overspend, never below 50%.
int effectiveFunBudget({
  required FinanceSettings settings,
  required Iterable<Expense> lastWeekExpenses,
  required int lastWeekFunBudget,
}) {
  if (!settings.penaltiesEnabled) return settings.funWeekly;
  final funSpent = _sum(lastWeekExpenses, SpendCategory.fun);
  final overspend = max(0, funSpent - lastWeekFunBudget);
  final floor = (settings.funWeekly * ScoringRules.funBudgetFloor).ceil();
  return max(floor, settings.funWeekly - overspend);
}

int _sum(Iterable<Expense> expenses, [SpendCategory? category]) => expenses
    .where((e) => category == null || e.category == category)
    .fold(0, (s, e) => s + e.amount);

/// Budget figures for the Financial Snapshot.
class BudgetSnapshot {
  BudgetSnapshot._({
    required this.weeklyBudget,
    required this.funBudget,
    required this.spent,
    required this.funSpent,
    required this.daysLeft,
    required this.dailyAllowance,
    required this.funToday,
    required this.status,
  });

  /// [weekExpenses] are this week's expenses; [funBudget] comes from
  /// [effectiveFunBudget].
  factory BudgetSnapshot.compute({
    required FinanceSettings settings,
    required int funBudget,
    required Iterable<Expense> weekExpenses,
    required DateTime today,
  }) {
    final t = today.dateOnly;
    final budget = settings.essentialsWeekly + funBudget;
    final spent = _sum(weekExpenses);
    final funSpent = _sum(weekExpenses, SpendCategory.fun);
    final daysLeft = 7 - (t.weekday - DateTime.monday);
    final elapsed = 7 - daysLeft + 1;
    final status = spent > budget
        ? BudgetStatus.overBudget
        : spent > budget * elapsed / 7
        ? BudgetStatus.overPace
        : BudgetStatus.onTrack;
    return BudgetSnapshot._(
      weeklyBudget: budget,
      funBudget: funBudget,
      spent: spent,
      funSpent: funSpent,
      daysLeft: daysLeft,
      dailyAllowance: max(0, (budget - spent) ~/ daysLeft),
      funToday: max(0, (funBudget - funSpent) ~/ daysLeft),
      status: status,
    );
  }

  final int weeklyBudget;
  final int funBudget;
  final int spent;
  final int funSpent;
  final int daysLeft;
  final int dailyAllowance;
  final int funToday;
  final BudgetStatus status;

  int get remaining => weeklyBudget - spent;
}

/// The allowance at the start of [day] and whether that day's spending
/// stayed within it.
bool withinAllowance({
  required FinanceSettings settings,
  required int funBudget,
  required Iterable<Expense> weekExpenses,
  required DateTime day,
}) {
  final d = day.dateOnly;
  final before = weekExpenses.where((e) => e.day.isBefore(d));
  final allowance = BudgetSnapshot.compute(
    settings: settings,
    funBudget: funBudget,
    weekExpenses: before,
    today: d,
  ).dailyAllowance;
  final spentThatDay = _sum(weekExpenses.where((e) => e.day.isSameDay(d)));
  return spentThatDay <= allowance;
}

/// The only finance fact that leaves the device: a day kept within its
/// allowance earns +1 XP (spec §11).
Reward withinAllowanceReward(DateTime day) => Reward(
  key: 'budget:${dayKey(day)}',
  currency: Currency.xp,
  kind: RewardKind.withinAllowance,
  amount: ScoringRules.withinAllowanceXp,
  day: day.dateOnly,
  explanation: 'Stayed within your daily allowance',
);

/// +2 XP for keeping a reduced fun budget for a whole week.
Reward budgetRecoveryReward(DateTime weekStart) => Reward(
  key: 'budget-recovery:${dayKey(weekStart)}',
  currency: Currency.xp,
  kind: RewardKind.budgetRecovery,
  amount: ScoringRules.budgetRecoveryXp,
  day: weekStart.dateOnly.addDays(6),
  explanation: 'Kept the reduced fun budget all week. Normal budget restored.',
);
