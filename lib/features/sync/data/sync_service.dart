import 'package:cryptography/cryptography.dart';
import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/finance_crypto.dart';

/// One row as stored on the server.
class RemoteRow {
  const RemoteRow({
    required this.table,
    required this.id,
    required this.updatedAt,
    required this.deleted,
    this.data,
    this.cipher,
    this.syncedAt,
  });

  final String table;
  final String id;
  final DateTime updatedAt;
  final bool deleted;
  final Map<String, dynamic>? data;
  final String? cipher;
  final DateTime? syncedAt;
}

/// The server side of sync. [SupabaseSyncRemote] in production; an
/// in-memory fake in tests.
abstract class SyncRemote {
  Future<void> upsert(List<RemoteRow> rows);

  /// Rows stored after [since], oldest first, in [tables].
  Future<List<RemoteRow>> pull(DateTime since, Set<String> tables);
}

class _Spec {
  const _Spec(this.table, this.fromJson, {this.encrypted = false});

  final TableInfo<Table, DataClass> table;
  final DataClass Function(Map<String, dynamic>) fromJson;
  final bool encrypted;

  String get name => table.actualTableName;
}

/// Copies changed rows between this device and the server. Last write wins
/// per row, using each row's `updatedAt`. Finance rows are encrypted with
/// the finance data key and skipped while it isn't unlocked.
class SyncService {
  SyncService(this._db, this._remote, {FinanceCrypto? crypto})
    : _crypto = crypto ?? FinanceCrypto();

  final AppDatabase _db;
  final SyncRemote _remote;
  final FinanceCrypto _crypto;

  late final List<_Spec> _specs = [
    _Spec(_db.profiles, ProfileRow.fromJson),
    _Spec(_db.habits, HabitRow.fromJson),
    _Spec(_db.completions, CompletionRow.fromJson),
    _Spec(_db.excuses, ExcuseRow.fromJson),
    _Spec(_db.rewards, RewardRow.fromJson),
    _Spec(_db.recoveries, RecoveryRow.fromJson),
    _Spec(_db.visions, VisionRow.fromJson),
    _Spec(_db.milestones, MilestoneRow.fromJson),
    _Spec(_db.books, BookRow.fromJson),
    _Spec(_db.annotations, AnnotationRow.fromJson),
    _Spec(_db.councilMessages, CouncilMessageRow.fromJson),
    _Spec(
      _db.financeSettingsTable,
      FinanceSettingsRow.fromJson,
      encrypted: true,
    ),
    _Spec(_db.expenses, ExpenseRow.fromJson, encrypted: true),
    _Spec(_db.savingsDeposits, SavingsDepositRow.fromJson, encrypted: true),
    _Spec(_db.budgetWeeks, BudgetWeekRow.fromJson, encrypted: true),
  ];

  static const _plainCursor = 'syncCursor';
  static const _financeCursor = 'syncCursorFinance';

  /// Pushes local changes, then pulls remote ones. [financeKey] null skips
  /// finance tables (they stay queued until the key is unlocked).
  Future<SyncResult> sync({SecretKey? financeKey}) async {
    final pushed = await _push(financeKey);
    var pulled = await _pull(
      _specs.where((s) => !s.encrypted),
      _plainCursor,
      null,
    );
    if (financeKey != null) {
      pulled += await _pull(
        _specs.where((s) => s.encrypted),
        _financeCursor,
        financeKey,
      );
    }
    return SyncResult(pushed: pushed, pulled: pulled);
  }

  Future<int> _push(SecretKey? financeKey) async {
    var count = 0;
    for (final spec in _specs) {
      if (spec.encrypted && financeKey == null) continue;
      final raw = await _db
          .customSelect(
            'SELECT * FROM "${spec.name}" WHERE dirty = 1',
            readsFrom: {spec.table},
          )
          .get();
      if (raw.isEmpty) continue;

      final rows = <RemoteRow>[];
      for (final r in raw) {
        final json = (await spec.table.map(r.data)).toJson()..remove('dirty');
        final updatedAt = DateTime.fromMillisecondsSinceEpoch(
          json['updatedAt'] as int,
          isUtc: true,
        );
        rows.add(
          RemoteRow(
            table: spec.name,
            id: json['id'] as String,
            updatedAt: updatedAt,
            deleted: json['deleted'] as bool,
            data: spec.encrypted ? null : json,
            cipher: spec.encrypted
                ? await _crypto.encryptJson(json, financeKey!)
                : null,
          ),
        );
      }
      await _remote.upsert(rows);
      // Mark clean only rows that didn't change again meanwhile.
      for (final r in raw) {
        await _db.customUpdate(
          'UPDATE "${spec.name}" SET dirty = 0 WHERE id = ? AND updated_at = ?',
          variables: [Variable(r.data['id']), Variable(r.data['updated_at'])],
          updates: {spec.table},
        );
      }
      count += rows.length;
    }
    return count;
  }

  Future<int> _pull(
    Iterable<_Spec> specs,
    String cursorKey,
    SecretKey? key,
  ) async {
    final byName = {for (final s in specs) s.name: s};
    final stored = await _db.meta(cursorKey);
    var cursor = stored == null
        ? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true)
        : DateTime.parse(stored);
    var applied = 0;
    while (true) {
      final page = await _remote.pull(cursor, byName.keys.toSet());
      if (page.isEmpty) break;
      for (final row in page) {
        final spec = byName[row.table];
        if (spec != null && await _apply(spec, row, key)) applied++;
        if (row.syncedAt != null && row.syncedAt!.isAfter(cursor)) {
          cursor = row.syncedAt!;
        }
      }
      await _db.setMeta(cursorKey, cursor.toIso8601String());
      if (page.length < SupabaseSyncPageSize.value) break;
    }
    return applied;
  }

  /// Writes [row] locally if it's newer than the local copy.
  Future<bool> _apply(_Spec spec, RemoteRow row, SecretKey? key) async {
    final local = await _db
        .customSelect(
          'SELECT * FROM "${spec.name}" WHERE id = ?',
          variables: [Variable(row.id)],
          readsFrom: {spec.table},
        )
        .getSingleOrNull();
    if (local != null) {
      final json = (await spec.table.map(local.data)).toJson();
      final localUpdated = DateTime.fromMillisecondsSinceEpoch(
        json['updatedAt'] as int,
        isUtc: true,
      );
      if (!row.updatedAt.isAfter(localUpdated)) return false;
    }
    final Map<String, dynamic> json;
    if (row.cipher != null) {
      if (key == null) return false;
      json = await _crypto.decryptJson(row.cipher!, key);
    } else {
      json = Map.of(row.data!);
    }
    json['dirty'] = false;
    await _db
        .into(spec.table)
        .insertOnConflictUpdate(spec.fromJson(json) as Insertable<DataClass>);
    return true;
  }
}

/// Rows per pull request.
abstract final class SupabaseSyncPageSize {
  static const value = 500;
}

class SyncResult {
  const SyncResult({required this.pushed, required this.pulled});

  final int pushed;
  final int pulled;
}
