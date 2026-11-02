import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/env.dart';
import '../../../core/database/app_database.dart';
import '../domain/finance_crypto.dart';
import 'sync_service.dart';

SupabaseClient get _client => Supabase.instance.client;

class SupabaseSyncRemote implements SyncRemote {
  @override
  Future<void> upsert(List<RemoteRow> rows) async {
    final userId = _client.auth.currentUser!.id;
    for (var i = 0; i < rows.length; i += SupabaseSyncPageSize.value) {
      await _client.from('sync_rows').upsert([
        for (final r in rows.skip(i).take(SupabaseSyncPageSize.value))
          {
            'user_id': userId,
            'tbl': r.table,
            'id': r.id,
            'data': r.data,
            'cipher': r.cipher,
            'updated_at': r.updatedAt.toIso8601String(),
            'deleted': r.deleted,
          },
      ]);
    }
  }

  @override
  Future<List<RemoteRow>> pull(DateTime since, Set<String> tables) async {
    final rows = await _client
        .from('sync_rows')
        .select()
        .inFilter('tbl', tables.toList())
        .gt('synced_at', since.toIso8601String())
        .order('synced_at')
        .limit(SupabaseSyncPageSize.value);
    return [
      for (final r in rows)
        RemoteRow(
          table: r['tbl'] as String,
          id: r['id'] as String,
          updatedAt: DateTime.parse(r['updated_at'] as String),
          deleted: r['deleted'] as bool,
          data: r['data'] as Map<String, dynamic>?,
          cipher: r['cipher'] as String?,
          syncedAt: DateTime.parse(r['synced_at'] as String),
        ),
    ];
  }
}

enum FinanceKeyStatus {
  /// No finance key exists for this account yet.
  notSetUp,

  /// A key exists, but this device hasn't been unlocked.
  locked,
  unlocked,
}

/// Creates, unlocks and stores the finance data key.
class FinanceKeyService {
  FinanceKeyService({FinanceCrypto? crypto})
    : _crypto = crypto ?? FinanceCrypto();

  final FinanceCrypto _crypto;
  static const _storage = FlutterSecureStorage();
  static const _localKey = 'finance_data_key';

  Future<SecretKey?> localKey() async {
    final b64 = await _storage.read(key: _localKey);
    return b64 == null ? null : SecretKey(base64Decode(b64));
  }

  Future<void> _storeLocal(SecretKey key) async => _storage.write(
    key: _localKey,
    value: base64Encode(await key.extractBytes()),
  );

  Future<void> forgetLocal() => _storage.delete(key: _localKey);

  Future<FinanceKeyStatus> status() async {
    if (await localKey() != null) return FinanceKeyStatus.unlocked;
    final row = await _client
        .from('finance_keys')
        .select('user_id')
        .maybeSingle();
    return row == null ? FinanceKeyStatus.notSetUp : FinanceKeyStatus.locked;
  }

  /// Creates the key, protects it with [passphrase] and a new recovery key,
  /// and returns the recovery key to show the user once.
  Future<String> setUp(String passphrase) async {
    final key = await _crypto.newDataKey();
    final recovery = _crypto.newRecoveryKey();
    await _client.from('finance_keys').insert({
      'user_id': _client.auth.currentUser!.id,
      'by_passphrase': (await _crypto.wrap(key, passphrase)).toJson(),
      'by_recovery': (await _crypto.wrap(key, recovery)).toJson(),
    });
    await _storeLocal(key);
    return recovery;
  }

  /// Unlocks finance on this device with the passphrase or recovery key.
  /// Returns false if neither matches.
  Future<bool> unlock(String secret) async {
    final row = await _client.from('finance_keys').select().single();
    for (final field in ['by_passphrase', 'by_recovery']) {
      try {
        final key = await _crypto.unwrap(
          WrappedKey.fromJson(row[field] as Map<String, dynamic>),
          secret,
        );
        await _storeLocal(key);
        return true;
      } on SecretBoxAuthenticationError {
        continue;
      }
    }
    return false;
  }
}

final financeKeyServiceProvider = Provider((ref) => FinanceKeyService());

/// The signed-in user, or null (also when Supabase isn't configured).
final authUserProvider = StreamProvider<User?>((ref) {
  if (!Env.hasSupabase) return Stream.value(null);
  return _client.auth.onAuthStateChange.map((s) => s.session?.user);
});

final syncServiceProvider = Provider<SyncService?>((ref) {
  if (!Env.hasSupabase) return null;
  return SyncService(ref.watch(databaseProvider), SupabaseSyncRemote());
});

/// Runs one sync if signed in. Errors are reported, not thrown, so a bad
/// connection never interrupts the app.
class SyncController extends Notifier<SyncState> {
  @override
  SyncState build() => const SyncState();

  Future<void> syncNow() async {
    final service = ref.read(syncServiceProvider);
    if (service == null || _client.auth.currentUser == null) return;
    if (state.running) return;
    state = SyncState(running: true, last: state.last);
    try {
      final key = await ref.read(financeKeyServiceProvider).localKey();
      final result = await service.sync(financeKey: key);
      state = SyncState(last: DateTime.now(), result: result);
    } catch (e) {
      state = SyncState(last: state.last, error: '$e');
    }
  }
}

class SyncState {
  const SyncState({this.running = false, this.last, this.result, this.error});

  final bool running;
  final DateTime? last;
  final SyncResult? result;
  final String? error;
}

final syncControllerProvider = NotifierProvider<SyncController, SyncState>(
  SyncController.new,
);
