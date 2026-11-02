import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/time/day.dart';
import '../domain/reward.dart';

class RewardTotals {
  const RewardTotals({this.xp = 0, this.dp = 0, this.vp = 0});

  final int xp;
  final int dp;
  final int vp;
}

/// The append-only XP / DP / VP ledger.
class RewardRepository {
  RewardRepository(this._db);

  final AppDatabase _db;

  Stream<List<Reward>> watchAll() =>
      (_db.select(_db.rewards)
            ..where((r) => r.deleted.equals(false))
            ..orderBy([
              (r) => OrderingTerm.desc(r.day),
              (r) => OrderingTerm.desc(r.updatedAt),
            ]))
          .watch()
          .map((rows) => rows.map(_reward).toList());

  Future<RewardTotals> totals() async {
    final rows = await (_db.select(
      _db.rewards,
    )..where((r) => r.deleted.equals(false))).get();
    return totalsOf(rows.map(_reward));
  }

  Future<bool> exists(String key) async =>
      await (_db.select(_db.rewards)
            ..where((r) => r.id.equals(key) & r.deleted.equals(false)))
          .getSingleOrNull() !=
      null;

  /// Records [reward] unless its key was already awarded. XP penalties are
  /// trimmed so total XP never goes below 0 (spec §2).
  Future<bool> award(Reward reward) => _db.transaction(() async {
    if (await exists(reward.key)) return false;
    var amount = reward.amount;
    if (reward.currency == Currency.xp && amount < 0) {
      final xp = (await totals()).xp;
      amount = -amount.abs().clamp(0, xp);
    }
    await _db
        .into(_db.rewards)
        .insertOnConflictUpdate(
          RewardsCompanion.insert(
            id: reward.key,
            updatedAt: DateTime.now(),
            dirty: const Value(true),
            deleted: const Value(false),
            currency: reward.currency.name,
            kind: reward.kind.name,
            amount: amount,
            day: reward.day.dateOnly,
            explanation: reward.explanation,
            refId: Value(reward.refId),
          ),
        );
    return true;
  });

  /// Withdraws an award made in error, e.g. an un-ticked mission. DP and VP
  /// from past days are never revoked (achievement permanence).
  Future<void> revoke(String key) =>
      (_db.update(_db.rewards)..where((r) => r.id.equals(key))).write(
        RewardsCompanion(
          deleted: const Value(true),
          dirty: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Reward _reward(RewardRow r) => Reward(
    key: r.id,
    currency: Currency.values.byName(r.currency),
    kind: RewardKind.values.byName(r.kind),
    amount: r.amount,
    day: r.day.dateOnly,
    explanation: r.explanation,
    refId: r.refId,
  );
}

RewardTotals totalsOf(Iterable<Reward> rewards) {
  var xp = 0, dp = 0, vp = 0;
  for (final r in rewards) {
    switch (r.currency) {
      case Currency.xp:
        xp += r.amount;
      case Currency.dp:
        dp += r.amount;
      case Currency.vp:
        vp += r.amount;
    }
  }
  return RewardTotals(xp: xp < 0 ? 0 : xp, dp: dp, vp: vp);
}

final rewardRepositoryProvider = Provider(
  (ref) => RewardRepository(ref.watch(databaseProvider)),
);

final rewardsProvider = StreamProvider<List<Reward>>(
  (ref) => ref.watch(rewardRepositoryProvider).watchAll(),
);
