import 'package:godkwests/core/clock.dart';
import 'package:godkwests/core/database/app_database.dart';
import 'package:godkwests/core/time/day.dart';
import 'package:godkwests/features/finance/data/finance_repository.dart';
import 'package:godkwests/features/finance/domain/finance.dart';
import 'package:godkwests/features/missions/data/habit_repository.dart';
import 'package:godkwests/features/missions/domain/habit.dart';
import 'package:godkwests/features/profile/data/profile_repository.dart';
import 'package:godkwests/features/profile/domain/profile.dart';
import 'package:godkwests/features/progression/data/growth_service.dart';
import 'package:godkwests/features/progression/data/reward_repository.dart';
import 'package:godkwests/features/progression/domain/accountability_mode.dart';
import 'package:godkwests/features/progression/domain/reward.dart';
import 'package:godkwests/features/visions/data/vision_repository.dart';
import 'package:godkwests/features/visions/domain/vision.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late AppDatabase db;
  late ProviderContainer container;
  var now = DateTime.utc(2026, 11, 2, 9); // Monday

  GrowthService service() => container.read(growthServiceProvider);
  RewardRepository rewards() => container.read(rewardRepositoryProvider);

  setUp(() async {
    now = DateTime.utc(2026, 11, 2, 9);
    db = AppDatabase(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
        clockProvider.overrideWithValue(() => now),
      ],
    );
    await container
        .read(profileRepositoryProvider)
        .save(const Profile(mode: AccountabilityMode.balanced));
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  Habit read({DateTime? createdOn}) => Habit(
    id: 'read',
    name: 'Read 20 pages',
    baseXp: 2,
    weekdays: const {1, 2, 3, 4, 5, 6, 7},
    createdOn: createdOn ?? DateTime.utc(2026, 10, 1),
    target: 20,
  );

  test('completing a mission awards XP once; undo withdraws it', () async {
    final h = read();
    await container.read(habitRepositoryProvider).saveHabit(h);
    await service().closePastDays();

    final xp = await service().completeMission(h);
    expect(xp!.xp, 2);
    expect(await service().completeMission(h), isNull);
    expect((await rewards().totals()).xp, 2);

    await service().undoMission(h);
    expect((await rewards().totals()).xp, 0);
  });

  test('new habits earn half XP', () async {
    final h = read(createdOn: now.dateOnly);
    await container.read(habitRepositoryProvider).saveHabit(h);
    expect((await service().completeMission(h))!.xp, 1);
  });

  test('closing missed days applies penalties without going below 0', () async {
    final h = read();
    final habits = container.read(habitRepositoryProvider);
    await habits.saveHabit(h);
    await service().closePastDays(); // first run: nothing owed
    await service().completeMission(h); // +2 on Monday

    now = now.add(const Duration(days: 4)); // Friday; Tue–Thu missed
    await service().closePastDays();

    final all = await rewards().watchAll().first;
    final misses = all.where((r) => r.kind == RewardKind.missPenalty);
    expect(misses.length, 3);
    // Balanced: −1 each, but XP floors at 0 after the second.
    expect((await rewards().totals()).xp, 0);

    // 3 misses in 7 days started a recovery challenge.
    final recoveries = await habits.recoveries();
    expect(recoveries.single.isActive, isTrue);

    // Running again changes nothing.
    await service().closePastDays();
    expect(
      (await rewards().watchAll().first)
          .where((r) => r.kind == RewardKind.missPenalty)
          .length,
      3,
    );
  });

  test('recovery completes after 3 days in a row', () async {
    final h = read(createdOn: now.dateOnly);
    final habits = container.read(habitRepositoryProvider);
    await habits.saveHabit(h);
    await service().closePastDays();
    now = now.add(const Duration(days: 4));
    await service().closePastDays();

    for (var i = 0; i < 3; i++) {
      await service().completeMission(h);
      now = now.add(const Duration(days: 1));
      await service().closePastDays();
    }
    final recovery = (await habits.recoveries()).single;
    expect(recovery.isActive, isFalse);
    // Missed Mon (created that day) to Thu.
    expect(recovery.forgiven.length, 4);
    final all = await rewards().watchAll().first;
    expect(all.where((r) => r.kind == RewardKind.recoveryBonus).length, 1);
  });

  test('vision milestones and completion award VP', () async {
    final s = service();
    await s.createVision(
      Vision(
        id: 'fund',
        title: 'Emergency fund',
        category: VisionCategory.finance,
        targetValue: 100000,
        unit: 'KSh',
        startedOn: DateTime.utc(2026, 11, 2),
        deadline: DateTime.utc(2027, 5, 2),
        milestones: const [Milestone(id: 'm1', title: '50k')],
      ),
    );
    var v = (await container.read(visionRepositoryProvider).all()).single;
    expect(v.ambition, 1.0);
    await s.completeMilestone(v, v.milestones.single);
    v = (await container.read(visionRepositoryProvider).all()).single;
    await s.completeVision(v);
    // 60 VP total: 30 milestone + 30 completion, + 15 on time.
    expect((await rewards().totals()).vp, 75);
  });

  test('a tracked day within the allowance earns +1 XP', () async {
    final finance = container.read(financeRepositoryProvider);
    await finance.saveSettings(
      const FinanceSettings(
        essentialsWeekly: 700,
        funWeekly: 350,
        dailySavingsTarget: 100,
      ),
    );
    await service().closePastDays();
    await finance.addExpense(
      Expense(
        id: 'e1',
        amount: 100,
        category: SpendCategory.essential,
        day: now.dateOnly,
      ),
    );
    now = now.add(const Duration(days: 2));
    await service().closePastDays();
    // Monday tracked and within; Tuesday nothing logged.
    expect((await rewards().totals()).xp, 1);
  });
}
