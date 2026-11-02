import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../council/domain/advisor.dart';
import '../../progression/domain/accountability_mode.dart';
import '../domain/profile.dart';

/// The single profile row on this device.
const _profileId = 'me';

class ProfileRepository {
  ProfileRepository(this._db);

  final AppDatabase _db;

  Stream<Profile> watch() => (_db.select(
    _db.profiles,
  )..where((p) => p.id.equals(_profileId))).watchSingleOrNull().map(_toDomain);

  Future<Profile> get() async => _toDomain(
    await (_db.select(
      _db.profiles,
    )..where((p) => p.id.equals(_profileId))).getSingleOrNull(),
  );

  Future<void> save(Profile p) => _db
      .into(_db.profiles)
      .insertOnConflictUpdate(
        ProfilesCompanion.insert(
          id: _profileId,
          updatedAt: DateTime.now(),
          dirty: const Value(true),
          displayName: Value(p.displayName),
          accountability: Value(p.mode.name),
          areas: Value(jsonEncode(p.areas)),
          advisor: Value(p.advisor.name),
          strictness: Value(p.strictness),
          onboarded: Value(p.onboarded),
        ),
      );

  Profile _toDomain(ProfileRow? r) => r == null
      ? const Profile()
      : Profile(
          displayName: r.displayName,
          mode: AccountabilityMode.values.byName(r.accountability),
          areas: (jsonDecode(r.areas) as List).cast<String>(),
          advisor: Advisor.values.byName(r.advisor),
          strictness: r.strictness,
          onboarded: r.onboarded,
        );
}

final profileRepositoryProvider = Provider(
  (ref) => ProfileRepository(ref.watch(databaseProvider)),
);

final profileProvider = StreamProvider<Profile>(
  (ref) => ref.watch(profileRepositoryProvider).watch(),
);
