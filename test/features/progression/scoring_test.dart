import 'package:godkwests/core/time/day.dart';
import 'package:godkwests/features/missions/domain/excuse.dart';
import 'package:godkwests/features/missions/domain/habit.dart';
import 'package:godkwests/features/missions/domain/habit_history.dart';
import 'package:godkwests/features/progression/domain/accountability_mode.dart';
import 'package:godkwests/features/progression/domain/day_close.dart';
import 'package:godkwests/features/progression/domain/evolution.dart';
import 'package:godkwests/features/progression/domain/identity.dart';
import 'package:godkwests/features/progression/domain/levels.dart';
import 'package:godkwests/features/progression/domain/reward.dart';
import 'package:godkwests/features/progression/domain/scores.dart';
import 'package:godkwests/features/progression/domain/xp_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

/// Monday 2 November 2026.
final monday = DateTime.utc(2026, 11, 2);

Habit habit({
  String id = 'read',
  int baseXp = 2,
  Set<int> weekdays = const {1, 2, 3, 4, 5, 6, 7},
  DateTime? createdOn,
  int? target = 20,
  String? area,
  DateTime? evolvedOn,
  int? previousTarget,
}) => Habit(
  id: id,
  name: 'Read 20 pages',
  baseXp: baseXp,
  weekdays: weekdays,
  createdOn: createdOn ?? monday.addDays(-60),
  target: target,
  area: area,
  evolvedOn: evolvedOn,
  previousTarget: previousTarget,
);

/// Completions for [h] on each day in [from]..[to] except [skip].
Set<DateTime> doneDays(
  DateTime from,
  DateTime to, {
  Set<DateTime> skip = const {},
}) => {
  for (var d = from; !d.isAfter(to); d = d.addDays(1))
    if (!skip.contains(d)) d,
};

