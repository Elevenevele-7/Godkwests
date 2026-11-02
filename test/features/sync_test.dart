import 'package:ascension/core/database/app_database.dart';
import 'package:ascension/features/finance/data/finance_repository.dart';
import 'package:ascension/features/finance/domain/finance.dart';
import 'package:ascension/features/missions/data/habit_repository.dart';
import 'package:ascension/features/missions/domain/habit.dart';
import 'package:ascension/features/sync/data/sync_service.dart';
import 'package:ascension/features/sync/domain/finance_crypto.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// The server, in memory: keeps the newest write per row.
class FakeRemote implements SyncRemote {
  final rows = <(String, String), RemoteRow>{};
  var _clock = 0;

  @override
  Future<void> upsert(List<RemoteRow> batch) async {
    for (final r in batch) {
      rows[(r.table, r.id)] = RemoteRow(
        table: r.table,
        id: r.id,
        updatedAt: r.updatedAt,
        deleted: r.deleted,
        data: r.data,
        cipher: r.cipher,
        syncedAt: DateTime.fromMillisecondsSinceEpoch(++_clock, isUtc: true),
      );
    }
  }

  @override
  Future<List<RemoteRow>> pull(DateTime since, Set<String> tables) async =>
      (rows.values
          .where((r) => tables.contains(r.table) && r.syncedAt!.isAfter(since))
          .toList()
        ..sort((a, b) => a.syncedAt!.compareTo(b.syncedAt!)));
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  final crypto = FinanceCrypto(kdfMemoryKb: 64, kdfIterations: 1);

  late AppDatabase phone;
  late AppDatabase tablet;
  late FakeRemote remote;

  setUp(() {
    phone = AppDatabase(NativeDatabase.memory());
    tablet = AppDatabase(NativeDatabase.memory());
    remote = FakeRemote();
  });

  tearDown(() async {
    await phone.close();
    await tablet.close();
  });

  final habit = Habit(
    id: 'read',
    name: 'Read 20 pages',
    baseXp: 2,
    weekdays: const {1, 2, 3, 4, 5, 6, 7},
    createdOn: DateTime.utc(2026, 11, 2),
  );

  test('a habit and its completion reach the second device', () async {
    await HabitRepository(phone).saveHabit(habit);
    await HabitRepository(phone)
        .setCompleted('read', DateTime.utc(2026, 11, 2), true);

    final pushed = await SyncService(phone, remote, crypto: crypto).sync();
    expect(pushed.pushed, 2);
    final pulled = await SyncService(tablet, remote, crypto: crypto).sync();
    expect(pulled.pulled, 2);

    final habits = await HabitRepository(tablet).habits();
    expect(habits.single.name, 'Read 20 pages');
    expect((await HabitRepository(tablet).completions())['read'], {
      DateTime.utc(2026, 11, 2),
    });

    // Nothing is dirty afterwards, so a second sync sends nothing.
    expect((await SyncService(phone, remote, crypto: crypto).sync()).pushed, 0);
    expect(
      (await SyncService(tablet, remote, crypto: crypto).sync()).pushed,
      0,
    );
  });

  test('the newest edit wins', () async {
    await HabitRepository(phone).saveHabit(habit);
    await SyncService(phone, remote, crypto: crypto).sync();
    await SyncService(tablet, remote, crypto: crypto).sync();

    await Future<void>.delayed(const Duration(milliseconds: 1100));
    await HabitRepository(tablet)
        .saveHabit(habit.copyWith(name: 'Read 30 pages'));
    await SyncService(tablet, remote, crypto: crypto).sync();
    await SyncService(phone, remote, crypto: crypto).sync();

    expect(
      (await HabitRepository(phone).habits()).single.name,
      'Read 30 pages',
    );
  });

  test('finance syncs only as ciphertext and only with the key', () async {
    final key = await crypto.newDataKey();
    await FinanceRepository(phone).addExpense(
      Expense(
        id: 'e1',
        amount: 150,
        category: SpendCategory.fun,
        day: DateTime.utc(2026, 11, 2),
        note: 'movie',
      ),
    );

    // Without the key, finance stays queued on the phone.
    expect((await SyncService(phone, remote, crypto: crypto).sync()).pushed, 0);

    await SyncService(phone, remote, crypto: crypto).sync(financeKey: key);
    final stored = remote.rows[('expenses', 'e1')]!;
    expect(stored.data, isNull);
    expect(stored.cipher, isNot(contains('movie')));

    // A device without the key gets nothing; with it, the expense arrives.
    await SyncService(tablet, remote, crypto: crypto).sync();
    expect(await FinanceRepository(tablet).expenses(), isEmpty);
    await SyncService(tablet, remote, crypto: crypto).sync(financeKey: key);
    final e = (await FinanceRepository(tablet).expenses()).single;
    expect(e.amount, 150);
    expect(e.note, 'movie');
  });
}
