import 'package:ascension/core/time/day.dart';
import 'package:ascension/features/finance/domain/finance.dart';
import 'package:ascension/features/visions/domain/vision.dart';
import 'package:ascension/features/visions/domain/vision_points.dart';
import 'package:flutter_test/flutter_test.dart';

final monday = DateTime.utc(2026, 11, 2);

void main() {
  group('§10 Vision Points', () {
    Vision fund({
      String id = 'v1',
      double target = 100000,
      double? ambition,
      DateTime? completedOn,
      List<Milestone> milestones = const [],
    }) => Vision(
      id: id,
      title: 'Emergency fund',
      category: VisionCategory.finance,
      targetValue: target,
      unit: 'KSh',
      startedOn: DateTime.utc(2026, 1, 1),
      deadline: DateTime.utc(2026, 7, 1),
      ambition: ambition,
      completedOn: completedOn,
      milestones: milestones,
    );

    test('spec example: 60 VP first, 90 VP for a bigger next one', () {
      expect(
        monthsPlanned(DateTime.utc(2026, 1, 1), DateTime.utc(2026, 7, 1)),
        6,
      );
      expect(visionVp(fund()), 60);
      final done = fund(completedOn: DateTime.utc(2026, 6, 1));
      final higher = ambitionFor(
        category: VisionCategory.finance,
        targetValue: 200000,
        unit: 'KSh',
        completed: [done],
      );
      expect(higher, 1.5);
      expect(visionVp(fund(id: 'v2', target: 200000, ambition: higher)), 90);
      expect(
        ambitionFor(
          category: VisionCategory.finance,
          targetValue: 100000,
          unit: 'KSh',
          completed: [done],
        ),
        0.5,
      );
      expect(
        ambitionFor(
          category: VisionCategory.health,
          targetValue: 100000,
          unit: 'KSh',
          completed: [done],
        ),
        1.0,
      );
    });

    test('milestones share the VP; completion adds the rest + on-time', () {
      final v = fund(
        milestones: [
          Milestone(
            id: 'm1',
            title: '25k',
            completedOn: DateTime.utc(2026, 2, 1),
          ),
          Milestone(
            id: 'm2',
            title: '50k',
            completedOn: DateTime.utc(2026, 3, 1),
          ),
          const Milestone(id: 'm3', title: '75k'),
        ],
      );
      expect(milestoneVp(v), 15);
      final onTime = completionRewards(v, DateTime.utc(2026, 6, 30));
      expect(onTime.map((r) => r.amount), [30, 15]);
      final late = completionRewards(v, DateTime.utc(2026, 7, 2));
      expect(late.map((r) => r.amount), [30]);
    });
  });

  group('§11 finance', () {
    const settings = FinanceSettings(
      essentialsWeekly: 700,
      funWeekly: 350,
      dailySavingsTarget: 100,
      penaltiesEnabled: true,
    );

    test('daily allowance and fun today on Wednesday', () {
      final wed = monday.addDays(2);
      final snap = BudgetSnapshot.compute(
        settings: settings,
        funBudget: 350,
        weekExpenses: [
          Expense(
            id: '1',
            amount: 200,
            category: SpendCategory.essential,
            day: monday,
          ),
          Expense(
            id: '2',
            amount: 100,
            category: SpendCategory.fun,
            day: monday.addDays(1),
          ),
        ],
        today: wed,
      );
      expect(snap.daysLeft, 5);
      expect(snap.dailyAllowance, 150); // (1050 − 300) / 5
      expect(snap.funToday, 50); // (350 − 100) / 5
      expect(snap.status, BudgetStatus.onTrack);
    });

    test('status: over pace and over budget', () {
      BudgetStatus statusFor(int spent) => BudgetSnapshot.compute(
        settings: settings,
        funBudget: 350,
        weekExpenses: [
          Expense(
            id: '1',
            amount: spent,
            category: SpendCategory.essential,
            day: monday,
          ),
        ],
        today: monday,
      ).status;
      expect(statusFor(150), BudgetStatus.onTrack);
      expect(statusFor(151), BudgetStatus.overPace);
      expect(statusFor(1051), BudgetStatus.overBudget);
    });

    test('opt-in overspend shrinks next week, never below 50%', () {
      List<Expense> fun(int amount) => [
        Expense(
          id: 'f',
          amount: amount,
          category: SpendCategory.fun,
          day: monday,
        ),
      ];
      expect(
        effectiveFunBudget(
          settings: settings,
          lastWeekExpenses: fun(500),
          lastWeekFunBudget: 350,
        ),
        200,
      );
      expect(
        effectiveFunBudget(
          settings: settings,
          lastWeekExpenses: fun(900),
          lastWeekFunBudget: 350,
        ),
        175,
      );
      expect(
        effectiveFunBudget(
          settings: const FinanceSettings(
            essentialsWeekly: 700,
            funWeekly: 350,
            dailySavingsTarget: 0,
          ),
          lastWeekExpenses: fun(900),
          lastWeekFunBudget: 350,
        ),
        350,
      );
    });

    test('within allowance is judged against the allowance that morning', () {
      final expenses = [
        Expense(
          id: '1',
          amount: 150,
          category: SpendCategory.essential,
          day: monday,
        ),
        Expense(
          id: '2',
          amount: 200,
          category: SpendCategory.fun,
          day: monday.addDays(1),
        ),
      ];
      expect(
        withinAllowance(
          settings: settings,
          funBudget: 350,
          weekExpenses: expenses,
          day: monday,
        ),
        isTrue,
      );
      // Tuesday allowance: (1050 − 150) / 6 = 150; spent 200.
      expect(
        withinAllowance(
          settings: settings,
          funBudget: 350,
          weekExpenses: expenses,
          day: monday.addDays(1),
        ),
        isFalse,
      );
    });
  });
}
