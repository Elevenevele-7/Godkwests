/// Every tunable number from docs/scoring-spec.md. Change values here, not
/// in the engines, and update the spec and tests together.
abstract final class ScoringRules {
  // §1 XP
  static const minBaseXp = 1;
  static const maxBaseXp = 5;
  static const streakBonusPerDay = 0.04;
  static const maxStreakBonus = 1.0;
  static const maxMomentumBonus = 0.5;
  static const visionBonus = 0.5;
  static const maxMultiplier = 3.0;
  static const softCapMissionsPerDay = 8;
  static const newHabitDays = 3;

  // §2 Levels
  static const firstLevelXp = 20;
  static const levelGrowth = 1.12;

  // §3 Penalties and recovery
  static const patternWindowDays = 7;
  static const patternMisses = 3;
  static const recoveryStreak = 3;
  static const recoveryBonusXp = 2;

  // §4 Excused days
  static const excusesPerMonth = 4;

  // §6 Momentum, §7 Discipline
  static const momentumWindowDays = 7;
  static const disciplineWindowDays = 30;

  // §8 DP
  static const streakMilestones = [7, 30, 100, 365];

  // §9 Evolution
  static const evolveMinAgeDays = 14;
  static const evolveWindowDays = 14;
  static const evolveThreshold = 0.9;
  static const evolveTargetFactor = 1.5;
  static const evolveRetryDays = 14;
  static const stepBackWindowDays = 7;
  static const stepBackThreshold = 0.6;
  static const evolveSuccessDays = 14;

  // §10 VP
  static const vpPerMonth = 10;
  static const ambitionFirst = 1.0;
  static const ambitionHigher = 1.5;
  static const ambitionRepeat = 0.5;
  static const onTimeBonus = 0.25;

  // §11 Finance
  static const withinAllowanceXp = 1;
  static const funBudgetFloor = 0.5;
  static const budgetRecoveryXp = 2;

  // §12 Identity
  static const identityWindowDays = 30;
}

/// Rounds to the nearest whole number, halves up (spec convention).
int roundHalfUp(num x) => (x + 0.5).floor();