void main() {
  group('§2 levels', () {
    test('thresholds match the spec table', () {
      expect(xpToNextLevel(1), 20);
      expect(xpToNextLevel(2), 22);
      expect(xpToNextLevel(5), 31);
      expect(xpToNextLevel(10), 55);
      expect(xpToNextLevel(20), 172);
      expect(totalXpForLevel(5), 95);
      expect(totalXpForLevel(10), 294);
      expect(totalXpForLevel(20), 1267);
    });

    test('level is derived from total XP, so it can drop', () {
      expect(LevelProgress.fromTotalXp(0).level, 1);
      expect(LevelProgress.fromTotalXp(19).level, 1);
      expect(LevelProgress.fromTotalXp(20).level, 2);
      final p = LevelProgress.fromTotalXp(100);
      expect(p.level, 5);
      expect(p.xpIntoLevel, 5);
      expect(LevelProgress.fromTotalXp(94).level, 4);
      expect(LevelProgress.fromTotalXp(-10).level, 1);
    });
  });

  group('§1 XP', () {
    XpBreakdown xp({
      int streak = 1,
      int momentum = 0,
      bool linked = false,
      int completedToday = 0,
      int age = 30,
      int base = 2,
    }) => xpForCompletion(
      baseXp: base,
      streak: streak,
      momentum: momentum,
      linkedToVision: linked,
      completedToday: completedToday,
      habitAgeDays: age,
    );

    test('spec examples for "Read 20 pages"', () {
      expect(xp(streak: 0).xp, 2);
      final mid = xp(streak: 10, momentum: 60, linked: true);
      expect(mid.multiplier, closeTo(2.2, 1e-9));
      expect(mid.xp, 4);
      final peak = xp(streak: 30, momentum: 100, linked: true);
      expect(peak.multiplier, 3.0);
      expect(peak.xp, 6);
    });

    test('soft cap and new-habit halvings stack, minimum 1 XP', () {
      expect(xp(streak: 0, completedToday: 8).xp, 1);
      expect(xp(streak: 0, base: 4, completedToday: 8).xp, 2);
      expect(xp(streak: 0, base: 4, age: 1).xp, 2);
      expect(xp(streak: 0, base: 1, age: 0, completedToday: 9).xp, 1);
    });
  });

  group('§5 streak', () {
    test('counts back, skipping unscheduled days; today pending is ok', () {
      final h = habit(weekdays: {1, 3, 5}); // Mon/Wed/Fri
      final history = HabitHistory(
        completions: {
          'read': {
            monday.addDays(-10), // Fri
            monday.addDays(-7), // Mon
            monday.addDays(-5), // Wed
            monday.addDays(-3), // Fri
          },
        },
      );
      // Monday not done yet: streak counts from Friday.
      expect(history.streak(h, monday), 4);
    });

    test('a miss resets; an excuse pauses', () {
      final h = habit();
      final history = HabitHistory(
        completions: {
          'read': doneDays(
            monday.addDays(-6),
            monday,
            skip: {monday.addDays(-3)},
          ),
        },
      );
      expect(history.streak(h, monday), 3);
      final excused = HabitHistory(
        completions: history.completions,
        excuses: [Excuse(day: monday.addDays(-3), reason: ExcuseReason.sick)],
      );
      expect(excused.streak(h, monday), 6);
    });
  });

  group('§4 excuses', () {
    test('4 penalty-free excuses per month', () {
      final ledger = ExcuseLedger([
        for (var i = 1; i <= 6; i++)
          Excuse(day: DateTime.utc(2026, 11, i), reason: ExcuseReason.travel),
      ]);
      expect(ledger.allDays.length, 6);
      expect(ledger.penaltyFreeDays.length, 4);
      expect(
        ledger.penaltyFreeDays,
        isNot(contains(DateTime.utc(2026, 11, 5))),
      );
      expect(ledger.remainingIn(2026, 11), 0);
      expect(ledger.remainingIn(2026, 12), 4);
    });
  });

  group('§3 penalties', () {
    final h = habit();
    final day = monday.addDays(-1);
    final history = HabitHistory(completions: {'read': {}});

    test('XP lost per mode', () {
      expect(
        missPenalties(
          habits: [h],
          history: history,
          day: day,
          today: monday,
          mode: AccountabilityMode.gentle,
        ).single.amount,
        0,
      );
      expect(
        missPenalties(
          habits: [h],
          history: history,
          day: day,
          today: monday,
          mode: AccountabilityMode.balanced,
        ).single.amount,
        -1,
      );
      expect(AccountabilityMode.balanced.xpLossForMiss(3), 2);
      expect(
        missPenalties(
          habits: [h],
          history: history,
          day: day,
          today: monday,
          mode: AccountabilityMode.strict,
        ).single.amount,
        -2,
      );
    });

    test('no penalty for today, completed or penalty-free excused days', () {
      expect(
        missPenalties(
          habits: [h],
          history: HabitHistory(
            completions: {'read': {}},
            excuses: [Excuse(day: day, reason: ExcuseReason.sick)],
          ),
          day: day,
          today: monday,
          mode: AccountabilityMode.strict,
        ),
        isEmpty,
      );
      expect(
        missPenalties(
          habits: [h],
          history: history,
          day: monday,
          today: monday,
          mode: AccountabilityMode.strict,
        ),
        isEmpty,
      );
    });

    test('pattern after 3 misses in 7 days, recovery after 3 in a row', () {
      final misses = {
        monday.addDays(-6),
        monday.addDays(-4),
        monday.addDays(-2),
      };
      final history = HabitHistory(
        completions: {
          'read': doneDays(
            monday.addDays(-7),
            monday.addDays(-1),
            skip: misses,
          ),
        },
      );
      expect(
        habitsWithMissPattern(habits: [h], history: history, today: monday),
        [h],
      );

      final after = HabitHistory(
        completions: {
          'read': {
            ...history.completions['read']!,
            monday,
            monday.addDays(1),
            monday.addDays(2),
          },
        },
      );
      expect(
        isRecoveryComplete(
          habit: h,
          history: after,
          startedOn: monday,
          today: monday.addDays(1),
        ),
        isFalse,
      );
      expect(
        isRecoveryComplete(
          habit: h,
          history: after,
          startedOn: monday,
          today: monday.addDays(2),
        ),
        isTrue,
      );
      expect(
        missesForgivenByRecovery(habit: h, history: history, startedOn: monday),
        {for (final d in misses) ('read', d)},
      );
    });
  });

  group('§6 momentum and §7 discipline', () {
    test('perfect week is 100; nothing scheduled is 0', () {
      final h = habit();
      final history = HabitHistory(
        completions: {'read': doneDays(monday.addDays(-6), monday)},
      );
      expect(
        momentum(
          habits: [h],
          history: history,
          today: monday,
          mode: AccountabilityMode.balanced,
        ),
        100,
      );
      expect(
        momentum(
          habits: const [],
          history: history,
          today: monday,
          mode: AccountabilityMode.balanced,
        ),
        0,
      );
    });

    test('one miss: weighted rate minus the mode penalty', () {
      final h = habit();
      // Missed yesterday (weight 6); today pending is left out.
      final history = HabitHistory(
        completions: {'read': doneDays(monday.addDays(-6), monday.addDays(-2))},
      );
      // done weights 5+4+3+2+1 = 15 of 21 → 71%; balanced −10 → 61.
      expect(
        momentum(
          habits: [h],
          history: history,
          today: monday,
          mode: AccountabilityMode.balanced,
        ),
        61,
      );
      expect(
        momentum(
          habits: [h],
          history: history,
          today: monday,
          mode: AccountabilityMode.gentle,
        ),
        66,
      );
      final forgiven = HabitHistory(
        completions: history.completions,
        forgivenMisses: {('read', monday.addDays(-1))},
      );
      expect(
        momentum(
          habits: [h],
          history: forgiven,
          today: monday,
          mode: AccountabilityMode.strict,
        ),
        71,
      );
    });

    test('discipline over 30 days ignores excused days', () {
      final h = habit();
      final miss = monday.addDays(-5);
      final history = HabitHistory(
        completions: {
          'read': doneDays(monday.addDays(-29), monday, skip: {miss}),
        },
      );
      expect(disciplineScore(habits: [h], history: history, today: monday), 97);
      final excused = HabitHistory(
        completions: history.completions,
        excuses: [Excuse(day: miss, reason: ExcuseReason.emergency)],
      );
      expect(
        disciplineScore(habits: [h], history: excused, today: monday),
        100,
      );
    });
  });

  group('§8 DP', () {
    test('streak milestones are keyed once per habit and milestone', () {
      final h = habit();
      expect(streakMilestone(h, 6, monday), isNull);
      final r = streakMilestone(h, 7, monday)!;
      expect(r.currency, Currency.dp);
      expect(r.key, 'dp:streak:read:7');
    });

    test('perfect week only once the week is over', () {
      final h = habit();
      final lastWeek = monday.addDays(-7);
      final history = HabitHistory(
        completions: {'read': doneDays(lastWeek, monday.addDays(-1))},
      );
      expect(
        perfectWeek(
          habits: [h],
          history: history,
          weekStart: lastWeek,
          today: monday,
        )?.amount,
        1,
      );
      expect(
        perfectWeek(
          habits: [h],
          history: history,
          weekStart: monday,
          today: monday,
        ),
        isNull,
      );
    });
  });

  group('§9 evolution', () {
    test('offers Evolve at ≥90% over 14 days', () {
      final h = habit();
      final history = HabitHistory(
        completions: {
          'read': doneDays(
            monday.addDays(-14),
            monday.addDays(-1),
            skip: {monday.addDays(-3)},
          ),
        },
      );
      expect(
        evolutionAdvice(habit: h, history: history, today: monday),
        EvolutionAdvice.offerEvolve,
      );
      final evolved = evolve(h, monday);
      expect(evolved.target, 30);
      expect(evolved.baseXp, 3);
      expect(evolved.previousTarget, 20);
      expect(evolve(habit(baseXp: 5), monday).baseXp, 5);
    });

    test('not offered when young, declined recently, or below 90%', () {
      final full = HabitHistory(
        completions: {'read': doneDays(monday.addDays(-14), monday)},
      );
      expect(
        evolutionAdvice(
          habit: habit(createdOn: monday.addDays(-10)),
          history: full,
          today: monday,
        ),
        EvolutionAdvice.none,
      );
      expect(
        evolutionAdvice(
          habit: habit().copyWith(evolveDeclinedOn: monday.addDays(-5)),
          history: full,
          today: monday,
        ),
        EvolutionAdvice.none,
      );
      final weak = HabitHistory(
        completions: {
          'read': doneDays(
            monday.addDays(-14),
            monday,
            skip: {monday.addDays(-2), monday.addDays(-4)},
          ),
        },
      );
      expect(
        evolutionAdvice(habit: habit(), history: weak, today: monday),
        EvolutionAdvice.none,
      );
    });

    test('step back offered when under 60% in the first 7 days', () {
      final start = monday.addDays(-8);
      final h = evolve(habit(), start);
      final history = HabitHistory(
        completions: {
          'read': {start, start.addDays(1), start.addDays(2)},
        },
      );
      expect(
        evolutionAdvice(habit: h, history: history, today: monday),
        EvolutionAdvice.offerStepBack,
      );
      final back = stepBack(h);
      expect(back.target, 20);
      expect(back.baseXp, 2);
      expect(back.evolvedOn, isNull);
    });

    test('evolve success after 14 days at ≥90%', () {
      final start = monday.addDays(-14);
      final h = evolve(habit(), start);
      final history = HabitHistory(
        completions: {'read': doneDays(start, monday.addDays(-1))},
      );
      expect(
        evolveSuccess(habit: h, history: history, today: monday)?.amount,
        1,
      );
      expect(
        evolveSuccess(habit: h, history: history, today: monday.addDays(-1)),
        isNull,
      );
    });
  });

  group('§12 identity', () {
    test('area progress and life score average', () {
      final read = habit(area: 'Lifelong learning');
      final run = habit(id: 'run', area: 'Health & fitness');
      final history = HabitHistory(
        completions: {
          'read': doneDays(monday.addDays(-29), monday),
          'run': doneDays(monday.addDays(-29), monday.addDays(-15)),
        },
      );
      final p = identityProgress(
        areas: ['Lifelong learning', 'Health & fitness', 'Career'],
        habits: [read, run],
        history: history,
        today: monday,
        daysWithinAllowance: const {},
        daysTracked: const {},
      );
      expect(p['Lifelong learning'], 100);
      expect(p['Health & fitness'], 52); // 15 of 29 countable days
      expect(p['Career'], isNull);
      expect(lifeScore(p), 76);
    });
  });
}
