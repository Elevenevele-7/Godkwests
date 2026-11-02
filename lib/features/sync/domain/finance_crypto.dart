import 'dart:convert';
import 'dart:math';

import 'package:cryptography/cryptography.dart';

/// End-to-end encryption for finance data (docs/database.md).
///
/// A random 256-bit data key encrypts finance rows with AES-GCM. The data
/// key itself is stored on the server only in wrapped (encrypted) form:
/// once under a key derived from the user's passphrase, once under a key
/// derived from a recovery key shown to the user one time. The server never
/// sees the passphrase, the recovery key or the data key.
class FinanceCrypto {
  FinanceCrypto({this.kdfMemoryKb = 19456, this.kdfIterations = 2});

  /// Argon2id cost. Lowered only in tests.
  final int kdfMemoryKb;
  final int kdfIterations;

  static final _aes = AesGcm.with256bits();
  static final _random = Random.secure();

  List<int> _randomBytes(int n) =>
      List.generate(n, (_) => _random.nextInt(256));

  Future<SecretKey> newDataKey() async => SecretKey(_randomBytes(32));

  Future<SecretKey> _kek(String secret, List<int> salt) => Argon2id(
    parallelism: 1,
    memory: kdfMemoryKb,
    iterations: kdfIterations,
    hashLength: 32,
  ).deriveKey(secretKey: SecretKey(utf8.encode(secret.trim())), nonce: salt);

  /// Encrypts [dataKey] under [secret] (passphrase or recovery key).
  Future<WrappedKey> wrap(SecretKey dataKey, String secret) async {
    final salt = _randomBytes(16);
    final box = await _aes.encrypt(
      await dataKey.extractBytes(),
      secretKey: await _kek(secret, salt),
    );
    return WrappedKey(
      salt: base64Encode(salt),
      box: base64Encode(box.concatenation()),
    );
  }

  /// Recovers the data key, or throws [SecretBoxAuthenticationError] when
  /// [secret] is wrong.
  Future<SecretKey> unwrap(WrappedKey wrapped, String secret) async {
    final kek = await _kek(secret, base64Decode(wrapped.salt));
    final bytes = await _aes.decrypt(_box(wrapped.box), secretKey: kek);
    return SecretKey(bytes);
  }

  Future<String> encryptJson(Map<String, dynamic> json, SecretKey key) async {
    final box = await _aes.encrypt(
      utf8.encode(jsonEncode(json)),
      secretKey: key,
    );
    return base64Encode(box.concatenation());
  }

  Future<Map<String, dynamic>> decryptJson(String cipher, SecretKey key) async {
    final bytes = await _aes.decrypt(_box(cipher), secretKey: key);
    return jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
  }

  SecretBox _box(String b64) => SecretBox.fromConcatenation(
    base64Decode(b64),
    nonceLength: _aes.nonceLength,
    macLength: _aes.macAlgorithm.macLength,
  );

  /// A recovery key like `K7QD-9XWM-…`, 24 characters from an unambiguous
  /// alphabet (about 120 bits).
  String newRecoveryKey() {
    const alphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
    final chars = [
      for (var i = 0; i < 24; i++) alphabet[_random.nextInt(alphabet.length)],
    ];
    return [for (var i = 0; i < 24; i += 4) chars.sublist(i, i + 4).join()]
        .join('-');
  }
}

class WrappedKey {
  const WrappedKey({required this.salt, required this.box});

  final String salt;

  /// Base64 of nonce ‖ ciphertext ‖ MAC.
  final String box;

  Map<String, String> toJson() => {'salt': salt, 'box': box};

  factory WrappedKey.fromJson(Map<String, dynamic> j) =>
      WrappedKey(salt: j['salt'] as String, box: j['box'] as String);
}
