import 'dart:math';

import 'scoring_rules.dart';

/// XP needed to go from [level] to the next one (spec §2).
int xpToNextLevel(int level) => roundHalfUp(
  ScoringRules.firstLevelXp * pow(ScoringRules.levelGrowth, level - 1),
);

/// Total XP at which [level] starts.
int totalXpForLevel(int level) {
  var total = 0;
  for (var l = 1; l < level; l++) {
    total += xpToNextLevel(l);
  }
  return total;
}

class LevelProgress {
  const LevelProgress({
    required this.level,
    required this.xpIntoLevel,
    required this.xpForNextLevel,
  });

  /// Derived from total XP every time, so levels can go down (spec §2).
  factory LevelProgress.fromTotalXp(int totalXp) {
    var level = 1;
    var remaining = max(0, totalXp);
    while (remaining >= xpToNextLevel(level)) {
      remaining -= xpToNextLevel(level);
      level++;
    }
    return LevelProgress(
      level: level,
      xpIntoLevel: remaining,
      xpForNextLevel: xpToNextLevel(level),
    );
  }

  final int level;
  final int xpIntoLevel;
  final int xpForNextLevel;

  double get fraction => xpIntoLevel / xpForNextLevel;
}
