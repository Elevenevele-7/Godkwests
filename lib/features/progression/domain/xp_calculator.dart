import 'dart:math';

import 'scoring_rules.dart';

class XpBreakdown {
  const XpBreakdown({
    required this.baseXp,
    required this.streakBonus,
    required this.momentumBonus,
    required this.visionBonus,
    required this.multiplier,
    required this.halvings,
    required this.xp,
  });

  final int baseXp;
  final double streakBonus;
  final double momentumBonus;
  final double visionBonus;
  final double multiplier;

  /// Why XP was halved, e.g. "new habit", "daily soft cap".
  final List<String> halvings;
  final int xp;

  String get explanation {
    final parts = <String>[
      '$baseXp base × ${multiplier.toStringAsFixed(2)}',
      if (streakBonus > 0) 'streak +${streakBonus.toStringAsFixed(2)}',
      if (momentumBonus > 0) 'momentum +${momentumBonus.toStringAsFixed(2)}',
      if (visionBonus > 0) 'vision +${visionBonus.toStringAsFixed(2)}',
      ...halvings.map((h) => 'halved: $h'),
    ];
    return parts.join(', ');
  }
}

/// XP for completing one mission (spec §1).
///
/// [streak] is the habit's streak *including* this completion,
/// [completedToday] the number of missions already completed today before
/// this one, and [habitAgeDays] days since the habit was created.
XpBreakdown xpForCompletion({
  required int baseXp,
  required int streak,
  required int momentum,
  required bool linkedToVision,
  required int completedToday,
  required int habitAgeDays,
}) {
  final streakBonus = min(
    streak * ScoringRules.streakBonusPerDay,
    ScoringRules.maxStreakBonus,
  );
  final momentumBonus =
      ScoringRules.maxMomentumBonus * momentum.clamp(0, 100) / 100;
  final visionBonus = linkedToVision ? ScoringRules.visionBonus : 0.0;
  final multiplier = min(
    1 + streakBonus + momentumBonus + visionBonus,
    ScoringRules.maxMultiplier,
  );

  var xp = baseXp * multiplier;
  final halvings = <String>[];
  if (completedToday >= ScoringRules.softCapMissionsPerDay) {
    xp /= 2;
    halvings.add(
      'more than ${ScoringRules.softCapMissionsPerDay} missions today',
    );
  }
  if (habitAgeDays < ScoringRules.newHabitDays) {
    xp /= 2;
    halvings.add('new habit (first ${ScoringRules.newHabitDays} days)');
  }

  return XpBreakdown(
    baseXp: baseXp,
    streakBonus: streakBonus,
    momentumBonus: momentumBonus,
    visionBonus: visionBonus,
    multiplier: multiplier,
    halvings: halvings,
    xp: max(1, roundHalfUp(xp)),
  );
}
