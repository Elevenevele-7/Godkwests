enum Currency { xp, dp, vp }

enum RewardKind {
  missionCompleted,
  missPenalty,
  recoveryBonus,
  withinAllowance,
  budgetRecovery,
  streakMilestone,
  perfectWeek,
  evolveSuccess,
  visionMilestone,
  visionCompleted,
  visionOnTime,
}

/// One entry in the append-only reward ledger. Totals are always sums of
/// the ledger, so every point can be explained.
class Reward {
  const Reward({
    required this.key,
    required this.currency,
    required this.kind,
    required this.amount,
    required this.day,
    required this.explanation,
    this.refId,
  });

  /// Unique per award, e.g. `miss:habitId:2026-11-02`, so the same event
  /// is never awarded twice.
  final String key;
  final Currency currency;
  final RewardKind kind;

  /// Negative for penalties. DP and VP are never negative.
  final int amount;
  final DateTime day;
  final String explanation;
  final String? refId;
}

String dayKey(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';
