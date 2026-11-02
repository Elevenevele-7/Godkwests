import 'package:godkwests/features/sync/domain/finance_crypto.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Cheap key derivation so tests run fast.
  final crypto = FinanceCrypto(kdfMemoryKb: 64, kdfIterations: 1);

  test('round-trips finance rows and rejects a wrong key', () async {
    final key = await crypto.newDataKey();
    final cipher = await crypto.encryptJson({
      'amount': 150,
      'note': 'lunch',
    }, key);
    expect(cipher, isNot(contains('lunch')));
    expect(await crypto.decryptJson(cipher, key), {
      'amount': 150,
      'note': 'lunch',
    });

    final other = await crypto.newDataKey();
    expect(
      () => crypto.decryptJson(cipher, other),
      throwsA(isA<SecretBoxAuthenticationError>()),
    );
  });

  test('passphrase and recovery key both unwrap the same data key', () async {
    final key = await crypto.newDataKey();
    final recovery = crypto.newRecoveryKey();
    expect(recovery, matches(RegExp(r'^([A-Z2-9]{4}-){5}[A-Z2-9]{4}$')));

    final byPassphrase = await crypto.wrap(key, 'correct horse battery');
    final byRecovery = await crypto.wrap(key, recovery);
    final expected = await key.extractBytes();

    expect(
      await (await crypto.unwrap(
        byPassphrase,
        'correct horse battery',
      )).extractBytes(),
      expected,
    );
    expect(
      await (await crypto.unwrap(
        WrappedKey.fromJson(byRecovery.toJson()),
        ' $recovery ',
      )).extractBytes(),
      expected,
    );
    expect(
      () => crypto.unwrap(byPassphrase, 'wrong'),
      throwsA(isA<SecretBoxAuthenticationError>()),
    );
  });
}
