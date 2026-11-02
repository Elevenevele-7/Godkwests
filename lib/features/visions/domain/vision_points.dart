import 'dart:math';

import '../../../core/time/day.dart';
import '../../progression/domain/reward.dart';
import '../../progression/domain/scoring_rules.dart';
import 'vision.dart';

/// Months between start and deadline, rounded, at least 1.
int monthsPlanned(DateTime start, DateTime deadline) =>
    max(1, roundHalfUp(start.daysUntil(deadline) / 30.4375));

/// Ambition multiplier compared with completed visions in the same
/// category and unit (spec §10).
double ambitionFor({
  required VisionCategory category,
  required double? targetValue,
  required String? unit,
  required Iterable<Vision> completed,
}) {
  final similar = completed
      .where((v) => v.isCompleted && v.category == category)
      .toList();
  if (similar.isEmpty) return ScoringRules.ambitionFirst;
  final comparable = similar
      .where((v) => v.unit == unit && v.targetValue != null)
      .map((v) => v.targetValue!)
      .toList();
  if (targetValue == null || comparable.isEmpty) {
    return ScoringRules.ambitionFirst;
  }
  return targetValue > comparable.reduce(max)
      ? ScoringRules.ambitionHigher
      : ScoringRules.ambitionRepeat;
}

int visionVp(Vision vision) => roundHalfUp(
  ScoringRules.vpPerMonth *
      monthsPlanned(vision.startedOn, vision.deadline) *
      (vision.ambition ?? ScoringRules.ambitionFirst),
);

int milestoneVp(Vision vision) =>
    roundHalfUp(visionVp(vision) / (vision.milestones.length + 1));

Reward milestoneReward(Vision vision, Milestone milestone, DateTime day) =>
    Reward(
      key: 'vp:milestone:${milestone.id}',
      currency: Currency.vp,
      kind: RewardKind.visionMilestone,
      amount: milestoneVp(vision),
      day: day.dateOnly,
      refId: vision.id,
      explanation: 'Milestone "${milestone.title}" of "${vision.title}"',
    );

/// VP for completing [vision]: the remainder of its VP after milestones,
/// plus the on-time bonus.
List<Reward> completionRewards(Vision vision, DateTime day) {
  final total = visionVp(vision);
  final awarded =
      milestoneVp(vision) * vision.milestones.where((m) => m.isDone).length;
  final d = day.dateOnly;
  return [
    Reward(
      key: 'vp:vision:${vision.id}',
      currency: Currency.vp,
      kind: RewardKind.visionCompleted,
      amount: max(0, total - awarded),
      day: d,
      refId: vision.id,
      explanation: 'Completed vision "${vision.title}"',
    ),
    if (!d.isAfter(vision.deadline.dateOnly))
      Reward(
        key: 'vp:ontime:${vision.id}',
        currency: Currency.vp,
        kind: RewardKind.visionOnTime,
        amount: roundHalfUp(total * ScoringRules.onTimeBonus),
        day: d,
        refId: vision.id,
        explanation: 'Finished "${vision.title}" on time',
      ),
  ];
}
