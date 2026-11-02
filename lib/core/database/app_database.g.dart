// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles
    with TableInfo<$ProfilesTable, ProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _accountabilityMeta = const VerificationMeta(
    'accountability',
  );
  @override
  late final GeneratedColumn<String> accountability = GeneratedColumn<String>(
    'accountability',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('balanced'),
  );
  static const VerificationMeta _areasMeta = const VerificationMeta('areas');
  @override
  late final GeneratedColumn<String> areas = GeneratedColumn<String>(
    'areas',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _advisorMeta = const VerificationMeta(
    'advisor',
  );
  @override
  late final GeneratedColumn<String> advisor = GeneratedColumn<String>(
    'advisor',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('strategist'),
  );
  static const VerificationMeta _strictnessMeta = const VerificationMeta(
    'strictness',
  );
  @override
  late final GeneratedColumn<int> strictness = GeneratedColumn<int>(
    'strictness',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _onboardedMeta = const VerificationMeta(
    'onboarded',
  );
  @override
  late final GeneratedColumn<bool> onboarded = GeneratedColumn<bool>(
    'onboarded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarded" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    deleted,
    dirty,
    displayName,
    accountability,
    areas,
    advisor,
    strictness,
    onboarded,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('accountability')) {
      context.handle(
        _accountabilityMeta,
        accountability.isAcceptableOrUnknown(
          data['accountability']!,
          _accountabilityMeta,
        ),
      );
    }
    if (data.containsKey('areas')) {
      context.handle(
        _areasMeta,
        areas.isAcceptableOrUnknown(data['areas']!, _areasMeta),
      );
    }
    if (data.containsKey('advisor')) {
      context.handle(
        _advisorMeta,
        advisor.isAcceptableOrUnknown(data['advisor']!, _advisorMeta),
      );
    }
    if (data.containsKey('strictness')) {
      context.handle(
        _strictnessMeta,
        strictness.isAcceptableOrUnknown(data['strictness']!, _strictnessMeta),
      );
    }
    if (data.containsKey('onboarded')) {
      context.handle(
        _onboardedMeta,
        onboarded.isAcceptableOrUnknown(data['onboarded']!, _onboardedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      accountability: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accountability'],
      )!,
      areas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}areas'],
      )!,
      advisor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}advisor'],
      )!,
      strictness: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}strictness'],
      )!,
      onboarded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarded'],
      )!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class ProfileRow extends DataClass implements Insertable<ProfileRow> {
  final String id;
  final DateTime updatedAt;
  final bool deleted;
  final bool dirty;
  final String displayName;
  final String accountability;

  /// JSON list of chosen growth areas.
  final String areas;
  final String advisor;

  /// 1 (gentle) – 3 (direct) coaching strictness.
  final int strictness;
  final bool onboarded;
  const ProfileRow({
    required this.id,
    required this.updatedAt,
    required this.deleted,
    required this.dirty,
    required this.displayName,
    required this.accountability,
    required this.areas,
    required this.advisor,
    required this.strictness,
    required this.onboarded,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    map['dirty'] = Variable<bool>(dirty);
    map['display_name'] = Variable<String>(displayName);
    map['accountability'] = Variable<String>(accountability);
    map['areas'] = Variable<String>(areas);
    map['advisor'] = Variable<String>(advisor);
    map['strictness'] = Variable<int>(strictness);
    map['onboarded'] = Variable<bool>(onboarded);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
      dirty: Value(dirty),
      displayName: Value(displayName),
      accountability: Value(accountability),
      areas: Value(areas),
      advisor: Value(advisor),
      strictness: Value(strictness),
      onboarded: Value(onboarded),
    );
  }

  factory ProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileRow(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      displayName: serializer.fromJson<String>(json['displayName']),
      accountability: serializer.fromJson<String>(json['accountability']),
      areas: serializer.fromJson<String>(json['areas']),
      advisor: serializer.fromJson<String>(json['advisor']),
      strictness: serializer.fromJson<int>(json['strictness']),
      onboarded: serializer.fromJson<bool>(json['onboarded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
      'dirty': serializer.toJson<bool>(dirty),
      'displayName': serializer.toJson<String>(displayName),
      'accountability': serializer.toJson<String>(accountability),
      'areas': serializer.toJson<String>(areas),
      'advisor': serializer.toJson<String>(advisor),
      'strictness': serializer.toJson<int>(strictness),
      'onboarded': serializer.toJson<bool>(onboarded),
    };
  }

  ProfileRow copyWith({
    String? id,
    DateTime? updatedAt,
    bool? deleted,
    bool? dirty,
    String? displayName,
    String? accountability,
    String? areas,
    String? advisor,
    int? strictness,
    bool? onboarded,
  }) => ProfileRow(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
    dirty: dirty ?? this.dirty,
    displayName: displayName ?? this.displayName,
    accountability: accountability ?? this.accountability,
    areas: areas ?? this.areas,
    advisor: advisor ?? this.advisor,
    strictness: strictness ?? this.strictness,
    onboarded: onboarded ?? this.onboarded,
  );
  ProfileRow copyWithCompanion(ProfilesCompanion data) {
    return ProfileRow(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      accountability: data.accountability.present
          ? data.accountability.value
          : this.accountability,
      areas: data.areas.present ? data.areas.value : this.areas,
      advisor: data.advisor.present ? data.advisor.value : this.advisor,
      strictness: data.strictness.present
          ? data.strictness.value
          : this.strictness,
      onboarded: data.onboarded.present ? data.onboarded.value : this.onboarded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileRow(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('displayName: $displayName, ')
          ..write('accountability: $accountability, ')
          ..write('areas: $areas, ')
          ..write('advisor: $advisor, ')
          ..write('strictness: $strictness, ')
          ..write('onboarded: $onboarded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    deleted,
    dirty,
    displayName,
    accountability,
    areas,
    advisor,
    strictness,
    onboarded,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileRow &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted &&
          other.dirty == this.dirty &&
          other.displayName == this.displayName &&
          other.accountability == this.accountability &&
          other.areas == this.areas &&
          other.advisor == this.advisor &&
          other.strictness == this.strictness &&
          other.onboarded == this.onboarded);
}

class ProfilesCompanion extends UpdateCompanion<ProfileRow> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  final Value<bool> dirty;
  final Value<String> displayName;
  final Value<String> accountability;
  final Value<String> areas;
  final Value<String> advisor;
  final Value<int> strictness;
  final Value<bool> onboarded;
  final Value<int> rowid;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.displayName = const Value.absent(),
    this.accountability = const Value.absent(),
    this.areas = const Value.absent(),
    this.advisor = const Value.absent(),
    this.strictness = const Value.absent(),
    this.onboarded = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfilesCompanion.insert({
    required String id,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.displayName = const Value.absent(),
    this.accountability = const Value.absent(),
    this.areas = const Value.absent(),
    this.advisor = const Value.absent(),
    this.strictness = const Value.absent(),
    this.onboarded = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       updatedAt = Value(updatedAt);
  static Insertable<ProfileRow> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
    Expression<bool>? dirty,
    Expression<String>? displayName,
    Expression<String>? accountability,
    Expression<String>? areas,
    Expression<String>? advisor,
    Expression<int>? strictness,
    Expression<bool>? onboarded,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
      if (dirty != null) 'dirty': dirty,
      if (displayName != null) 'display_name': displayName,
      if (accountability != null) 'accountability': accountability,
      if (areas != null) 'areas': areas,
      if (advisor != null) 'advisor': advisor,
      if (strictness != null) 'strictness': strictness,
      if (onboarded != null) 'onboarded': onboarded,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
    Value<bool>? dirty,
    Value<String>? displayName,
    Value<String>? accountability,
    Value<String>? areas,
    Value<String>? advisor,
    Value<int>? strictness,
    Value<bool>? onboarded,
    Value<int>? rowid,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      dirty: dirty ?? this.dirty,
      displayName: displayName ?? this.displayName,
      accountability: accountability ?? this.accountability,
      areas: areas ?? this.areas,
      advisor: advisor ?? this.advisor,
      strictness: strictness ?? this.strictness,
      onboarded: onboarded ?? this.onboarded,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (accountability.present) {
      map['accountability'] = Variable<String>(accountability.value);
    }
    if (areas.present) {
      map['areas'] = Variable<String>(areas.value);
    }
    if (advisor.present) {
      map['advisor'] = Variable<String>(advisor.value);
    }
    if (strictness.present) {
      map['strictness'] = Variable<int>(strictness.value);
    }
    if (onboarded.present) {
      map['onboarded'] = Variable<bool>(onboarded.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('displayName: $displayName, ')
          ..write('accountability: $accountability, ')
          ..write('areas: $areas, ')
          ..write('advisor: $advisor, ')
          ..write('strictness: $strictness, ')
          ..write('onboarded: $onboarded, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitsTable extends Habits with TableInfo<$HabitsTable, HabitRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseXpMeta = const VerificationMeta('baseXp');
  @override
  late final GeneratedColumn<int> baseXp = GeneratedColumn<int>(
    'base_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekdaysMeta = const VerificationMeta(
    'weekdays',
  );
  @override
  late final GeneratedColumn<String> weekdays = GeneratedColumn<String>(
    'weekdays',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdOnMeta = const VerificationMeta(
    'createdOn',
  );
  @override
  late final GeneratedColumn<DateTime> createdOn = GeneratedColumn<DateTime>(
    'created_on',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<String> area = GeneratedColumn<String>(
    'area',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _visionIdMeta = const VerificationMeta(
    'visionId',
  );
  @override
  late final GeneratedColumn<String> visionId = GeneratedColumn<String>(
    'vision_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<int> target = GeneratedColumn<int>(
    'target',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _previousTargetMeta = const VerificationMeta(
    'previousTarget',
  );
  @override
  late final GeneratedColumn<int> previousTarget = GeneratedColumn<int>(
    'previous_target',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _previousBaseXpMeta = const VerificationMeta(
    'previousBaseXp',
  );
  @override
  late final GeneratedColumn<int> previousBaseXp = GeneratedColumn<int>(
    'previous_base_xp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _evolvedOnMeta = const VerificationMeta(
    'evolvedOn',
  );
  @override
  late final GeneratedColumn<DateTime> evolvedOn = GeneratedColumn<DateTime>(
    'evolved_on',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _evolveDeclinedOnMeta = const VerificationMeta(
    'evolveDeclinedOn',
  );
  @override
  late final GeneratedColumn<DateTime> evolveDeclinedOn =
      GeneratedColumn<DateTime>(
        'evolve_declined_on',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _archivedOnMeta = const VerificationMeta(
    'archivedOn',
  );
  @override
  late final GeneratedColumn<DateTime> archivedOn = GeneratedColumn<DateTime>(
    'archived_on',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    deleted,
    dirty,
    name,
    baseXp,
    weekdays,
    createdOn,
    area,
    visionId,
    target,
    unit,
    previousTarget,
    previousBaseXp,
    evolvedOn,
    evolveDeclinedOn,
    archivedOn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('base_xp')) {
      context.handle(
        _baseXpMeta,
        baseXp.isAcceptableOrUnknown(data['base_xp']!, _baseXpMeta),
      );
    } else if (isInserting) {
      context.missing(_baseXpMeta);
    }
    if (data.containsKey('weekdays')) {
      context.handle(
        _weekdaysMeta,
        weekdays.isAcceptableOrUnknown(data['weekdays']!, _weekdaysMeta),
      );
    } else if (isInserting) {
      context.missing(_weekdaysMeta);
    }
    if (data.containsKey('created_on')) {
      context.handle(
        _createdOnMeta,
        createdOn.isAcceptableOrUnknown(data['created_on']!, _createdOnMeta),
      );
    } else if (isInserting) {
      context.missing(_createdOnMeta);
    }
    if (data.containsKey('area')) {
      context.handle(
        _areaMeta,
        area.isAcceptableOrUnknown(data['area']!, _areaMeta),
      );
    }
    if (data.containsKey('vision_id')) {
      context.handle(
        _visionIdMeta,
        visionId.isAcceptableOrUnknown(data['vision_id']!, _visionIdMeta),
      );
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('previous_target')) {
      context.handle(
        _previousTargetMeta,
        previousTarget.isAcceptableOrUnknown(
          data['previous_target']!,
          _previousTargetMeta,
        ),
      );
    }
    if (data.containsKey('previous_base_xp')) {
      context.handle(
        _previousBaseXpMeta,
        previousBaseXp.isAcceptableOrUnknown(
          data['previous_base_xp']!,
          _previousBaseXpMeta,
        ),
      );
    }
    if (data.containsKey('evolved_on')) {
      context.handle(
        _evolvedOnMeta,
        evolvedOn.isAcceptableOrUnknown(data['evolved_on']!, _evolvedOnMeta),
      );
    }
    if (data.containsKey('evolve_declined_on')) {
      context.handle(
        _evolveDeclinedOnMeta,
        evolveDeclinedOn.isAcceptableOrUnknown(
          data['evolve_declined_on']!,
          _evolveDeclinedOnMeta,
        ),
      );
    }
    if (data.containsKey('archived_on')) {
      context.handle(
        _archivedOnMeta,
        archivedOn.isAcceptableOrUnknown(data['archived_on']!, _archivedOnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      baseXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_xp'],
      )!,
      weekdays: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weekdays'],
      )!,
      createdOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_on'],
      )!,
      area: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}area'],
      ),
      visionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vision_id'],
      ),
      target: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target'],
      ),
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
      previousTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}previous_target'],
      ),
      previousBaseXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}previous_base_xp'],
      ),
      evolvedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}evolved_on'],
      ),
      evolveDeclinedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}evolve_declined_on'],
      ),
      archivedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_on'],
      ),
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class HabitRow extends DataClass implements Insertable<HabitRow> {
  final String id;
  final DateTime updatedAt;
  final bool deleted;
  final bool dirty;
  final String name;
  final int baseXp;

  /// Comma-separated weekdays, 1 = Monday … 7 = Sunday.
  final String weekdays;
  final DateTime createdOn;
  final String? area;
  final String? visionId;
  final int? target;
  final String? unit;
  final int? previousTarget;
  final int? previousBaseXp;
  final DateTime? evolvedOn;
  final DateTime? evolveDeclinedOn;
  final DateTime? archivedOn;
  const HabitRow({
    required this.id,
    required this.updatedAt,
    required this.deleted,
    required this.dirty,
    required this.name,
    required this.baseXp,
    required this.weekdays,
    required this.createdOn,
    this.area,
    this.visionId,
    this.target,
    this.unit,
    this.previousTarget,
    this.previousBaseXp,
    this.evolvedOn,
    this.evolveDeclinedOn,
    this.archivedOn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    map['dirty'] = Variable<bool>(dirty);
    map['name'] = Variable<String>(name);
    map['base_xp'] = Variable<int>(baseXp);
    map['weekdays'] = Variable<String>(weekdays);
    map['created_on'] = Variable<DateTime>(createdOn);
    if (!nullToAbsent || area != null) {
      map['area'] = Variable<String>(area);
    }
    if (!nullToAbsent || visionId != null) {
      map['vision_id'] = Variable<String>(visionId);
    }
    if (!nullToAbsent || target != null) {
      map['target'] = Variable<int>(target);
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || previousTarget != null) {
      map['previous_target'] = Variable<int>(previousTarget);
    }
    if (!nullToAbsent || previousBaseXp != null) {
      map['previous_base_xp'] = Variable<int>(previousBaseXp);
    }
    if (!nullToAbsent || evolvedOn != null) {
      map['evolved_on'] = Variable<DateTime>(evolvedOn);
    }
    if (!nullToAbsent || evolveDeclinedOn != null) {
      map['evolve_declined_on'] = Variable<DateTime>(evolveDeclinedOn);
    }
    if (!nullToAbsent || archivedOn != null) {
      map['archived_on'] = Variable<DateTime>(archivedOn);
    }
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
      dirty: Value(dirty),
      name: Value(name),
      baseXp: Value(baseXp),
      weekdays: Value(weekdays),
      createdOn: Value(createdOn),
      area: area == null && nullToAbsent ? const Value.absent() : Value(area),
      visionId: visionId == null && nullToAbsent
          ? const Value.absent()
          : Value(visionId),
      target: target == null && nullToAbsent
          ? const Value.absent()
          : Value(target),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      previousTarget: previousTarget == null && nullToAbsent
          ? const Value.absent()
          : Value(previousTarget),
      previousBaseXp: previousBaseXp == null && nullToAbsent
          ? const Value.absent()
          : Value(previousBaseXp),
      evolvedOn: evolvedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(evolvedOn),
      evolveDeclinedOn: evolveDeclinedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(evolveDeclinedOn),
      archivedOn: archivedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedOn),
    );
  }

  factory HabitRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitRow(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      name: serializer.fromJson<String>(json['name']),
      baseXp: serializer.fromJson<int>(json['baseXp']),
      weekdays: serializer.fromJson<String>(json['weekdays']),
      createdOn: serializer.fromJson<DateTime>(json['createdOn']),
      area: serializer.fromJson<String?>(json['area']),
      visionId: serializer.fromJson<String?>(json['visionId']),
      target: serializer.fromJson<int?>(json['target']),
      unit: serializer.fromJson<String?>(json['unit']),
      previousTarget: serializer.fromJson<int?>(json['previousTarget']),
      previousBaseXp: serializer.fromJson<int?>(json['previousBaseXp']),
      evolvedOn: serializer.fromJson<DateTime?>(json['evolvedOn']),
      evolveDeclinedOn: serializer.fromJson<DateTime?>(
        json['evolveDeclinedOn'],
      ),
      archivedOn: serializer.fromJson<DateTime?>(json['archivedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
      'dirty': serializer.toJson<bool>(dirty),
      'name': serializer.toJson<String>(name),
      'baseXp': serializer.toJson<int>(baseXp),
      'weekdays': serializer.toJson<String>(weekdays),
      'createdOn': serializer.toJson<DateTime>(createdOn),
      'area': serializer.toJson<String?>(area),
      'visionId': serializer.toJson<String?>(visionId),
      'target': serializer.toJson<int?>(target),
      'unit': serializer.toJson<String?>(unit),
      'previousTarget': serializer.toJson<int?>(previousTarget),
      'previousBaseXp': serializer.toJson<int?>(previousBaseXp),
      'evolvedOn': serializer.toJson<DateTime?>(evolvedOn),
      'evolveDeclinedOn': serializer.toJson<DateTime?>(evolveDeclinedOn),
      'archivedOn': serializer.toJson<DateTime?>(archivedOn),
    };
  }

  HabitRow copyWith({
    String? id,
    DateTime? updatedAt,
    bool? deleted,
    bool? dirty,
    String? name,
    int? baseXp,
    String? weekdays,
    DateTime? createdOn,
    Value<String?> area = const Value.absent(),
    Value<String?> visionId = const Value.absent(),
    Value<int?> target = const Value.absent(),
    Value<String?> unit = const Value.absent(),
    Value<int?> previousTarget = const Value.absent(),
    Value<int?> previousBaseXp = const Value.absent(),
    Value<DateTime?> evolvedOn = const Value.absent(),
    Value<DateTime?> evolveDeclinedOn = const Value.absent(),
    Value<DateTime?> archivedOn = const Value.absent(),
  }) => HabitRow(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
    dirty: dirty ?? this.dirty,
    name: name ?? this.name,
    baseXp: baseXp ?? this.baseXp,
    weekdays: weekdays ?? this.weekdays,
    createdOn: createdOn ?? this.createdOn,
    area: area.present ? area.value : this.area,
    visionId: visionId.present ? visionId.value : this.visionId,
    target: target.present ? target.value : this.target,
    unit: unit.present ? unit.value : this.unit,
    previousTarget: previousTarget.present
        ? previousTarget.value
        : this.previousTarget,
    previousBaseXp: previousBaseXp.present
        ? previousBaseXp.value
        : this.previousBaseXp,
    evolvedOn: evolvedOn.present ? evolvedOn.value : this.evolvedOn,
    evolveDeclinedOn: evolveDeclinedOn.present
        ? evolveDeclinedOn.value
        : this.evolveDeclinedOn,
    archivedOn: archivedOn.present ? archivedOn.value : this.archivedOn,
  );
  HabitRow copyWithCompanion(HabitsCompanion data) {
    return HabitRow(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      name: data.name.present ? data.name.value : this.name,
      baseXp: data.baseXp.present ? data.baseXp.value : this.baseXp,
      weekdays: data.weekdays.present ? data.weekdays.value : this.weekdays,
      createdOn: data.createdOn.present ? data.createdOn.value : this.createdOn,
      area: data.area.present ? data.area.value : this.area,
      visionId: data.visionId.present ? data.visionId.value : this.visionId,
      target: data.target.present ? data.target.value : this.target,
      unit: data.unit.present ? data.unit.value : this.unit,
      previousTarget: data.previousTarget.present
          ? data.previousTarget.value
          : this.previousTarget,
      previousBaseXp: data.previousBaseXp.present
          ? data.previousBaseXp.value
          : this.previousBaseXp,
      evolvedOn: data.evolvedOn.present ? data.evolvedOn.value : this.evolvedOn,
      evolveDeclinedOn: data.evolveDeclinedOn.present
          ? data.evolveDeclinedOn.value
          : this.evolveDeclinedOn,
      archivedOn: data.archivedOn.present
          ? data.archivedOn.value
          : this.archivedOn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitRow(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('name: $name, ')
          ..write('baseXp: $baseXp, ')
          ..write('weekdays: $weekdays, ')
          ..write('createdOn: $createdOn, ')
          ..write('area: $area, ')
          ..write('visionId: $visionId, ')
          ..write('target: $target, ')
          ..write('unit: $unit, ')
          ..write('previousTarget: $previousTarget, ')
          ..write('previousBaseXp: $previousBaseXp, ')
          ..write('evolvedOn: $evolvedOn, ')
          ..write('evolveDeclinedOn: $evolveDeclinedOn, ')
          ..write('archivedOn: $archivedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    deleted,
    dirty,
    name,
    baseXp,
    weekdays,
    createdOn,
    area,
    visionId,
    target,
    unit,
    previousTarget,
    previousBaseXp,
    evolvedOn,
    evolveDeclinedOn,
    archivedOn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitRow &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted &&
          other.dirty == this.dirty &&
          other.name == this.name &&
          other.baseXp == this.baseXp &&
          other.weekdays == this.weekdays &&
          other.createdOn == this.createdOn &&
          other.area == this.area &&
          other.visionId == this.visionId &&
          other.target == this.target &&
          other.unit == this.unit &&
          other.previousTarget == this.previousTarget &&
          other.previousBaseXp == this.previousBaseXp &&
          other.evolvedOn == this.evolvedOn &&
          other.evolveDeclinedOn == this.evolveDeclinedOn &&
          other.archivedOn == this.archivedOn);
}

class HabitsCompanion extends UpdateCompanion<HabitRow> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  final Value<bool> dirty;
  final Value<String> name;
  final Value<int> baseXp;
  final Value<String> weekdays;
  final Value<DateTime> createdOn;
  final Value<String?> area;
  final Value<String?> visionId;
  final Value<int?> target;
  final Value<String?> unit;
  final Value<int?> previousTarget;
  final Value<int?> previousBaseXp;
  final Value<DateTime?> evolvedOn;
  final Value<DateTime?> evolveDeclinedOn;
  final Value<DateTime?> archivedOn;
  final Value<int> rowid;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.name = const Value.absent(),
    this.baseXp = const Value.absent(),
    this.weekdays = const Value.absent(),
    this.createdOn = const Value.absent(),
    this.area = const Value.absent(),
    this.visionId = const Value.absent(),
    this.target = const Value.absent(),
    this.unit = const Value.absent(),
    this.previousTarget = const Value.absent(),
    this.previousBaseXp = const Value.absent(),
    this.evolvedOn = const Value.absent(),
    this.evolveDeclinedOn = const Value.absent(),
    this.archivedOn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String name,
    required int baseXp,
    required String weekdays,
    required DateTime createdOn,
    this.area = const Value.absent(),
    this.visionId = const Value.absent(),
    this.target = const Value.absent(),
    this.unit = const Value.absent(),
    this.previousTarget = const Value.absent(),
    this.previousBaseXp = const Value.absent(),
    this.evolvedOn = const Value.absent(),
    this.evolveDeclinedOn = const Value.absent(),
    this.archivedOn = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       updatedAt = Value(updatedAt),
       name = Value(name),
       baseXp = Value(baseXp),
       weekdays = Value(weekdays),
       createdOn = Value(createdOn);
  static Insertable<HabitRow> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
    Expression<bool>? dirty,
    Expression<String>? name,
    Expression<int>? baseXp,
    Expression<String>? weekdays,
    Expression<DateTime>? createdOn,
    Expression<String>? area,
    Expression<String>? visionId,
    Expression<int>? target,
    Expression<String>? unit,
    Expression<int>? previousTarget,
    Expression<int>? previousBaseXp,
    Expression<DateTime>? evolvedOn,
    Expression<DateTime>? evolveDeclinedOn,
    Expression<DateTime>? archivedOn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
      if (dirty != null) 'dirty': dirty,
      if (name != null) 'name': name,
      if (baseXp != null) 'base_xp': baseXp,
      if (weekdays != null) 'weekdays': weekdays,
      if (createdOn != null) 'created_on': createdOn,
      if (area != null) 'area': area,
      if (visionId != null) 'vision_id': visionId,
      if (target != null) 'target': target,
      if (unit != null) 'unit': unit,
      if (previousTarget != null) 'previous_target': previousTarget,
      if (previousBaseXp != null) 'previous_base_xp': previousBaseXp,
      if (evolvedOn != null) 'evolved_on': evolvedOn,
      if (evolveDeclinedOn != null) 'evolve_declined_on': evolveDeclinedOn,
      if (archivedOn != null) 'archived_on': archivedOn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
    Value<bool>? dirty,
    Value<String>? name,
    Value<int>? baseXp,
    Value<String>? weekdays,
    Value<DateTime>? createdOn,
    Value<String?>? area,
    Value<String?>? visionId,
    Value<int?>? target,
    Value<String?>? unit,
    Value<int?>? previousTarget,
    Value<int?>? previousBaseXp,
    Value<DateTime?>? evolvedOn,
    Value<DateTime?>? evolveDeclinedOn,
    Value<DateTime?>? archivedOn,
    Value<int>? rowid,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      dirty: dirty ?? this.dirty,
      name: name ?? this.name,
      baseXp: baseXp ?? this.baseXp,
      weekdays: weekdays ?? this.weekdays,
      createdOn: createdOn ?? this.createdOn,
      area: area ?? this.area,
      visionId: visionId ?? this.visionId,
      target: target ?? this.target,
      unit: unit ?? this.unit,
      previousTarget: previousTarget ?? this.previousTarget,
      previousBaseXp: previousBaseXp ?? this.previousBaseXp,
      evolvedOn: evolvedOn ?? this.evolvedOn,
      evolveDeclinedOn: evolveDeclinedOn ?? this.evolveDeclinedOn,
      archivedOn: archivedOn ?? this.archivedOn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (baseXp.present) {
      map['base_xp'] = Variable<int>(baseXp.value);
    }
    if (weekdays.present) {
      map['weekdays'] = Variable<String>(weekdays.value);
    }
    if (createdOn.present) {
      map['created_on'] = Variable<DateTime>(createdOn.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(area.value);
    }
    if (visionId.present) {
      map['vision_id'] = Variable<String>(visionId.value);
    }
    if (target.present) {
      map['target'] = Variable<int>(target.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (previousTarget.present) {
      map['previous_target'] = Variable<int>(previousTarget.value);
    }
    if (previousBaseXp.present) {
      map['previous_base_xp'] = Variable<int>(previousBaseXp.value);
    }
    if (evolvedOn.present) {
      map['evolved_on'] = Variable<DateTime>(evolvedOn.value);
    }
    if (evolveDeclinedOn.present) {
      map['evolve_declined_on'] = Variable<DateTime>(evolveDeclinedOn.value);
    }
    if (archivedOn.present) {
      map['archived_on'] = Variable<DateTime>(archivedOn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('name: $name, ')
          ..write('baseXp: $baseXp, ')
          ..write('weekdays: $weekdays, ')
          ..write('createdOn: $createdOn, ')
          ..write('area: $area, ')
          ..write('visionId: $visionId, ')
          ..write('target: $target, ')
          ..write('unit: $unit, ')
          ..write('previousTarget: $previousTarget, ')
          ..write('previousBaseXp: $previousBaseXp, ')
          ..write('evolvedOn: $evolvedOn, ')
          ..write('evolveDeclinedOn: $evolveDeclinedOn, ')
          ..write('archivedOn: $archivedOn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CompletionsTable extends Completions
    with TableInfo<$CompletionsTable, CompletionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompletionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<DateTime> day = GeneratedColumn<DateTime>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    deleted,
    dirty,
    habitId,
    day,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'completions';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompletionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompletionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompletionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}day'],
      )!,
    );
  }

  @override
  $CompletionsTable createAlias(String alias) {
    return $CompletionsTable(attachedDatabase, alias);
  }
}

class CompletionRow extends DataClass implements Insertable<CompletionRow> {
  final String id;
  final DateTime updatedAt;
  final bool deleted;
  final bool dirty;
  final String habitId;
  final DateTime day;
  const CompletionRow({
    required this.id,
    required this.updatedAt,
    required this.deleted,
    required this.dirty,
    required this.habitId,
    required this.day,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    map['dirty'] = Variable<bool>(dirty);
    map['habit_id'] = Variable<String>(habitId);
    map['day'] = Variable<DateTime>(day);
    return map;
  }

  CompletionsCompanion toCompanion(bool nullToAbsent) {
    return CompletionsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
      dirty: Value(dirty),
      habitId: Value(habitId),
      day: Value(day),
    );
  }

  factory CompletionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompletionRow(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      habitId: serializer.fromJson<String>(json['habitId']),
      day: serializer.fromJson<DateTime>(json['day']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
      'dirty': serializer.toJson<bool>(dirty),
      'habitId': serializer.toJson<String>(habitId),
      'day': serializer.toJson<DateTime>(day),
    };
  }

  CompletionRow copyWith({
    String? id,
    DateTime? updatedAt,
    bool? deleted,
    bool? dirty,
    String? habitId,
    DateTime? day,
  }) => CompletionRow(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
    dirty: dirty ?? this.dirty,
    habitId: habitId ?? this.habitId,
    day: day ?? this.day,
  );
  CompletionRow copyWithCompanion(CompletionsCompanion data) {
    return CompletionRow(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      day: data.day.present ? data.day.value : this.day,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompletionRow(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('habitId: $habitId, ')
          ..write('day: $day')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, updatedAt, deleted, dirty, habitId, day);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompletionRow &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted &&
          other.dirty == this.dirty &&
          other.habitId == this.habitId &&
          other.day == this.day);
}

class CompletionsCompanion extends UpdateCompanion<CompletionRow> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  final Value<bool> dirty;
  final Value<String> habitId;
  final Value<DateTime> day;
  final Value<int> rowid;
  const CompletionsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.habitId = const Value.absent(),
    this.day = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompletionsCompanion.insert({
    required String id,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String habitId,
    required DateTime day,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       updatedAt = Value(updatedAt),
       habitId = Value(habitId),
       day = Value(day);
  static Insertable<CompletionRow> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
    Expression<bool>? dirty,
    Expression<String>? habitId,
    Expression<DateTime>? day,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
      if (dirty != null) 'dirty': dirty,
      if (habitId != null) 'habit_id': habitId,
      if (day != null) 'day': day,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompletionsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
    Value<bool>? dirty,
    Value<String>? habitId,
    Value<DateTime>? day,
    Value<int>? rowid,
  }) {
    return CompletionsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      dirty: dirty ?? this.dirty,
      habitId: habitId ?? this.habitId,
      day: day ?? this.day,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (day.present) {
      map['day'] = Variable<DateTime>(day.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompletionsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('habitId: $habitId, ')
          ..write('day: $day, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExcusesTable extends Excuses with TableInfo<$ExcusesTable, ExcuseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExcusesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<DateTime> day = GeneratedColumn<DateTime>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    deleted,
    dirty,
    day,
    reason,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'excuses';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExcuseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExcuseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExcuseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}day'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $ExcusesTable createAlias(String alias) {
    return $ExcusesTable(attachedDatabase, alias);
  }
}

class ExcuseRow extends DataClass implements Insertable<ExcuseRow> {
  final String id;
  final DateTime updatedAt;
  final bool deleted;
  final bool dirty;
  final DateTime day;
  final String reason;
  final String? note;
  const ExcuseRow({
    required this.id,
    required this.updatedAt,
    required this.deleted,
    required this.dirty,
    required this.day,
    required this.reason,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    map['dirty'] = Variable<bool>(dirty);
    map['day'] = Variable<DateTime>(day);
    map['reason'] = Variable<String>(reason);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  ExcusesCompanion toCompanion(bool nullToAbsent) {
    return ExcusesCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
      dirty: Value(dirty),
      day: Value(day),
      reason: Value(reason),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory ExcuseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExcuseRow(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      day: serializer.fromJson<DateTime>(json['day']),
      reason: serializer.fromJson<String>(json['reason']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
      'dirty': serializer.toJson<bool>(dirty),
      'day': serializer.toJson<DateTime>(day),
      'reason': serializer.toJson<String>(reason),
      'note': serializer.toJson<String?>(note),
    };
  }

  ExcuseRow copyWith({
    String? id,
    DateTime? updatedAt,
    bool? deleted,
    bool? dirty,
    DateTime? day,
    String? reason,
    Value<String?> note = const Value.absent(),
  }) => ExcuseRow(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
    dirty: dirty ?? this.dirty,
    day: day ?? this.day,
    reason: reason ?? this.reason,
    note: note.present ? note.value : this.note,
  );
  ExcuseRow copyWithCompanion(ExcusesCompanion data) {
    return ExcuseRow(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      day: data.day.present ? data.day.value : this.day,
      reason: data.reason.present ? data.reason.value : this.reason,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExcuseRow(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('day: $day, ')
          ..write('reason: $reason, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, updatedAt, deleted, dirty, day, reason, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExcuseRow &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted &&
          other.dirty == this.dirty &&
          other.day == this.day &&
          other.reason == this.reason &&
          other.note == this.note);
}

class ExcusesCompanion extends UpdateCompanion<ExcuseRow> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  final Value<bool> dirty;
  final Value<DateTime> day;
  final Value<String> reason;
  final Value<String?> note;
  final Value<int> rowid;
  const ExcusesCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.day = const Value.absent(),
    this.reason = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExcusesCompanion.insert({
    required String id,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required DateTime day,
    required String reason,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       updatedAt = Value(updatedAt),
       day = Value(day),
       reason = Value(reason);
  static Insertable<ExcuseRow> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
    Expression<bool>? dirty,
    Expression<DateTime>? day,
    Expression<String>? reason,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
      if (dirty != null) 'dirty': dirty,
      if (day != null) 'day': day,
      if (reason != null) 'reason': reason,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExcusesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
    Value<bool>? dirty,
    Value<DateTime>? day,
    Value<String>? reason,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return ExcusesCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      dirty: dirty ?? this.dirty,
      day: day ?? this.day,
      reason: reason ?? this.reason,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (day.present) {
      map['day'] = Variable<DateTime>(day.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExcusesCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('day: $day, ')
          ..write('reason: $reason, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RewardsTable extends Rewards with TableInfo<$RewardsTable, RewardRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RewardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<DateTime> day = GeneratedColumn<DateTime>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _explanationMeta = const VerificationMeta(
    'explanation',
  );
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
    'explanation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refIdMeta = const VerificationMeta('refId');
  @override
  late final GeneratedColumn<String> refId = GeneratedColumn<String>(
    'ref_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    deleted,
    dirty,
    currency,
    kind,
    amount,
    day,
    explanation,
    refId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rewards';
  @override
  VerificationContext validateIntegrity(
    Insertable<RewardRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('explanation')) {
      context.handle(
        _explanationMeta,
        explanation.isAcceptableOrUnknown(
          data['explanation']!,
          _explanationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_explanationMeta);
    }
    if (data.containsKey('ref_id')) {
      context.handle(
        _refIdMeta,
        refId.isAcceptableOrUnknown(data['ref_id']!, _refIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RewardRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RewardRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}day'],
      )!,
      explanation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explanation'],
      )!,
      refId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ref_id'],
      ),
    );
  }

  @override
  $RewardsTable createAlias(String alias) {
    return $RewardsTable(attachedDatabase, alias);
  }
}

class RewardRow extends DataClass implements Insertable<RewardRow> {
  final String id;
  final DateTime updatedAt;
  final bool deleted;
  final bool dirty;
  final String currency;
  final String kind;
  final int amount;
  final DateTime day;
  final String explanation;
  final String? refId;
  const RewardRow({
    required this.id,
    required this.updatedAt,
    required this.deleted,
    required this.dirty,
    required this.currency,
    required this.kind,
    required this.amount,
    required this.day,
    required this.explanation,
    this.refId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    map['dirty'] = Variable<bool>(dirty);
    map['currency'] = Variable<String>(currency);
    map['kind'] = Variable<String>(kind);
    map['amount'] = Variable<int>(amount);
    map['day'] = Variable<DateTime>(day);
    map['explanation'] = Variable<String>(explanation);
    if (!nullToAbsent || refId != null) {
      map['ref_id'] = Variable<String>(refId);
    }
    return map;
  }

  RewardsCompanion toCompanion(bool nullToAbsent) {
    return RewardsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
      dirty: Value(dirty),
      currency: Value(currency),
      kind: Value(kind),
      amount: Value(amount),
      day: Value(day),
      explanation: Value(explanation),
      refId: refId == null && nullToAbsent
          ? const Value.absent()
          : Value(refId),
    );
  }

  factory RewardRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RewardRow(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      currency: serializer.fromJson<String>(json['currency']),
      kind: serializer.fromJson<String>(json['kind']),
      amount: serializer.fromJson<int>(json['amount']),
      day: serializer.fromJson<DateTime>(json['day']),
      explanation: serializer.fromJson<String>(json['explanation']),
      refId: serializer.fromJson<String?>(json['refId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
      'dirty': serializer.toJson<bool>(dirty),
      'currency': serializer.toJson<String>(currency),
      'kind': serializer.toJson<String>(kind),
      'amount': serializer.toJson<int>(amount),
      'day': serializer.toJson<DateTime>(day),
      'explanation': serializer.toJson<String>(explanation),
      'refId': serializer.toJson<String?>(refId),
    };
  }

  RewardRow copyWith({
    String? id,
    DateTime? updatedAt,
    bool? deleted,
    bool? dirty,
    String? currency,
    String? kind,
    int? amount,
    DateTime? day,
    String? explanation,
    Value<String?> refId = const Value.absent(),
  }) => RewardRow(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
    dirty: dirty ?? this.dirty,
    currency: currency ?? this.currency,
    kind: kind ?? this.kind,
    amount: amount ?? this.amount,
    day: day ?? this.day,
    explanation: explanation ?? this.explanation,
    refId: refId.present ? refId.value : this.refId,
  );
  RewardRow copyWithCompanion(RewardsCompanion data) {
    return RewardRow(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      currency: data.currency.present ? data.currency.value : this.currency,
      kind: data.kind.present ? data.kind.value : this.kind,
      amount: data.amount.present ? data.amount.value : this.amount,
      day: data.day.present ? data.day.value : this.day,
      explanation: data.explanation.present
          ? data.explanation.value
          : this.explanation,
      refId: data.refId.present ? data.refId.value : this.refId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RewardRow(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('currency: $currency, ')
          ..write('kind: $kind, ')
          ..write('amount: $amount, ')
          ..write('day: $day, ')
          ..write('explanation: $explanation, ')
          ..write('refId: $refId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    deleted,
    dirty,
    currency,
    kind,
    amount,
    day,
    explanation,
    refId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RewardRow &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted &&
          other.dirty == this.dirty &&
          other.currency == this.currency &&
          other.kind == this.kind &&
          other.amount == this.amount &&
          other.day == this.day &&
          other.explanation == this.explanation &&
          other.refId == this.refId);
}

class RewardsCompanion extends UpdateCompanion<RewardRow> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  final Value<bool> dirty;
  final Value<String> currency;
  final Value<String> kind;
  final Value<int> amount;
  final Value<DateTime> day;
  final Value<String> explanation;
  final Value<String?> refId;
  final Value<int> rowid;
  const RewardsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.currency = const Value.absent(),
    this.kind = const Value.absent(),
    this.amount = const Value.absent(),
    this.day = const Value.absent(),
    this.explanation = const Value.absent(),
    this.refId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RewardsCompanion.insert({
    required String id,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String currency,
    required String kind,
    required int amount,
    required DateTime day,
    required String explanation,
    this.refId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       updatedAt = Value(updatedAt),
       currency = Value(currency),
       kind = Value(kind),
       amount = Value(amount),
       day = Value(day),
       explanation = Value(explanation);
  static Insertable<RewardRow> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
    Expression<bool>? dirty,
    Expression<String>? currency,
    Expression<String>? kind,
    Expression<int>? amount,
    Expression<DateTime>? day,
    Expression<String>? explanation,
    Expression<String>? refId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
      if (dirty != null) 'dirty': dirty,
      if (currency != null) 'currency': currency,
      if (kind != null) 'kind': kind,
      if (amount != null) 'amount': amount,
      if (day != null) 'day': day,
      if (explanation != null) 'explanation': explanation,
      if (refId != null) 'ref_id': refId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RewardsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
    Value<bool>? dirty,
    Value<String>? currency,
    Value<String>? kind,
    Value<int>? amount,
    Value<DateTime>? day,
    Value<String>? explanation,
    Value<String?>? refId,
    Value<int>? rowid,
  }) {
    return RewardsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      dirty: dirty ?? this.dirty,
      currency: currency ?? this.currency,
      kind: kind ?? this.kind,
      amount: amount ?? this.amount,
      day: day ?? this.day,
      explanation: explanation ?? this.explanation,
      refId: refId ?? this.refId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (day.present) {
      map['day'] = Variable<DateTime>(day.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (refId.present) {
      map['ref_id'] = Variable<String>(refId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RewardsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('currency: $currency, ')
          ..write('kind: $kind, ')
          ..write('amount: $amount, ')
          ..write('day: $day, ')
          ..write('explanation: $explanation, ')
          ..write('refId: $refId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecoveriesTable extends Recoveries
    with TableInfo<$RecoveriesTable, RecoveryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecoveriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedOnMeta = const VerificationMeta(
    'startedOn',
  );
  @override
  late final GeneratedColumn<DateTime> startedOn = GeneratedColumn<DateTime>(
    'started_on',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedOnMeta = const VerificationMeta(
    'completedOn',
  );
  @override
  late final GeneratedColumn<DateTime> completedOn = GeneratedColumn<DateTime>(
    'completed_on',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _forgivenMeta = const VerificationMeta(
    'forgiven',
  );
  @override
  late final GeneratedColumn<String> forgiven = GeneratedColumn<String>(
    'forgiven',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    deleted,
    dirty,
    habitId,
    startedOn,
    completedOn,
    forgiven,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recoveries';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecoveryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('started_on')) {
      context.handle(
        _startedOnMeta,
        startedOn.isAcceptableOrUnknown(data['started_on']!, _startedOnMeta),
      );
    } else if (isInserting) {
      context.missing(_startedOnMeta);
    }
    if (data.containsKey('completed_on')) {
      context.handle(
        _completedOnMeta,
        completedOn.isAcceptableOrUnknown(
          data['completed_on']!,
          _completedOnMeta,
        ),
      );
    }
    if (data.containsKey('forgiven')) {
      context.handle(
        _forgivenMeta,
        forgiven.isAcceptableOrUnknown(data['forgiven']!, _forgivenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecoveryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecoveryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      startedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_on'],
      )!,
      completedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_on'],
      ),
      forgiven: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}forgiven'],
      )!,
    );
  }

  @override
  $RecoveriesTable createAlias(String alias) {
    return $RecoveriesTable(attachedDatabase, alias);
  }
}

class RecoveryRow extends DataClass implements Insertable<RecoveryRow> {
  final String id;
  final DateTime updatedAt;
  final bool deleted;
  final bool dirty;
  final String habitId;
  final DateTime startedOn;
  final DateTime? completedOn;

  /// JSON list of forgiven miss days (yyyy-mm-dd).
  final String forgiven;
  const RecoveryRow({
    required this.id,
    required this.updatedAt,
    required this.deleted,
    required this.dirty,
    required this.habitId,
    required this.startedOn,
    this.completedOn,
    required this.forgiven,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    map['dirty'] = Variable<bool>(dirty);
    map['habit_id'] = Variable<String>(habitId);
    map['started_on'] = Variable<DateTime>(startedOn);
    if (!nullToAbsent || completedOn != null) {
      map['completed_on'] = Variable<DateTime>(completedOn);
    }
    map['forgiven'] = Variable<String>(forgiven);
    return map;
  }

  RecoveriesCompanion toCompanion(bool nullToAbsent) {
    return RecoveriesCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
      dirty: Value(dirty),
      habitId: Value(habitId),
      startedOn: Value(startedOn),
      completedOn: completedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(completedOn),
      forgiven: Value(forgiven),
    );
  }

  factory RecoveryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecoveryRow(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      habitId: serializer.fromJson<String>(json['habitId']),
      startedOn: serializer.fromJson<DateTime>(json['startedOn']),
      completedOn: serializer.fromJson<DateTime?>(json['completedOn']),
      forgiven: serializer.fromJson<String>(json['forgiven']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
      'dirty': serializer.toJson<bool>(dirty),
      'habitId': serializer.toJson<String>(habitId),
      'startedOn': serializer.toJson<DateTime>(startedOn),
      'completedOn': serializer.toJson<DateTime?>(completedOn),
      'forgiven': serializer.toJson<String>(forgiven),
    };
  }

  RecoveryRow copyWith({
    String? id,
    DateTime? updatedAt,
    bool? deleted,
    bool? dirty,
    String? habitId,
    DateTime? startedOn,
    Value<DateTime?> completedOn = const Value.absent(),
    String? forgiven,
  }) => RecoveryRow(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
    dirty: dirty ?? this.dirty,
    habitId: habitId ?? this.habitId,
    startedOn: startedOn ?? this.startedOn,
    completedOn: completedOn.present ? completedOn.value : this.completedOn,
    forgiven: forgiven ?? this.forgiven,
  );
  RecoveryRow copyWithCompanion(RecoveriesCompanion data) {
    return RecoveryRow(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      startedOn: data.startedOn.present ? data.startedOn.value : this.startedOn,
      completedOn: data.completedOn.present
          ? data.completedOn.value
          : this.completedOn,
      forgiven: data.forgiven.present ? data.forgiven.value : this.forgiven,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecoveryRow(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('habitId: $habitId, ')
          ..write('startedOn: $startedOn, ')
          ..write('completedOn: $completedOn, ')
          ..write('forgiven: $forgiven')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    deleted,
    dirty,
    habitId,
    startedOn,
    completedOn,
    forgiven,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecoveryRow &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted &&
          other.dirty == this.dirty &&
          other.habitId == this.habitId &&
          other.startedOn == this.startedOn &&
          other.completedOn == this.completedOn &&
          other.forgiven == this.forgiven);
}

class RecoveriesCompanion extends UpdateCompanion<RecoveryRow> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  final Value<bool> dirty;
  final Value<String> habitId;
  final Value<DateTime> startedOn;
  final Value<DateTime?> completedOn;
  final Value<String> forgiven;
  final Value<int> rowid;
  const RecoveriesCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.habitId = const Value.absent(),
    this.startedOn = const Value.absent(),
    this.completedOn = const Value.absent(),
    this.forgiven = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecoveriesCompanion.insert({
    required String id,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String habitId,
    required DateTime startedOn,
    this.completedOn = const Value.absent(),
    this.forgiven = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       updatedAt = Value(updatedAt),
       habitId = Value(habitId),
       startedOn = Value(startedOn);
  static Insertable<RecoveryRow> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
    Expression<bool>? dirty,
    Expression<String>? habitId,
    Expression<DateTime>? startedOn,
    Expression<DateTime>? completedOn,
    Expression<String>? forgiven,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
      if (dirty != null) 'dirty': dirty,
      if (habitId != null) 'habit_id': habitId,
      if (startedOn != null) 'started_on': startedOn,
      if (completedOn != null) 'completed_on': completedOn,
      if (forgiven != null) 'forgiven': forgiven,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecoveriesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
    Value<bool>? dirty,
    Value<String>? habitId,
    Value<DateTime>? startedOn,
    Value<DateTime?>? completedOn,
    Value<String>? forgiven,
    Value<int>? rowid,
  }) {
    return RecoveriesCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      dirty: dirty ?? this.dirty,
      habitId: habitId ?? this.habitId,
      startedOn: startedOn ?? this.startedOn,
      completedOn: completedOn ?? this.completedOn,
      forgiven: forgiven ?? this.forgiven,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (startedOn.present) {
      map['started_on'] = Variable<DateTime>(startedOn.value);
    }
    if (completedOn.present) {
      map['completed_on'] = Variable<DateTime>(completedOn.value);
    }
    if (forgiven.present) {
      map['forgiven'] = Variable<String>(forgiven.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecoveriesCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('habitId: $habitId, ')
          ..write('startedOn: $startedOn, ')
          ..write('completedOn: $completedOn, ')
          ..write('forgiven: $forgiven, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VisionsTable extends Visions with TableInfo<$VisionsTable, VisionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VisionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _whyMeta = const VerificationMeta('why');
  @override
  late final GeneratedColumn<String> why = GeneratedColumn<String>(
    'why',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetValueMeta = const VerificationMeta(
    'targetValue',
  );
  @override
  late final GeneratedColumn<double> targetValue = GeneratedColumn<double>(
    'target_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentValueMeta = const VerificationMeta(
    'currentValue',
  );
  @override
  late final GeneratedColumn<double> currentValue = GeneratedColumn<double>(
    'current_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _startedOnMeta = const VerificationMeta(
    'startedOn',
  );
  @override
  late final GeneratedColumn<DateTime> startedOn = GeneratedColumn<DateTime>(
    'started_on',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deadlineMeta = const VerificationMeta(
    'deadline',
  );
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
    'deadline',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ambitionMeta = const VerificationMeta(
    'ambition',
  );
  @override
  late final GeneratedColumn<double> ambition = GeneratedColumn<double>(
    'ambition',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedOnMeta = const VerificationMeta(
    'completedOn',
  );
  @override
  late final GeneratedColumn<DateTime> completedOn = GeneratedColumn<DateTime>(
    'completed_on',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    deleted,
    dirty,
    title,
    why,
    category,
    targetValue,
    unit,
    currentValue,
    startedOn,
    deadline,
    ambition,
    completedOn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'visions';
  @override
  VerificationContext validateIntegrity(
    Insertable<VisionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('why')) {
      context.handle(
        _whyMeta,
        why.isAcceptableOrUnknown(data['why']!, _whyMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('target_value')) {
      context.handle(
        _targetValueMeta,
        targetValue.isAcceptableOrUnknown(
          data['target_value']!,
          _targetValueMeta,
        ),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('current_value')) {
      context.handle(
        _currentValueMeta,
        currentValue.isAcceptableOrUnknown(
          data['current_value']!,
          _currentValueMeta,
        ),
      );
    }
    if (data.containsKey('started_on')) {
      context.handle(
        _startedOnMeta,
        startedOn.isAcceptableOrUnknown(data['started_on']!, _startedOnMeta),
      );
    } else if (isInserting) {
      context.missing(_startedOnMeta);
    }
    if (data.containsKey('deadline')) {
      context.handle(
        _deadlineMeta,
        deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta),
      );
    } else if (isInserting) {
      context.missing(_deadlineMeta);
    }
    if (data.containsKey('ambition')) {
      context.handle(
        _ambitionMeta,
        ambition.isAcceptableOrUnknown(data['ambition']!, _ambitionMeta),
      );
    }
    if (data.containsKey('completed_on')) {
      context.handle(
        _completedOnMeta,
        completedOn.isAcceptableOrUnknown(
          data['completed_on']!,
          _completedOnMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VisionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VisionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      why: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}why'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      targetValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_value'],
      ),
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
      currentValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_value'],
      )!,
      startedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_on'],
      )!,
      deadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deadline'],
      )!,
      ambition: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ambition'],
      ),
      completedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_on'],
      ),
    );
  }

  @override
  $VisionsTable createAlias(String alias) {
    return $VisionsTable(attachedDatabase, alias);
  }
}

class VisionRow extends DataClass implements Insertable<VisionRow> {
  final String id;
  final DateTime updatedAt;
  final bool deleted;
  final bool dirty;
  final String title;
  final String? why;
  final String category;
  final double? targetValue;
  final String? unit;
  final double currentValue;
  final DateTime startedOn;
  final DateTime deadline;
  final double? ambition;
  final DateTime? completedOn;
  const VisionRow({
    required this.id,
    required this.updatedAt,
    required this.deleted,
    required this.dirty,
    required this.title,
    this.why,
    required this.category,
    this.targetValue,
    this.unit,
    required this.currentValue,
    required this.startedOn,
    required this.deadline,
    this.ambition,
    this.completedOn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    map['dirty'] = Variable<bool>(dirty);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || why != null) {
      map['why'] = Variable<String>(why);
    }
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || targetValue != null) {
      map['target_value'] = Variable<double>(targetValue);
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    map['current_value'] = Variable<double>(currentValue);
    map['started_on'] = Variable<DateTime>(startedOn);
    map['deadline'] = Variable<DateTime>(deadline);
    if (!nullToAbsent || ambition != null) {
      map['ambition'] = Variable<double>(ambition);
    }
    if (!nullToAbsent || completedOn != null) {
      map['completed_on'] = Variable<DateTime>(completedOn);
    }
    return map;
  }

  VisionsCompanion toCompanion(bool nullToAbsent) {
    return VisionsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
      dirty: Value(dirty),
      title: Value(title),
      why: why == null && nullToAbsent ? const Value.absent() : Value(why),
      category: Value(category),
      targetValue: targetValue == null && nullToAbsent
          ? const Value.absent()
          : Value(targetValue),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      currentValue: Value(currentValue),
      startedOn: Value(startedOn),
      deadline: Value(deadline),
      ambition: ambition == null && nullToAbsent
          ? const Value.absent()
          : Value(ambition),
      completedOn: completedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(completedOn),
    );
  }

  factory VisionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VisionRow(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      title: serializer.fromJson<String>(json['title']),
      why: serializer.fromJson<String?>(json['why']),
      category: serializer.fromJson<String>(json['category']),
      targetValue: serializer.fromJson<double?>(json['targetValue']),
      unit: serializer.fromJson<String?>(json['unit']),
      currentValue: serializer.fromJson<double>(json['currentValue']),
      startedOn: serializer.fromJson<DateTime>(json['startedOn']),
      deadline: serializer.fromJson<DateTime>(json['deadline']),
      ambition: serializer.fromJson<double?>(json['ambition']),
      completedOn: serializer.fromJson<DateTime?>(json['completedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
      'dirty': serializer.toJson<bool>(dirty),
      'title': serializer.toJson<String>(title),
      'why': serializer.toJson<String?>(why),
      'category': serializer.toJson<String>(category),
      'targetValue': serializer.toJson<double?>(targetValue),
      'unit': serializer.toJson<String?>(unit),
      'currentValue': serializer.toJson<double>(currentValue),
      'startedOn': serializer.toJson<DateTime>(startedOn),
      'deadline': serializer.toJson<DateTime>(deadline),
      'ambition': serializer.toJson<double?>(ambition),
      'completedOn': serializer.toJson<DateTime?>(completedOn),
    };
  }

  VisionRow copyWith({
    String? id,
    DateTime? updatedAt,
    bool? deleted,
    bool? dirty,
    String? title,
    Value<String?> why = const Value.absent(),
    String? category,
    Value<double?> targetValue = const Value.absent(),
    Value<String?> unit = const Value.absent(),
    double? currentValue,
    DateTime? startedOn,
    DateTime? deadline,
    Value<double?> ambition = const Value.absent(),
    Value<DateTime?> completedOn = const Value.absent(),
  }) => VisionRow(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
    dirty: dirty ?? this.dirty,
    title: title ?? this.title,
    why: why.present ? why.value : this.why,
    category: category ?? this.category,
    targetValue: targetValue.present ? targetValue.value : this.targetValue,
    unit: unit.present ? unit.value : this.unit,
    currentValue: currentValue ?? this.currentValue,
    startedOn: startedOn ?? this.startedOn,
    deadline: deadline ?? this.deadline,
    ambition: ambition.present ? ambition.value : this.ambition,
    completedOn: completedOn.present ? completedOn.value : this.completedOn,
  );
  VisionRow copyWithCompanion(VisionsCompanion data) {
    return VisionRow(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      title: data.title.present ? data.title.value : this.title,
      why: data.why.present ? data.why.value : this.why,
      category: data.category.present ? data.category.value : this.category,
      targetValue: data.targetValue.present
          ? data.targetValue.value
          : this.targetValue,
      unit: data.unit.present ? data.unit.value : this.unit,
      currentValue: data.currentValue.present
          ? data.currentValue.value
          : this.currentValue,
      startedOn: data.startedOn.present ? data.startedOn.value : this.startedOn,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      ambition: data.ambition.present ? data.ambition.value : this.ambition,
      completedOn: data.completedOn.present
          ? data.completedOn.value
          : this.completedOn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VisionRow(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('title: $title, ')
          ..write('why: $why, ')
          ..write('category: $category, ')
          ..write('targetValue: $targetValue, ')
          ..write('unit: $unit, ')
          ..write('currentValue: $currentValue, ')
          ..write('startedOn: $startedOn, ')
          ..write('deadline: $deadline, ')
          ..write('ambition: $ambition, ')
          ..write('completedOn: $completedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    deleted,
    dirty,
    title,
    why,
    category,
    targetValue,
    unit,
    currentValue,
    startedOn,
    deadline,
    ambition,
    completedOn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VisionRow &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted &&
          other.dirty == this.dirty &&
          other.title == this.title &&
          other.why == this.why &&
          other.category == this.category &&
          other.targetValue == this.targetValue &&
          other.unit == this.unit &&
          other.currentValue == this.currentValue &&
          other.startedOn == this.startedOn &&
          other.deadline == this.deadline &&
          other.ambition == this.ambition &&
          other.completedOn == this.completedOn);
}

class VisionsCompanion extends UpdateCompanion<VisionRow> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  final Value<bool> dirty;
  final Value<String> title;
  final Value<String?> why;
  final Value<String> category;
  final Value<double?> targetValue;
  final Value<String?> unit;
  final Value<double> currentValue;
  final Value<DateTime> startedOn;
  final Value<DateTime> deadline;
  final Value<double?> ambition;
  final Value<DateTime?> completedOn;
  final Value<int> rowid;
  const VisionsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.title = const Value.absent(),
    this.why = const Value.absent(),
    this.category = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.unit = const Value.absent(),
    this.currentValue = const Value.absent(),
    this.startedOn = const Value.absent(),
    this.deadline = const Value.absent(),
    this.ambition = const Value.absent(),
    this.completedOn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VisionsCompanion.insert({
    required String id,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String title,
    this.why = const Value.absent(),
    required String category,
    this.targetValue = const Value.absent(),
    this.unit = const Value.absent(),
    this.currentValue = const Value.absent(),
    required DateTime startedOn,
    required DateTime deadline,
    this.ambition = const Value.absent(),
    this.completedOn = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       updatedAt = Value(updatedAt),
       title = Value(title),
       category = Value(category),
       startedOn = Value(startedOn),
       deadline = Value(deadline);
  static Insertable<VisionRow> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
    Expression<bool>? dirty,
    Expression<String>? title,
    Expression<String>? why,
    Expression<String>? category,
    Expression<double>? targetValue,
    Expression<String>? unit,
    Expression<double>? currentValue,
    Expression<DateTime>? startedOn,
    Expression<DateTime>? deadline,
    Expression<double>? ambition,
    Expression<DateTime>? completedOn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
      if (dirty != null) 'dirty': dirty,
      if (title != null) 'title': title,
      if (why != null) 'why': why,
      if (category != null) 'category': category,
      if (targetValue != null) 'target_value': targetValue,
      if (unit != null) 'unit': unit,
      if (currentValue != null) 'current_value': currentValue,
      if (startedOn != null) 'started_on': startedOn,
      if (deadline != null) 'deadline': deadline,
      if (ambition != null) 'ambition': ambition,
      if (completedOn != null) 'completed_on': completedOn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VisionsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
    Value<bool>? dirty,
    Value<String>? title,
    Value<String?>? why,
    Value<String>? category,
    Value<double?>? targetValue,
    Value<String?>? unit,
    Value<double>? currentValue,
    Value<DateTime>? startedOn,
    Value<DateTime>? deadline,
    Value<double?>? ambition,
    Value<DateTime?>? completedOn,
    Value<int>? rowid,
  }) {
    return VisionsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      dirty: dirty ?? this.dirty,
      title: title ?? this.title,
      why: why ?? this.why,
      category: category ?? this.category,
      targetValue: targetValue ?? this.targetValue,
      unit: unit ?? this.unit,
      currentValue: currentValue ?? this.currentValue,
      startedOn: startedOn ?? this.startedOn,
      deadline: deadline ?? this.deadline,
      ambition: ambition ?? this.ambition,
      completedOn: completedOn ?? this.completedOn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (why.present) {
      map['why'] = Variable<String>(why.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<double>(targetValue.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (currentValue.present) {
      map['current_value'] = Variable<double>(currentValue.value);
    }
    if (startedOn.present) {
      map['started_on'] = Variable<DateTime>(startedOn.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (ambition.present) {
      map['ambition'] = Variable<double>(ambition.value);
    }
    if (completedOn.present) {
      map['completed_on'] = Variable<DateTime>(completedOn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisionsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('title: $title, ')
          ..write('why: $why, ')
          ..write('category: $category, ')
          ..write('targetValue: $targetValue, ')
          ..write('unit: $unit, ')
          ..write('currentValue: $currentValue, ')
          ..write('startedOn: $startedOn, ')
          ..write('deadline: $deadline, ')
          ..write('ambition: $ambition, ')
          ..write('completedOn: $completedOn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MilestonesTable extends Milestones
    with TableInfo<$MilestonesTable, MilestoneRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MilestonesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _visionIdMeta = const VerificationMeta(
    'visionId',
  );
  @override
  late final GeneratedColumn<String> visionId = GeneratedColumn<String>(
    'vision_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetValueMeta = const VerificationMeta(
    'targetValue',
  );
  @override
  late final GeneratedColumn<double> targetValue = GeneratedColumn<double>(
    'target_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _completedOnMeta = const VerificationMeta(
    'completedOn',
  );
  @override
  late final GeneratedColumn<DateTime> completedOn = GeneratedColumn<DateTime>(
    'completed_on',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    deleted,
    dirty,
    visionId,
    title,
    targetValue,
    position,
    completedOn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'milestones';
  @override
  VerificationContext validateIntegrity(
    Insertable<MilestoneRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('vision_id')) {
      context.handle(
        _visionIdMeta,
        visionId.isAcceptableOrUnknown(data['vision_id']!, _visionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_visionIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('target_value')) {
      context.handle(
        _targetValueMeta,
        targetValue.isAcceptableOrUnknown(
          data['target_value']!,
          _targetValueMeta,
        ),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    if (data.containsKey('completed_on')) {
      context.handle(
        _completedOnMeta,
        completedOn.isAcceptableOrUnknown(
          data['completed_on']!,
          _completedOnMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MilestoneRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MilestoneRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      visionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vision_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      targetValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_value'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      completedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_on'],
      ),
    );
  }

  @override
  $MilestonesTable createAlias(String alias) {
    return $MilestonesTable(attachedDatabase, alias);
  }
}

class MilestoneRow extends DataClass implements Insertable<MilestoneRow> {
  final String id;
  final DateTime updatedAt;
  final bool deleted;
  final bool dirty;
  final String visionId;
  final String title;
  final double? targetValue;
  final int position;
  final DateTime? completedOn;
  const MilestoneRow({
    required this.id,
    required this.updatedAt,
    required this.deleted,
    required this.dirty,
    required this.visionId,
    required this.title,
    this.targetValue,
    required this.position,
    this.completedOn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    map['dirty'] = Variable<bool>(dirty);
    map['vision_id'] = Variable<String>(visionId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || targetValue != null) {
      map['target_value'] = Variable<double>(targetValue);
    }
    map['position'] = Variable<int>(position);
    if (!nullToAbsent || completedOn != null) {
      map['completed_on'] = Variable<DateTime>(completedOn);
    }
    return map;
  }

  MilestonesCompanion toCompanion(bool nullToAbsent) {
    return MilestonesCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
      dirty: Value(dirty),
      visionId: Value(visionId),
      title: Value(title),
      targetValue: targetValue == null && nullToAbsent
          ? const Value.absent()
          : Value(targetValue),
      position: Value(position),
      completedOn: completedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(completedOn),
    );
  }

  factory MilestoneRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MilestoneRow(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      visionId: serializer.fromJson<String>(json['visionId']),
      title: serializer.fromJson<String>(json['title']),
      targetValue: serializer.fromJson<double?>(json['targetValue']),
      position: serializer.fromJson<int>(json['position']),
      completedOn: serializer.fromJson<DateTime?>(json['completedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
      'dirty': serializer.toJson<bool>(dirty),
      'visionId': serializer.toJson<String>(visionId),
      'title': serializer.toJson<String>(title),
      'targetValue': serializer.toJson<double?>(targetValue),
      'position': serializer.toJson<int>(position),
      'completedOn': serializer.toJson<DateTime?>(completedOn),
    };
  }

  MilestoneRow copyWith({
    String? id,
    DateTime? updatedAt,
    bool? deleted,
    bool? dirty,
    String? visionId,
    String? title,
    Value<double?> targetValue = const Value.absent(),
    int? position,
    Value<DateTime?> completedOn = const Value.absent(),
  }) => MilestoneRow(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
    dirty: dirty ?? this.dirty,
    visionId: visionId ?? this.visionId,
    title: title ?? this.title,
    targetValue: targetValue.present ? targetValue.value : this.targetValue,
    position: position ?? this.position,
    completedOn: completedOn.present ? completedOn.value : this.completedOn,
  );
  MilestoneRow copyWithCompanion(MilestonesCompanion data) {
    return MilestoneRow(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      visionId: data.visionId.present ? data.visionId.value : this.visionId,
      title: data.title.present ? data.title.value : this.title,
      targetValue: data.targetValue.present
          ? data.targetValue.value
          : this.targetValue,
      position: data.position.present ? data.position.value : this.position,
      completedOn: data.completedOn.present
          ? data.completedOn.value
          : this.completedOn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MilestoneRow(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('visionId: $visionId, ')
          ..write('title: $title, ')
          ..write('targetValue: $targetValue, ')
          ..write('position: $position, ')
          ..write('completedOn: $completedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    deleted,
    dirty,
    visionId,
    title,
    targetValue,
    position,
    completedOn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MilestoneRow &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted &&
          other.dirty == this.dirty &&
          other.visionId == this.visionId &&
          other.title == this.title &&
          other.targetValue == this.targetValue &&
          other.position == this.position &&
          other.completedOn == this.completedOn);
}

class MilestonesCompanion extends UpdateCompanion<MilestoneRow> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  final Value<bool> dirty;
  final Value<String> visionId;
  final Value<String> title;
  final Value<double?> targetValue;
  final Value<int> position;
  final Value<DateTime?> completedOn;
  final Value<int> rowid;
  const MilestonesCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.visionId = const Value.absent(),
    this.title = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.position = const Value.absent(),
    this.completedOn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MilestonesCompanion.insert({
    required String id,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String visionId,
    required String title,
    this.targetValue = const Value.absent(),
    this.position = const Value.absent(),
    this.completedOn = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       updatedAt = Value(updatedAt),
       visionId = Value(visionId),
       title = Value(title);
  static Insertable<MilestoneRow> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
    Expression<bool>? dirty,
    Expression<String>? visionId,
    Expression<String>? title,
    Expression<double>? targetValue,
    Expression<int>? position,
    Expression<DateTime>? completedOn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
      if (dirty != null) 'dirty': dirty,
      if (visionId != null) 'vision_id': visionId,
      if (title != null) 'title': title,
      if (targetValue != null) 'target_value': targetValue,
      if (position != null) 'position': position,
      if (completedOn != null) 'completed_on': completedOn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MilestonesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
    Value<bool>? dirty,
    Value<String>? visionId,
    Value<String>? title,
    Value<double?>? targetValue,
    Value<int>? position,
    Value<DateTime?>? completedOn,
    Value<int>? rowid,
  }) {
    return MilestonesCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      dirty: dirty ?? this.dirty,
      visionId: visionId ?? this.visionId,
      title: title ?? this.title,
      targetValue: targetValue ?? this.targetValue,
      position: position ?? this.position,
      completedOn: completedOn ?? this.completedOn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (visionId.present) {
      map['vision_id'] = Variable<String>(visionId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<double>(targetValue.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (completedOn.present) {
      map['completed_on'] = Variable<DateTime>(completedOn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MilestonesCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('visionId: $visionId, ')
          ..write('title: $title, ')
          ..write('targetValue: $targetValue, ')
          ..write('position: $position, ')
          ..write('completedOn: $completedOn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FinanceSettingsTableTable extends FinanceSettingsTable
    with TableInfo<$FinanceSettingsTableTable, FinanceSettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinanceSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _essentialsWeeklyMeta = const VerificationMeta(
    'essentialsWeekly',
  );
  @override
  late final GeneratedColumn<int> essentialsWeekly = GeneratedColumn<int>(
    'essentials_weekly',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _funWeeklyMeta = const VerificationMeta(
    'funWeekly',
  );
  @override
  late final GeneratedColumn<int> funWeekly = GeneratedColumn<int>(
    'fun_weekly',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dailySavingsTargetMeta =
      const VerificationMeta('dailySavingsTarget');
  @override
  late final GeneratedColumn<int> dailySavingsTarget = GeneratedColumn<int>(
    'daily_savings_target',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _penaltiesEnabledMeta = const VerificationMeta(
    'penaltiesEnabled',
  );
  @override
  late final GeneratedColumn<bool> penaltiesEnabled = GeneratedColumn<bool>(
    'penalties_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("penalties_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('KSh'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    deleted,
    dirty,
    essentialsWeekly,
    funWeekly,
    dailySavingsTarget,
    penaltiesEnabled,
    currency,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'finance_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinanceSettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('essentials_weekly')) {
      context.handle(
        _essentialsWeeklyMeta,
        essentialsWeekly.isAcceptableOrUnknown(
          data['essentials_weekly']!,
          _essentialsWeeklyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_essentialsWeeklyMeta);
    }
    if (data.containsKey('fun_weekly')) {
      context.handle(
        _funWeeklyMeta,
        funWeekly.isAcceptableOrUnknown(data['fun_weekly']!, _funWeeklyMeta),
      );
    } else if (isInserting) {
      context.missing(_funWeeklyMeta);
    }
    if (data.containsKey('daily_savings_target')) {
      context.handle(
        _dailySavingsTargetMeta,
        dailySavingsTarget.isAcceptableOrUnknown(
          data['daily_savings_target']!,
          _dailySavingsTargetMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailySavingsTargetMeta);
    }
    if (data.containsKey('penalties_enabled')) {
      context.handle(
        _penaltiesEnabledMeta,
        penaltiesEnabled.isAcceptableOrUnknown(
          data['penalties_enabled']!,
          _penaltiesEnabledMeta,
        ),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FinanceSettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinanceSettingsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      essentialsWeekly: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}essentials_weekly'],
      )!,
      funWeekly: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fun_weekly'],
      )!,
      dailySavingsTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_savings_target'],
      )!,
      penaltiesEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}penalties_enabled'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
    );
  }

  @override
  $FinanceSettingsTableTable createAlias(String alias) {
    return $FinanceSettingsTableTable(attachedDatabase, alias);
  }
}

class FinanceSettingsRow extends DataClass
    implements Insertable<FinanceSettingsRow> {
  final String id;
  final DateTime updatedAt;
  final bool deleted;
  final bool dirty;
  final int essentialsWeekly;
  final int funWeekly;
  final int dailySavingsTarget;
  final bool penaltiesEnabled;
  final String currency;
  const FinanceSettingsRow({
    required this.id,
    required this.updatedAt,
    required this.deleted,
    required this.dirty,
    required this.essentialsWeekly,
    required this.funWeekly,
    required this.dailySavingsTarget,
    required this.penaltiesEnabled,
    required this.currency,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    map['dirty'] = Variable<bool>(dirty);
    map['essentials_weekly'] = Variable<int>(essentialsWeekly);
    map['fun_weekly'] = Variable<int>(funWeekly);
    map['daily_savings_target'] = Variable<int>(dailySavingsTarget);
    map['penalties_enabled'] = Variable<bool>(penaltiesEnabled);
    map['currency'] = Variable<String>(currency);
    return map;
  }

  FinanceSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return FinanceSettingsTableCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
      dirty: Value(dirty),
      essentialsWeekly: Value(essentialsWeekly),
      funWeekly: Value(funWeekly),
      dailySavingsTarget: Value(dailySavingsTarget),
      penaltiesEnabled: Value(penaltiesEnabled),
      currency: Value(currency),
    );
  }

  factory FinanceSettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinanceSettingsRow(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      essentialsWeekly: serializer.fromJson<int>(json['essentialsWeekly']),
      funWeekly: serializer.fromJson<int>(json['funWeekly']),
      dailySavingsTarget: serializer.fromJson<int>(json['dailySavingsTarget']),
      penaltiesEnabled: serializer.fromJson<bool>(json['penaltiesEnabled']),
      currency: serializer.fromJson<String>(json['currency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
      'dirty': serializer.toJson<bool>(dirty),
      'essentialsWeekly': serializer.toJson<int>(essentialsWeekly),
      'funWeekly': serializer.toJson<int>(funWeekly),
      'dailySavingsTarget': serializer.toJson<int>(dailySavingsTarget),
      'penaltiesEnabled': serializer.toJson<bool>(penaltiesEnabled),
      'currency': serializer.toJson<String>(currency),
    };
  }

  FinanceSettingsRow copyWith({
    String? id,
    DateTime? updatedAt,
    bool? deleted,
    bool? dirty,
    int? essentialsWeekly,
    int? funWeekly,
    int? dailySavingsTarget,
    bool? penaltiesEnabled,
    String? currency,
  }) => FinanceSettingsRow(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
    dirty: dirty ?? this.dirty,
    essentialsWeekly: essentialsWeekly ?? this.essentialsWeekly,
    funWeekly: funWeekly ?? this.funWeekly,
    dailySavingsTarget: dailySavingsTarget ?? this.dailySavingsTarget,
    penaltiesEnabled: penaltiesEnabled ?? this.penaltiesEnabled,
    currency: currency ?? this.currency,
  );
  FinanceSettingsRow copyWithCompanion(FinanceSettingsTableCompanion data) {
    return FinanceSettingsRow(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      essentialsWeekly: data.essentialsWeekly.present
          ? data.essentialsWeekly.value
          : this.essentialsWeekly,
      funWeekly: data.funWeekly.present ? data.funWeekly.value : this.funWeekly,
      dailySavingsTarget: data.dailySavingsTarget.present
          ? data.dailySavingsTarget.value
          : this.dailySavingsTarget,
      penaltiesEnabled: data.penaltiesEnabled.present
          ? data.penaltiesEnabled.value
          : this.penaltiesEnabled,
      currency: data.currency.present ? data.currency.value : this.currency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinanceSettingsRow(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('essentialsWeekly: $essentialsWeekly, ')
          ..write('funWeekly: $funWeekly, ')
          ..write('dailySavingsTarget: $dailySavingsTarget, ')
          ..write('penaltiesEnabled: $penaltiesEnabled, ')
          ..write('currency: $currency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    deleted,
    dirty,
    essentialsWeekly,
    funWeekly,
    dailySavingsTarget,
    penaltiesEnabled,
    currency,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinanceSettingsRow &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted &&
          other.dirty == this.dirty &&
          other.essentialsWeekly == this.essentialsWeekly &&
          other.funWeekly == this.funWeekly &&
          other.dailySavingsTarget == this.dailySavingsTarget &&
          other.penaltiesEnabled == this.penaltiesEnabled &&
          other.currency == this.currency);
}

class FinanceSettingsTableCompanion
    extends UpdateCompanion<FinanceSettingsRow> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  final Value<bool> dirty;
  final Value<int> essentialsWeekly;
  final Value<int> funWeekly;
  final Value<int> dailySavingsTarget;
  final Value<bool> penaltiesEnabled;
  final Value<String> currency;
  final Value<int> rowid;
  const FinanceSettingsTableCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.essentialsWeekly = const Value.absent(),
    this.funWeekly = const Value.absent(),
    this.dailySavingsTarget = const Value.absent(),
    this.penaltiesEnabled = const Value.absent(),
    this.currency = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FinanceSettingsTableCompanion.insert({
    required String id,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required int essentialsWeekly,
    required int funWeekly,
    required int dailySavingsTarget,
    this.penaltiesEnabled = const Value.absent(),
    this.currency = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       updatedAt = Value(updatedAt),
       essentialsWeekly = Value(essentialsWeekly),
       funWeekly = Value(funWeekly),
       dailySavingsTarget = Value(dailySavingsTarget);
  static Insertable<FinanceSettingsRow> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
    Expression<bool>? dirty,
    Expression<int>? essentialsWeekly,
    Expression<int>? funWeekly,
    Expression<int>? dailySavingsTarget,
    Expression<bool>? penaltiesEnabled,
    Expression<String>? currency,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
      if (dirty != null) 'dirty': dirty,
      if (essentialsWeekly != null) 'essentials_weekly': essentialsWeekly,
      if (funWeekly != null) 'fun_weekly': funWeekly,
      if (dailySavingsTarget != null)
        'daily_savings_target': dailySavingsTarget,
      if (penaltiesEnabled != null) 'penalties_enabled': penaltiesEnabled,
      if (currency != null) 'currency': currency,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FinanceSettingsTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
    Value<bool>? dirty,
    Value<int>? essentialsWeekly,
    Value<int>? funWeekly,
    Value<int>? dailySavingsTarget,
    Value<bool>? penaltiesEnabled,
    Value<String>? currency,
    Value<int>? rowid,
  }) {
    return FinanceSettingsTableCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      dirty: dirty ?? this.dirty,
      essentialsWeekly: essentialsWeekly ?? this.essentialsWeekly,
      funWeekly: funWeekly ?? this.funWeekly,
      dailySavingsTarget: dailySavingsTarget ?? this.dailySavingsTarget,
      penaltiesEnabled: penaltiesEnabled ?? this.penaltiesEnabled,
      currency: currency ?? this.currency,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (essentialsWeekly.present) {
      map['essentials_weekly'] = Variable<int>(essentialsWeekly.value);
    }
    if (funWeekly.present) {
      map['fun_weekly'] = Variable<int>(funWeekly.value);
    }
    if (dailySavingsTarget.present) {
      map['daily_savings_target'] = Variable<int>(dailySavingsTarget.value);
    }
    if (penaltiesEnabled.present) {
      map['penalties_enabled'] = Variable<bool>(penaltiesEnabled.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinanceSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('essentialsWeekly: $essentialsWeekly, ')
          ..write('funWeekly: $funWeekly, ')
          ..write('dailySavingsTarget: $dailySavingsTarget, ')
          ..write('penaltiesEnabled: $penaltiesEnabled, ')
          ..write('currency: $currency, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses
    with TableInfo<$ExpensesTable, ExpenseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<DateTime> day = GeneratedColumn<DateTime>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    deleted,
    dirty,
    amount,
    category,
    day,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}day'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class ExpenseRow extends DataClass implements Insertable<ExpenseRow> {
  final String id;
  final DateTime updatedAt;
  final bool deleted;
  final bool dirty;
  final int amount;
  final String category;
  final DateTime day;
  final String? note;
  const ExpenseRow({
    required this.id,
    required this.updatedAt,
    required this.deleted,
    required this.dirty,
    required this.amount,
    required this.category,
    required this.day,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    map['dirty'] = Variable<bool>(dirty);
    map['amount'] = Variable<int>(amount);
    map['category'] = Variable<String>(category);
    map['day'] = Variable<DateTime>(day);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
      dirty: Value(dirty),
      amount: Value(amount),
      category: Value(category),
      day: Value(day),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory ExpenseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseRow(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      amount: serializer.fromJson<int>(json['amount']),
      category: serializer.fromJson<String>(json['category']),
      day: serializer.fromJson<DateTime>(json['day']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
      'dirty': serializer.toJson<bool>(dirty),
      'amount': serializer.toJson<int>(amount),
      'category': serializer.toJson<String>(category),
      'day': serializer.toJson<DateTime>(day),
      'note': serializer.toJson<String?>(note),
    };
  }

  ExpenseRow copyWith({
    String? id,
    DateTime? updatedAt,
    bool? deleted,
    bool? dirty,
    int? amount,
    String? category,
    DateTime? day,
    Value<String?> note = const Value.absent(),
  }) => ExpenseRow(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
    dirty: dirty ?? this.dirty,
    amount: amount ?? this.amount,
    category: category ?? this.category,
    day: day ?? this.day,
    note: note.present ? note.value : this.note,
  );
  ExpenseRow copyWithCompanion(ExpensesCompanion data) {
    return ExpenseRow(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      amount: data.amount.present ? data.amount.value : this.amount,
      category: data.category.present ? data.category.value : this.category,
      day: data.day.present ? data.day.value : this.day,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseRow(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('day: $day, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, updatedAt, deleted, dirty, amount, category, day, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseRow &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted &&
          other.dirty == this.dirty &&
          other.amount == this.amount &&
          other.category == this.category &&
          other.day == this.day &&
          other.note == this.note);
}

class ExpensesCompanion extends UpdateCompanion<ExpenseRow> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  final Value<bool> dirty;
  final Value<int> amount;
  final Value<String> category;
  final Value<DateTime> day;
  final Value<String?> note;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.amount = const Value.absent(),
    this.category = const Value.absent(),
    this.day = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    required String id,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required int amount,
    required String category,
    required DateTime day,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       updatedAt = Value(updatedAt),
       amount = Value(amount),
       category = Value(category),
       day = Value(day);
  static Insertable<ExpenseRow> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
    Expression<bool>? dirty,
    Expression<int>? amount,
    Expression<String>? category,
    Expression<DateTime>? day,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
      if (dirty != null) 'dirty': dirty,
      if (amount != null) 'amount': amount,
      if (category != null) 'category': category,
      if (day != null) 'day': day,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
    Value<bool>? dirty,
    Value<int>? amount,
    Value<String>? category,
    Value<DateTime>? day,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      dirty: dirty ?? this.dirty,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      day: day ?? this.day,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (day.present) {
      map['day'] = Variable<DateTime>(day.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('day: $day, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavingsDepositsTable extends SavingsDeposits
    with TableInfo<$SavingsDepositsTable, SavingsDepositRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavingsDepositsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<DateTime> day = GeneratedColumn<DateTime>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _visionIdMeta = const VerificationMeta(
    'visionId',
  );
  @override
  late final GeneratedColumn<String> visionId = GeneratedColumn<String>(
    'vision_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    deleted,
    dirty,
    amount,
    day,
    visionId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'savings_deposits';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavingsDepositRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('vision_id')) {
      context.handle(
        _visionIdMeta,
        visionId.isAcceptableOrUnknown(data['vision_id']!, _visionIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavingsDepositRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavingsDepositRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}day'],
      )!,
      visionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vision_id'],
      ),
    );
  }

  @override
  $SavingsDepositsTable createAlias(String alias) {
    return $SavingsDepositsTable(attachedDatabase, alias);
  }
}

class SavingsDepositRow extends DataClass
    implements Insertable<SavingsDepositRow> {
  final String id;
  final DateTime updatedAt;
  final bool deleted;
  final bool dirty;
  final int amount;
  final DateTime day;
  final String? visionId;
  const SavingsDepositRow({
    required this.id,
    required this.updatedAt,
    required this.deleted,
    required this.dirty,
    required this.amount,
    required this.day,
    this.visionId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    map['dirty'] = Variable<bool>(dirty);
    map['amount'] = Variable<int>(amount);
    map['day'] = Variable<DateTime>(day);
    if (!nullToAbsent || visionId != null) {
      map['vision_id'] = Variable<String>(visionId);
    }
    return map;
  }

  SavingsDepositsCompanion toCompanion(bool nullToAbsent) {
    return SavingsDepositsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
      dirty: Value(dirty),
      amount: Value(amount),
      day: Value(day),
      visionId: visionId == null && nullToAbsent
          ? const Value.absent()
          : Value(visionId),
    );
  }

  factory SavingsDepositRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavingsDepositRow(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      amount: serializer.fromJson<int>(json['amount']),
      day: serializer.fromJson<DateTime>(json['day']),
      visionId: serializer.fromJson<String?>(json['visionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
      'dirty': serializer.toJson<bool>(dirty),
      'amount': serializer.toJson<int>(amount),
      'day': serializer.toJson<DateTime>(day),
      'visionId': serializer.toJson<String?>(visionId),
    };
  }

  SavingsDepositRow copyWith({
    String? id,
    DateTime? updatedAt,
    bool? deleted,
    bool? dirty,
    int? amount,
    DateTime? day,
    Value<String?> visionId = const Value.absent(),
  }) => SavingsDepositRow(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
    dirty: dirty ?? this.dirty,
    amount: amount ?? this.amount,
    day: day ?? this.day,
    visionId: visionId.present ? visionId.value : this.visionId,
  );
  SavingsDepositRow copyWithCompanion(SavingsDepositsCompanion data) {
    return SavingsDepositRow(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      amount: data.amount.present ? data.amount.value : this.amount,
      day: data.day.present ? data.day.value : this.day,
      visionId: data.visionId.present ? data.visionId.value : this.visionId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavingsDepositRow(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('amount: $amount, ')
          ..write('day: $day, ')
          ..write('visionId: $visionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, updatedAt, deleted, dirty, amount, day, visionId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavingsDepositRow &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted &&
          other.dirty == this.dirty &&
          other.amount == this.amount &&
          other.day == this.day &&
          other.visionId == this.visionId);
}

class SavingsDepositsCompanion extends UpdateCompanion<SavingsDepositRow> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  final Value<bool> dirty;
  final Value<int> amount;
  final Value<DateTime> day;
  final Value<String?> visionId;
  final Value<int> rowid;
  const SavingsDepositsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.amount = const Value.absent(),
    this.day = const Value.absent(),
    this.visionId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavingsDepositsCompanion.insert({
    required String id,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required int amount,
    required DateTime day,
    this.visionId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       updatedAt = Value(updatedAt),
       amount = Value(amount),
       day = Value(day);
  static Insertable<SavingsDepositRow> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
    Expression<bool>? dirty,
    Expression<int>? amount,
    Expression<DateTime>? day,
    Expression<String>? visionId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
      if (dirty != null) 'dirty': dirty,
      if (amount != null) 'amount': amount,
      if (day != null) 'day': day,
      if (visionId != null) 'vision_id': visionId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavingsDepositsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
    Value<bool>? dirty,
    Value<int>? amount,
    Value<DateTime>? day,
    Value<String?>? visionId,
    Value<int>? rowid,
  }) {
    return SavingsDepositsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      dirty: dirty ?? this.dirty,
      amount: amount ?? this.amount,
      day: day ?? this.day,
      visionId: visionId ?? this.visionId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (day.present) {
      map['day'] = Variable<DateTime>(day.value);
    }
    if (visionId.present) {
      map['vision_id'] = Variable<String>(visionId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavingsDepositsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('amount: $amount, ')
          ..write('day: $day, ')
          ..write('visionId: $visionId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetWeeksTable extends BudgetWeeks
    with TableInfo<$BudgetWeeksTable, BudgetWeekRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetWeeksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _weekStartMeta = const VerificationMeta(
    'weekStart',
  );
  @override
  late final GeneratedColumn<DateTime> weekStart = GeneratedColumn<DateTime>(
    'week_start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _funBudgetMeta = const VerificationMeta(
    'funBudget',
  );
  @override
  late final GeneratedColumn<int> funBudget = GeneratedColumn<int>(
    'fun_budget',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    deleted,
    dirty,
    weekStart,
    funBudget,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_weeks';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetWeekRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('week_start')) {
      context.handle(
        _weekStartMeta,
        weekStart.isAcceptableOrUnknown(data['week_start']!, _weekStartMeta),
      );
    } else if (isInserting) {
      context.missing(_weekStartMeta);
    }
    if (data.containsKey('fun_budget')) {
      context.handle(
        _funBudgetMeta,
        funBudget.isAcceptableOrUnknown(data['fun_budget']!, _funBudgetMeta),
      );
    } else if (isInserting) {
      context.missing(_funBudgetMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetWeekRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetWeekRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      weekStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}week_start'],
      )!,
      funBudget: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fun_budget'],
      )!,
    );
  }

  @override
  $BudgetWeeksTable createAlias(String alias) {
    return $BudgetWeeksTable(attachedDatabase, alias);
  }
}

class BudgetWeekRow extends DataClass implements Insertable<BudgetWeekRow> {
  final String id;
  final DateTime updatedAt;
  final bool deleted;
  final bool dirty;
  final DateTime weekStart;
  final int funBudget;
  const BudgetWeekRow({
    required this.id,
    required this.updatedAt,
    required this.deleted,
    required this.dirty,
    required this.weekStart,
    required this.funBudget,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    map['dirty'] = Variable<bool>(dirty);
    map['week_start'] = Variable<DateTime>(weekStart);
    map['fun_budget'] = Variable<int>(funBudget);
    return map;
  }

  BudgetWeeksCompanion toCompanion(bool nullToAbsent) {
    return BudgetWeeksCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
      dirty: Value(dirty),
      weekStart: Value(weekStart),
      funBudget: Value(funBudget),
    );
  }

  factory BudgetWeekRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetWeekRow(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      weekStart: serializer.fromJson<DateTime>(json['weekStart']),
      funBudget: serializer.fromJson<int>(json['funBudget']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
      'dirty': serializer.toJson<bool>(dirty),
      'weekStart': serializer.toJson<DateTime>(weekStart),
      'funBudget': serializer.toJson<int>(funBudget),
    };
  }

  BudgetWeekRow copyWith({
    String? id,
    DateTime? updatedAt,
    bool? deleted,
    bool? dirty,
    DateTime? weekStart,
    int? funBudget,
  }) => BudgetWeekRow(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
    dirty: dirty ?? this.dirty,
    weekStart: weekStart ?? this.weekStart,
    funBudget: funBudget ?? this.funBudget,
  );
  BudgetWeekRow copyWithCompanion(BudgetWeeksCompanion data) {
    return BudgetWeekRow(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      weekStart: data.weekStart.present ? data.weekStart.value : this.weekStart,
      funBudget: data.funBudget.present ? data.funBudget.value : this.funBudget,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetWeekRow(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('weekStart: $weekStart, ')
          ..write('funBudget: $funBudget')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, updatedAt, deleted, dirty, weekStart, funBudget);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetWeekRow &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted &&
          other.dirty == this.dirty &&
          other.weekStart == this.weekStart &&
          other.funBudget == this.funBudget);
}

class BudgetWeeksCompanion extends UpdateCompanion<BudgetWeekRow> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  final Value<bool> dirty;
  final Value<DateTime> weekStart;
  final Value<int> funBudget;
  final Value<int> rowid;
  const BudgetWeeksCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.weekStart = const Value.absent(),
    this.funBudget = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetWeeksCompanion.insert({
    required String id,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required DateTime weekStart,
    required int funBudget,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       updatedAt = Value(updatedAt),
       weekStart = Value(weekStart),
       funBudget = Value(funBudget);
  static Insertable<BudgetWeekRow> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
    Expression<bool>? dirty,
    Expression<DateTime>? weekStart,
    Expression<int>? funBudget,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
      if (dirty != null) 'dirty': dirty,
      if (weekStart != null) 'week_start': weekStart,
      if (funBudget != null) 'fun_budget': funBudget,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetWeeksCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
    Value<bool>? dirty,
    Value<DateTime>? weekStart,
    Value<int>? funBudget,
    Value<int>? rowid,
  }) {
    return BudgetWeeksCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      dirty: dirty ?? this.dirty,
      weekStart: weekStart ?? this.weekStart,
      funBudget: funBudget ?? this.funBudget,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (weekStart.present) {
      map['week_start'] = Variable<DateTime>(weekStart.value);
    }
    if (funBudget.present) {
      map['fun_budget'] = Variable<int>(funBudget.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetWeeksCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('weekStart: $weekStart, ')
          ..write('funBudget: $funBudget, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BooksTable extends Books with TableInfo<$BooksTable, BookRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<String> format = GeneratedColumn<String>(
    'format',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalPagesMeta = const VerificationMeta(
    'totalPages',
  );
  @override
  late final GeneratedColumn<int> totalPages = GeneratedColumn<int>(
    'total_pages',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _visionIdMeta = const VerificationMeta(
    'visionId',
  );
  @override
  late final GeneratedColumn<String> visionId = GeneratedColumn<String>(
    'vision_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastOpenedAtMeta = const VerificationMeta(
    'lastOpenedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastOpenedAt = GeneratedColumn<DateTime>(
    'last_opened_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _finishedOnMeta = const VerificationMeta(
    'finishedOn',
  );
  @override
  late final GeneratedColumn<DateTime> finishedOn = GeneratedColumn<DateTime>(
    'finished_on',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    deleted,
    dirty,
    title,
    author,
    format,
    localPath,
    totalPages,
    position,
    progress,
    visionId,
    lastOpenedAt,
    finishedOn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books';
  @override
  VerificationContext validateIntegrity(
    Insertable<BookRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('format')) {
      context.handle(
        _formatMeta,
        format.isAcceptableOrUnknown(data['format']!, _formatMeta),
      );
    } else if (isInserting) {
      context.missing(_formatMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    }
    if (data.containsKey('total_pages')) {
      context.handle(
        _totalPagesMeta,
        totalPages.isAcceptableOrUnknown(data['total_pages']!, _totalPagesMeta),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('vision_id')) {
      context.handle(
        _visionIdMeta,
        visionId.isAcceptableOrUnknown(data['vision_id']!, _visionIdMeta),
      );
    }
    if (data.containsKey('last_opened_at')) {
      context.handle(
        _lastOpenedAtMeta,
        lastOpenedAt.isAcceptableOrUnknown(
          data['last_opened_at']!,
          _lastOpenedAtMeta,
        ),
      );
    }
    if (data.containsKey('finished_on')) {
      context.handle(
        _finishedOnMeta,
        finishedOn.isAcceptableOrUnknown(data['finished_on']!, _finishedOnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BookRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      format: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}format'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      ),
      totalPages: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_pages'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}progress'],
      )!,
      visionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vision_id'],
      ),
      lastOpenedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_opened_at'],
      ),
      finishedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finished_on'],
      ),
    );
  }

  @override
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }
}

class BookRow extends DataClass implements Insertable<BookRow> {
  final String id;
  final DateTime updatedAt;
  final bool deleted;
  final bool dirty;
  final String title;
  final String? author;

  /// pdf or epub.
  final String format;

  /// Path of the imported copy on this device. Files don't sync.
  final String? localPath;
  final int? totalPages;

  /// Page (PDF) or chapter index (EPUB).
  final int position;

  /// 0–1.
  final double progress;
  final String? visionId;
  final DateTime? lastOpenedAt;
  final DateTime? finishedOn;
  const BookRow({
    required this.id,
    required this.updatedAt,
    required this.deleted,
    required this.dirty,
    required this.title,
    this.author,
    required this.format,
    this.localPath,
    this.totalPages,
    required this.position,
    required this.progress,
    this.visionId,
    this.lastOpenedAt,
    this.finishedOn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    map['dirty'] = Variable<bool>(dirty);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    map['format'] = Variable<String>(format);
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    if (!nullToAbsent || totalPages != null) {
      map['total_pages'] = Variable<int>(totalPages);
    }
    map['position'] = Variable<int>(position);
    map['progress'] = Variable<double>(progress);
    if (!nullToAbsent || visionId != null) {
      map['vision_id'] = Variable<String>(visionId);
    }
    if (!nullToAbsent || lastOpenedAt != null) {
      map['last_opened_at'] = Variable<DateTime>(lastOpenedAt);
    }
    if (!nullToAbsent || finishedOn != null) {
      map['finished_on'] = Variable<DateTime>(finishedOn);
    }
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
      dirty: Value(dirty),
      title: Value(title),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      format: Value(format),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      totalPages: totalPages == null && nullToAbsent
          ? const Value.absent()
          : Value(totalPages),
      position: Value(position),
      progress: Value(progress),
      visionId: visionId == null && nullToAbsent
          ? const Value.absent()
          : Value(visionId),
      lastOpenedAt: lastOpenedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastOpenedAt),
      finishedOn: finishedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedOn),
    );
  }

  factory BookRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookRow(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String?>(json['author']),
      format: serializer.fromJson<String>(json['format']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      totalPages: serializer.fromJson<int?>(json['totalPages']),
      position: serializer.fromJson<int>(json['position']),
      progress: serializer.fromJson<double>(json['progress']),
      visionId: serializer.fromJson<String?>(json['visionId']),
      lastOpenedAt: serializer.fromJson<DateTime?>(json['lastOpenedAt']),
      finishedOn: serializer.fromJson<DateTime?>(json['finishedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
      'dirty': serializer.toJson<bool>(dirty),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String?>(author),
      'format': serializer.toJson<String>(format),
      'localPath': serializer.toJson<String?>(localPath),
      'totalPages': serializer.toJson<int?>(totalPages),
      'position': serializer.toJson<int>(position),
      'progress': serializer.toJson<double>(progress),
      'visionId': serializer.toJson<String?>(visionId),
      'lastOpenedAt': serializer.toJson<DateTime?>(lastOpenedAt),
      'finishedOn': serializer.toJson<DateTime?>(finishedOn),
    };
  }

  BookRow copyWith({
    String? id,
    DateTime? updatedAt,
    bool? deleted,
    bool? dirty,
    String? title,
    Value<String?> author = const Value.absent(),
    String? format,
    Value<String?> localPath = const Value.absent(),
    Value<int?> totalPages = const Value.absent(),
    int? position,
    double? progress,
    Value<String?> visionId = const Value.absent(),
    Value<DateTime?> lastOpenedAt = const Value.absent(),
    Value<DateTime?> finishedOn = const Value.absent(),
  }) => BookRow(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
    dirty: dirty ?? this.dirty,
    title: title ?? this.title,
    author: author.present ? author.value : this.author,
    format: format ?? this.format,
    localPath: localPath.present ? localPath.value : this.localPath,
    totalPages: totalPages.present ? totalPages.value : this.totalPages,
    position: position ?? this.position,
    progress: progress ?? this.progress,
    visionId: visionId.present ? visionId.value : this.visionId,
    lastOpenedAt: lastOpenedAt.present ? lastOpenedAt.value : this.lastOpenedAt,
    finishedOn: finishedOn.present ? finishedOn.value : this.finishedOn,
  );
  BookRow copyWithCompanion(BooksCompanion data) {
    return BookRow(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      title: data.title.present ? data.title.value : this.title,
      author: data.author.present ? data.author.value : this.author,
      format: data.format.present ? data.format.value : this.format,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      totalPages: data.totalPages.present
          ? data.totalPages.value
          : this.totalPages,
      position: data.position.present ? data.position.value : this.position,
      progress: data.progress.present ? data.progress.value : this.progress,
      visionId: data.visionId.present ? data.visionId.value : this.visionId,
      lastOpenedAt: data.lastOpenedAt.present
          ? data.lastOpenedAt.value
          : this.lastOpenedAt,
      finishedOn: data.finishedOn.present
          ? data.finishedOn.value
          : this.finishedOn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BookRow(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('format: $format, ')
          ..write('localPath: $localPath, ')
          ..write('totalPages: $totalPages, ')
          ..write('position: $position, ')
          ..write('progress: $progress, ')
          ..write('visionId: $visionId, ')
          ..write('lastOpenedAt: $lastOpenedAt, ')
          ..write('finishedOn: $finishedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    deleted,
    dirty,
    title,
    author,
    format,
    localPath,
    totalPages,
    position,
    progress,
    visionId,
    lastOpenedAt,
    finishedOn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookRow &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted &&
          other.dirty == this.dirty &&
          other.title == this.title &&
          other.author == this.author &&
          other.format == this.format &&
          other.localPath == this.localPath &&
          other.totalPages == this.totalPages &&
          other.position == this.position &&
          other.progress == this.progress &&
          other.visionId == this.visionId &&
          other.lastOpenedAt == this.lastOpenedAt &&
          other.finishedOn == this.finishedOn);
}

class BooksCompanion extends UpdateCompanion<BookRow> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  final Value<bool> dirty;
  final Value<String> title;
  final Value<String?> author;
  final Value<String> format;
  final Value<String?> localPath;
  final Value<int?> totalPages;
  final Value<int> position;
  final Value<double> progress;
  final Value<String?> visionId;
  final Value<DateTime?> lastOpenedAt;
  final Value<DateTime?> finishedOn;
  final Value<int> rowid;
  const BooksCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.format = const Value.absent(),
    this.localPath = const Value.absent(),
    this.totalPages = const Value.absent(),
    this.position = const Value.absent(),
    this.progress = const Value.absent(),
    this.visionId = const Value.absent(),
    this.lastOpenedAt = const Value.absent(),
    this.finishedOn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BooksCompanion.insert({
    required String id,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String title,
    this.author = const Value.absent(),
    required String format,
    this.localPath = const Value.absent(),
    this.totalPages = const Value.absent(),
    this.position = const Value.absent(),
    this.progress = const Value.absent(),
    this.visionId = const Value.absent(),
    this.lastOpenedAt = const Value.absent(),
    this.finishedOn = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       updatedAt = Value(updatedAt),
       title = Value(title),
       format = Value(format);
  static Insertable<BookRow> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
    Expression<bool>? dirty,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? format,
    Expression<String>? localPath,
    Expression<int>? totalPages,
    Expression<int>? position,
    Expression<double>? progress,
    Expression<String>? visionId,
    Expression<DateTime>? lastOpenedAt,
    Expression<DateTime>? finishedOn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
      if (dirty != null) 'dirty': dirty,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (format != null) 'format': format,
      if (localPath != null) 'local_path': localPath,
      if (totalPages != null) 'total_pages': totalPages,
      if (position != null) 'position': position,
      if (progress != null) 'progress': progress,
      if (visionId != null) 'vision_id': visionId,
      if (lastOpenedAt != null) 'last_opened_at': lastOpenedAt,
      if (finishedOn != null) 'finished_on': finishedOn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BooksCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
    Value<bool>? dirty,
    Value<String>? title,
    Value<String?>? author,
    Value<String>? format,
    Value<String?>? localPath,
    Value<int?>? totalPages,
    Value<int>? position,
    Value<double>? progress,
    Value<String?>? visionId,
    Value<DateTime?>? lastOpenedAt,
    Value<DateTime?>? finishedOn,
    Value<int>? rowid,
  }) {
    return BooksCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      dirty: dirty ?? this.dirty,
      title: title ?? this.title,
      author: author ?? this.author,
      format: format ?? this.format,
      localPath: localPath ?? this.localPath,
      totalPages: totalPages ?? this.totalPages,
      position: position ?? this.position,
      progress: progress ?? this.progress,
      visionId: visionId ?? this.visionId,
      lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
      finishedOn: finishedOn ?? this.finishedOn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (totalPages.present) {
      map['total_pages'] = Variable<int>(totalPages.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (visionId.present) {
      map['vision_id'] = Variable<String>(visionId.value);
    }
    if (lastOpenedAt.present) {
      map['last_opened_at'] = Variable<DateTime>(lastOpenedAt.value);
    }
    if (finishedOn.present) {
      map['finished_on'] = Variable<DateTime>(finishedOn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('format: $format, ')
          ..write('localPath: $localPath, ')
          ..write('totalPages: $totalPages, ')
          ..write('position: $position, ')
          ..write('progress: $progress, ')
          ..write('visionId: $visionId, ')
          ..write('lastOpenedAt: $lastOpenedAt, ')
          ..write('finishedOn: $finishedOn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnnotationsTable extends Annotations
    with TableInfo<$AnnotationsTable, AnnotationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnnotationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quoteMeta = const VerificationMeta('quote');
  @override
  late final GeneratedColumn<String> quote = GeneratedColumn<String>(
    'quote',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    deleted,
    dirty,
    bookId,
    kind,
    position,
    quote,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'annotations';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnnotationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('quote')) {
      context.handle(
        _quoteMeta,
        quote.isAcceptableOrUnknown(data['quote']!, _quoteMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnnotationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnnotationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      quote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $AnnotationsTable createAlias(String alias) {
    return $AnnotationsTable(attachedDatabase, alias);
  }
}

class AnnotationRow extends DataClass implements Insertable<AnnotationRow> {
  final String id;
  final DateTime updatedAt;
  final bool deleted;
  final bool dirty;
  final String bookId;

  /// bookmark, highlight or note.
  final String kind;
  final int position;
  final String? quote;
  final String? note;
  const AnnotationRow({
    required this.id,
    required this.updatedAt,
    required this.deleted,
    required this.dirty,
    required this.bookId,
    required this.kind,
    required this.position,
    this.quote,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    map['dirty'] = Variable<bool>(dirty);
    map['book_id'] = Variable<String>(bookId);
    map['kind'] = Variable<String>(kind);
    map['position'] = Variable<int>(position);
    if (!nullToAbsent || quote != null) {
      map['quote'] = Variable<String>(quote);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  AnnotationsCompanion toCompanion(bool nullToAbsent) {
    return AnnotationsCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
      dirty: Value(dirty),
      bookId: Value(bookId),
      kind: Value(kind),
      position: Value(position),
      quote: quote == null && nullToAbsent
          ? const Value.absent()
          : Value(quote),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory AnnotationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnnotationRow(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      bookId: serializer.fromJson<String>(json['bookId']),
      kind: serializer.fromJson<String>(json['kind']),
      position: serializer.fromJson<int>(json['position']),
      quote: serializer.fromJson<String?>(json['quote']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
      'dirty': serializer.toJson<bool>(dirty),
      'bookId': serializer.toJson<String>(bookId),
      'kind': serializer.toJson<String>(kind),
      'position': serializer.toJson<int>(position),
      'quote': serializer.toJson<String?>(quote),
      'note': serializer.toJson<String?>(note),
    };
  }

  AnnotationRow copyWith({
    String? id,
    DateTime? updatedAt,
    bool? deleted,
    bool? dirty,
    String? bookId,
    String? kind,
    int? position,
    Value<String?> quote = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => AnnotationRow(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
    dirty: dirty ?? this.dirty,
    bookId: bookId ?? this.bookId,
    kind: kind ?? this.kind,
    position: position ?? this.position,
    quote: quote.present ? quote.value : this.quote,
    note: note.present ? note.value : this.note,
  );
  AnnotationRow copyWithCompanion(AnnotationsCompanion data) {
    return AnnotationRow(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      kind: data.kind.present ? data.kind.value : this.kind,
      position: data.position.present ? data.position.value : this.position,
      quote: data.quote.present ? data.quote.value : this.quote,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnnotationRow(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('bookId: $bookId, ')
          ..write('kind: $kind, ')
          ..write('position: $position, ')
          ..write('quote: $quote, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    updatedAt,
    deleted,
    dirty,
    bookId,
    kind,
    position,
    quote,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnnotationRow &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted &&
          other.dirty == this.dirty &&
          other.bookId == this.bookId &&
          other.kind == this.kind &&
          other.position == this.position &&
          other.quote == this.quote &&
          other.note == this.note);
}

class AnnotationsCompanion extends UpdateCompanion<AnnotationRow> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  final Value<bool> dirty;
  final Value<String> bookId;
  final Value<String> kind;
  final Value<int> position;
  final Value<String?> quote;
  final Value<String?> note;
  final Value<int> rowid;
  const AnnotationsCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.bookId = const Value.absent(),
    this.kind = const Value.absent(),
    this.position = const Value.absent(),
    this.quote = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnnotationsCompanion.insert({
    required String id,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String bookId,
    required String kind,
    required int position,
    this.quote = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       updatedAt = Value(updatedAt),
       bookId = Value(bookId),
       kind = Value(kind),
       position = Value(position);
  static Insertable<AnnotationRow> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
    Expression<bool>? dirty,
    Expression<String>? bookId,
    Expression<String>? kind,
    Expression<int>? position,
    Expression<String>? quote,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
      if (dirty != null) 'dirty': dirty,
      if (bookId != null) 'book_id': bookId,
      if (kind != null) 'kind': kind,
      if (position != null) 'position': position,
      if (quote != null) 'quote': quote,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnnotationsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
    Value<bool>? dirty,
    Value<String>? bookId,
    Value<String>? kind,
    Value<int>? position,
    Value<String?>? quote,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return AnnotationsCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      dirty: dirty ?? this.dirty,
      bookId: bookId ?? this.bookId,
      kind: kind ?? this.kind,
      position: position ?? this.position,
      quote: quote ?? this.quote,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (quote.present) {
      map['quote'] = Variable<String>(quote.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnnotationsCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('bookId: $bookId, ')
          ..write('kind: $kind, ')
          ..write('position: $position, ')
          ..write('quote: $quote, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CouncilMessagesTable extends CouncilMessages
    with TableInfo<$CouncilMessagesTable, CouncilMessageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CouncilMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _threadMeta = const VerificationMeta('thread');
  @override
  late final GeneratedColumn<String> thread = GeneratedColumn<String>(
    'thread',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    updatedAt,
    deleted,
    dirty,
    thread,
    author,
    body,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'council_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<CouncilMessageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('thread')) {
      context.handle(
        _threadMeta,
        thread.isAcceptableOrUnknown(data['thread']!, _threadMeta),
      );
    } else if (isInserting) {
      context.missing(_threadMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CouncilMessageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CouncilMessageRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      thread: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thread'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
    );
  }

  @override
  $CouncilMessagesTable createAlias(String alias) {
    return $CouncilMessagesTable(attachedDatabase, alias);
  }
}

class CouncilMessageRow extends DataClass
    implements Insertable<CouncilMessageRow> {
  final String id;
  final DateTime updatedAt;
  final bool deleted;
  final bool dirty;

  /// Conversation: an advisor id, or `chamber`.
  final String thread;

  /// user or an advisor id.
  final String author;
  final String body;
  const CouncilMessageRow({
    required this.id,
    required this.updatedAt,
    required this.deleted,
    required this.dirty,
    required this.thread,
    required this.author,
    required this.body,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    map['dirty'] = Variable<bool>(dirty);
    map['thread'] = Variable<String>(thread);
    map['author'] = Variable<String>(author);
    map['body'] = Variable<String>(body);
    return map;
  }

  CouncilMessagesCompanion toCompanion(bool nullToAbsent) {
    return CouncilMessagesCompanion(
      id: Value(id),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
      dirty: Value(dirty),
      thread: Value(thread),
      author: Value(author),
      body: Value(body),
    );
  }

  factory CouncilMessageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CouncilMessageRow(
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      thread: serializer.fromJson<String>(json['thread']),
      author: serializer.fromJson<String>(json['author']),
      body: serializer.fromJson<String>(json['body']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
      'dirty': serializer.toJson<bool>(dirty),
      'thread': serializer.toJson<String>(thread),
      'author': serializer.toJson<String>(author),
      'body': serializer.toJson<String>(body),
    };
  }

  CouncilMessageRow copyWith({
    String? id,
    DateTime? updatedAt,
    bool? deleted,
    bool? dirty,
    String? thread,
    String? author,
    String? body,
  }) => CouncilMessageRow(
    id: id ?? this.id,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
    dirty: dirty ?? this.dirty,
    thread: thread ?? this.thread,
    author: author ?? this.author,
    body: body ?? this.body,
  );
  CouncilMessageRow copyWithCompanion(CouncilMessagesCompanion data) {
    return CouncilMessageRow(
      id: data.id.present ? data.id.value : this.id,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      thread: data.thread.present ? data.thread.value : this.thread,
      author: data.author.present ? data.author.value : this.author,
      body: data.body.present ? data.body.value : this.body,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CouncilMessageRow(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('thread: $thread, ')
          ..write('author: $author, ')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, updatedAt, deleted, dirty, thread, author, body);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CouncilMessageRow &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted &&
          other.dirty == this.dirty &&
          other.thread == this.thread &&
          other.author == this.author &&
          other.body == this.body);
}

class CouncilMessagesCompanion extends UpdateCompanion<CouncilMessageRow> {
  final Value<String> id;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  final Value<bool> dirty;
  final Value<String> thread;
  final Value<String> author;
  final Value<String> body;
  final Value<int> rowid;
  const CouncilMessagesCompanion({
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    this.thread = const Value.absent(),
    this.author = const Value.absent(),
    this.body = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CouncilMessagesCompanion.insert({
    required String id,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
    this.dirty = const Value.absent(),
    required String thread,
    required String author,
    required String body,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       updatedAt = Value(updatedAt),
       thread = Value(thread),
       author = Value(author),
       body = Value(body);
  static Insertable<CouncilMessageRow> custom({
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
    Expression<bool>? dirty,
    Expression<String>? thread,
    Expression<String>? author,
    Expression<String>? body,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
      if (dirty != null) 'dirty': dirty,
      if (thread != null) 'thread': thread,
      if (author != null) 'author': author,
      if (body != null) 'body': body,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CouncilMessagesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
    Value<bool>? dirty,
    Value<String>? thread,
    Value<String>? author,
    Value<String>? body,
    Value<int>? rowid,
  }) {
    return CouncilMessagesCompanion(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      dirty: dirty ?? this.dirty,
      thread: thread ?? this.thread,
      author: author ?? this.author,
      body: body ?? this.body,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (thread.present) {
      map['thread'] = Variable<String>(thread.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CouncilMessagesCompanion(')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted, ')
          ..write('dirty: $dirty, ')
          ..write('thread: $thread, ')
          ..write('author: $author, ')
          ..write('body: $body, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppMetaTable extends AppMeta with TableInfo<$AppMetaTable, AppMetaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppMetaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppMetaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppMetaRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppMetaTable createAlias(String alias) {
    return $AppMetaTable(attachedDatabase, alias);
  }
}

class AppMetaRow extends DataClass implements Insertable<AppMetaRow> {
  final String key;
  final String value;
  const AppMetaRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppMetaCompanion toCompanion(bool nullToAbsent) {
    return AppMetaCompanion(key: Value(key), value: Value(value));
  }

  factory AppMetaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppMetaRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppMetaRow copyWith({String? key, String? value}) =>
      AppMetaRow(key: key ?? this.key, value: value ?? this.value);
  AppMetaRow copyWithCompanion(AppMetaCompanion data) {
    return AppMetaRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppMetaRow &&
          other.key == this.key &&
          other.value == this.value);
}

class AppMetaCompanion extends UpdateCompanion<AppMetaRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppMetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppMetaCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppMetaRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppMetaCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppMetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $CompletionsTable completions = $CompletionsTable(this);
  late final $ExcusesTable excuses = $ExcusesTable(this);
  late final $RewardsTable rewards = $RewardsTable(this);
  late final $RecoveriesTable recoveries = $RecoveriesTable(this);
  late final $VisionsTable visions = $VisionsTable(this);
  late final $MilestonesTable milestones = $MilestonesTable(this);
  late final $FinanceSettingsTableTable financeSettingsTable =
      $FinanceSettingsTableTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $SavingsDepositsTable savingsDeposits = $SavingsDepositsTable(
    this,
  );
  late final $BudgetWeeksTable budgetWeeks = $BudgetWeeksTable(this);
  late final $BooksTable books = $BooksTable(this);
  late final $AnnotationsTable annotations = $AnnotationsTable(this);
  late final $CouncilMessagesTable councilMessages = $CouncilMessagesTable(
    this,
  );
  late final $AppMetaTable appMeta = $AppMetaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profiles,
    habits,
    completions,
    excuses,
    rewards,
    recoveries,
    visions,
    milestones,
    financeSettingsTable,
    expenses,
    savingsDeposits,
    budgetWeeks,
    books,
    annotations,
    councilMessages,
    appMeta,
  ];
}

typedef $$ProfilesTableCreateCompanionBuilder = ProfilesCompanion Function({
  required String id,
  required DateTime updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  Value<String> displayName,
  Value<String> accountability,
  Value<String> areas,
  Value<String> advisor,
  Value<int> strictness,
  Value<bool> onboarded,
  Value<int> rowid,
});
typedef $$ProfilesTableUpdateCompanionBuilder = ProfilesCompanion Function({
  Value<String> id,
  Value<DateTime> updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  Value<String> displayName,
  Value<String> accountability,
  Value<String> areas,
  Value<String> advisor,
  Value<int> strictness,
  Value<bool> onboarded,
  Value<int> rowid,
});

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountability => $composableBuilder(
    column: $table.accountability,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get areas => $composableBuilder(
    column: $table.areas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get advisor => $composableBuilder(
    column: $table.advisor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get strictness => $composableBuilder(
    column: $table.strictness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboarded => $composableBuilder(
    column: $table.onboarded,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountability => $composableBuilder(
    column: $table.accountability,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get areas => $composableBuilder(
    column: $table.areas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get advisor => $composableBuilder(
    column: $table.advisor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get strictness => $composableBuilder(
    column: $table.strictness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboarded => $composableBuilder(
    column: $table.onboarded,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountability => $composableBuilder(
    column: $table.accountability,
    builder: (column) => column,
  );

  GeneratedColumn<String> get areas =>
      $composableBuilder(column: $table.areas, builder: (column) => column);

  GeneratedColumn<String> get advisor =>
      $composableBuilder(column: $table.advisor, builder: (column) => column);

  GeneratedColumn<int> get strictness => $composableBuilder(
    column: $table.strictness,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboarded =>
      $composableBuilder(column: $table.onboarded, builder: (column) => column);
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfilesTable,
          ProfileRow,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (
            ProfileRow,
            BaseReferences<_$AppDatabase, $ProfilesTable, ProfileRow>,
          ),
          ProfileRow,
          PrefetchHooks Function()
        > {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> accountability = const Value.absent(),
                Value<String> areas = const Value.absent(),
                Value<String> advisor = const Value.absent(),
                Value<int> strictness = const Value.absent(),
                Value<bool> onboarded = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                displayName: displayName,
                accountability: accountability,
                areas: areas,
                advisor: advisor,
                strictness: strictness,
                onboarded: onboarded,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> accountability = const Value.absent(),
                Value<String> areas = const Value.absent(),
                Value<String> advisor = const Value.absent(),
                Value<int> strictness = const Value.absent(),
                Value<bool> onboarded = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                displayName: displayName,
                accountability: accountability,
                areas: areas,
                advisor: advisor,
                strictness: strictness,
                onboarded: onboarded,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfilesTable, ProfileRow>(table),
                  BaseReferences<_$AppDatabase, $ProfilesTable, ProfileRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfilesTable,
      ProfileRow,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (ProfileRow, BaseReferences<_$AppDatabase, $ProfilesTable, ProfileRow>),
      ProfileRow,
      PrefetchHooks Function()
    >;
typedef $$HabitsTableCreateCompanionBuilder = HabitsCompanion Function({
  required String id,
  required DateTime updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  required String name,
  required int baseXp,
  required String weekdays,
  required DateTime createdOn,
  Value<String?> area,
  Value<String?> visionId,
  Value<int?> target,
  Value<String?> unit,
  Value<int?> previousTarget,
  Value<int?> previousBaseXp,
  Value<DateTime?> evolvedOn,
  Value<DateTime?> evolveDeclinedOn,
  Value<DateTime?> archivedOn,
  Value<int> rowid,
});
typedef $$HabitsTableUpdateCompanionBuilder = HabitsCompanion Function({
  Value<String> id,
  Value<DateTime> updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  Value<String> name,
  Value<int> baseXp,
  Value<String> weekdays,
  Value<DateTime> createdOn,
  Value<String?> area,
  Value<String?> visionId,
  Value<int?> target,
  Value<String?> unit,
  Value<int?> previousTarget,
  Value<int?> previousBaseXp,
  Value<DateTime?> evolvedOn,
  Value<DateTime?> evolveDeclinedOn,
  Value<DateTime?> archivedOn,
  Value<int> rowid,
});

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseXp => $composableBuilder(
    column: $table.baseXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weekdays => $composableBuilder(
    column: $table.weekdays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdOn => $composableBuilder(
    column: $table.createdOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get visionId => $composableBuilder(
    column: $table.visionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get previousTarget => $composableBuilder(
    column: $table.previousTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get previousBaseXp => $composableBuilder(
    column: $table.previousBaseXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get evolvedOn => $composableBuilder(
    column: $table.evolvedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get evolveDeclinedOn => $composableBuilder(
    column: $table.evolveDeclinedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedOn => $composableBuilder(
    column: $table.archivedOn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseXp => $composableBuilder(
    column: $table.baseXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weekdays => $composableBuilder(
    column: $table.weekdays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdOn => $composableBuilder(
    column: $table.createdOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visionId => $composableBuilder(
    column: $table.visionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get previousTarget => $composableBuilder(
    column: $table.previousTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get previousBaseXp => $composableBuilder(
    column: $table.previousBaseXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get evolvedOn => $composableBuilder(
    column: $table.evolvedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get evolveDeclinedOn => $composableBuilder(
    column: $table.evolveDeclinedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedOn => $composableBuilder(
    column: $table.archivedOn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get baseXp =>
      $composableBuilder(column: $table.baseXp, builder: (column) => column);

  GeneratedColumn<String> get weekdays =>
      $composableBuilder(column: $table.weekdays, builder: (column) => column);

  GeneratedColumn<DateTime> get createdOn =>
      $composableBuilder(column: $table.createdOn, builder: (column) => column);

  GeneratedColumn<String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<String> get visionId =>
      $composableBuilder(column: $table.visionId, builder: (column) => column);

  GeneratedColumn<int> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get previousTarget => $composableBuilder(
    column: $table.previousTarget,
    builder: (column) => column,
  );

  GeneratedColumn<int> get previousBaseXp => $composableBuilder(
    column: $table.previousBaseXp,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get evolvedOn =>
      $composableBuilder(column: $table.evolvedOn, builder: (column) => column);

  GeneratedColumn<DateTime> get evolveDeclinedOn => $composableBuilder(
    column: $table.evolveDeclinedOn,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get archivedOn => $composableBuilder(
    column: $table.archivedOn,
    builder: (column) => column,
  );
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          HabitRow,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (HabitRow, BaseReferences<_$AppDatabase, $HabitsTable, HabitRow>),
          HabitRow,
          PrefetchHooks Function()
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> baseXp = const Value.absent(),
                Value<String> weekdays = const Value.absent(),
                Value<DateTime> createdOn = const Value.absent(),
                Value<String?> area = const Value.absent(),
                Value<String?> visionId = const Value.absent(),
                Value<int?> target = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<int?> previousTarget = const Value.absent(),
                Value<int?> previousBaseXp = const Value.absent(),
                Value<DateTime?> evolvedOn = const Value.absent(),
                Value<DateTime?> evolveDeclinedOn = const Value.absent(),
                Value<DateTime?> archivedOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                name: name,
                baseXp: baseXp,
                weekdays: weekdays,
                createdOn: createdOn,
                area: area,
                visionId: visionId,
                target: target,
                unit: unit,
                previousTarget: previousTarget,
                previousBaseXp: previousBaseXp,
                evolvedOn: evolvedOn,
                evolveDeclinedOn: evolveDeclinedOn,
                archivedOn: archivedOn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String name,
                required int baseXp,
                required String weekdays,
                required DateTime createdOn,
                Value<String?> area = const Value.absent(),
                Value<String?> visionId = const Value.absent(),
                Value<int?> target = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<int?> previousTarget = const Value.absent(),
                Value<int?> previousBaseXp = const Value.absent(),
                Value<DateTime?> evolvedOn = const Value.absent(),
                Value<DateTime?> evolveDeclinedOn = const Value.absent(),
                Value<DateTime?> archivedOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                name: name,
                baseXp: baseXp,
                weekdays: weekdays,
                createdOn: createdOn,
                area: area,
                visionId: visionId,
                target: target,
                unit: unit,
                previousTarget: previousTarget,
                previousBaseXp: previousBaseXp,
                evolvedOn: evolvedOn,
                evolveDeclinedOn: evolveDeclinedOn,
                archivedOn: archivedOn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HabitsTable, HabitRow>(table),
                  BaseReferences<_$AppDatabase, $HabitsTable, HabitRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      HabitRow,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (HabitRow, BaseReferences<_$AppDatabase, $HabitsTable, HabitRow>),
      HabitRow,
      PrefetchHooks Function()
    >;
typedef $$CompletionsTableCreateCompanionBuilder =
    CompletionsCompanion Function({
      required String id,
      required DateTime updatedAt,
      Value<bool> deleted,
      Value<bool> dirty,
      required String habitId,
      required DateTime day,
      Value<int> rowid,
    });
typedef $$CompletionsTableUpdateCompanionBuilder =
    CompletionsCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> deleted,
      Value<bool> dirty,
      Value<String> habitId,
      Value<DateTime> day,
      Value<int> rowid,
    });

class $$CompletionsTableFilterComposer
    extends Composer<_$AppDatabase, $CompletionsTable> {
  $$CompletionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CompletionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CompletionsTable> {
  $$CompletionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompletionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompletionsTable> {
  $$CompletionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<DateTime> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);
}

class $$CompletionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompletionsTable,
          CompletionRow,
          $$CompletionsTableFilterComposer,
          $$CompletionsTableOrderingComposer,
          $$CompletionsTableAnnotationComposer,
          $$CompletionsTableCreateCompanionBuilder,
          $$CompletionsTableUpdateCompanionBuilder,
          (
            CompletionRow,
            BaseReferences<_$AppDatabase, $CompletionsTable, CompletionRow>,
          ),
          CompletionRow,
          PrefetchHooks Function()
        > {
  $$CompletionsTableTableManager(_$AppDatabase db, $CompletionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompletionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompletionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompletionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<DateTime> day = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompletionsCompanion(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                habitId: habitId,
                day: day,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String habitId,
                required DateTime day,
                Value<int> rowid = const Value.absent(),
              }) => CompletionsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                habitId: habitId,
                day: day,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CompletionsTable, CompletionRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CompletionsTable,
                    CompletionRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CompletionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompletionsTable,
      CompletionRow,
      $$CompletionsTableFilterComposer,
      $$CompletionsTableOrderingComposer,
      $$CompletionsTableAnnotationComposer,
      $$CompletionsTableCreateCompanionBuilder,
      $$CompletionsTableUpdateCompanionBuilder,
      (
        CompletionRow,
        BaseReferences<_$AppDatabase, $CompletionsTable, CompletionRow>,
      ),
      CompletionRow,
      PrefetchHooks Function()
    >;
typedef $$ExcusesTableCreateCompanionBuilder = ExcusesCompanion Function({
  required String id,
  required DateTime updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  required DateTime day,
  required String reason,
  Value<String?> note,
  Value<int> rowid,
});
typedef $$ExcusesTableUpdateCompanionBuilder = ExcusesCompanion Function({
  Value<String> id,
  Value<DateTime> updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  Value<DateTime> day,
  Value<String> reason,
  Value<String?> note,
  Value<int> rowid,
});

class $$ExcusesTableFilterComposer
    extends Composer<_$AppDatabase, $ExcusesTable> {
  $$ExcusesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExcusesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExcusesTable> {
  $$ExcusesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExcusesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExcusesTable> {
  $$ExcusesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<DateTime> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$ExcusesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExcusesTable,
          ExcuseRow,
          $$ExcusesTableFilterComposer,
          $$ExcusesTableOrderingComposer,
          $$ExcusesTableAnnotationComposer,
          $$ExcusesTableCreateCompanionBuilder,
          $$ExcusesTableUpdateCompanionBuilder,
          (ExcuseRow, BaseReferences<_$AppDatabase, $ExcusesTable, ExcuseRow>),
          ExcuseRow,
          PrefetchHooks Function()
        > {
  $$ExcusesTableTableManager(_$AppDatabase db, $ExcusesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExcusesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExcusesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExcusesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<DateTime> day = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExcusesCompanion(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                day: day,
                reason: reason,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required DateTime day,
                required String reason,
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExcusesCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                day: day,
                reason: reason,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExcusesTable, ExcuseRow>(table),
                  BaseReferences<_$AppDatabase, $ExcusesTable, ExcuseRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExcusesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExcusesTable,
      ExcuseRow,
      $$ExcusesTableFilterComposer,
      $$ExcusesTableOrderingComposer,
      $$ExcusesTableAnnotationComposer,
      $$ExcusesTableCreateCompanionBuilder,
      $$ExcusesTableUpdateCompanionBuilder,
      (ExcuseRow, BaseReferences<_$AppDatabase, $ExcusesTable, ExcuseRow>),
      ExcuseRow,
      PrefetchHooks Function()
    >;
typedef $$RewardsTableCreateCompanionBuilder = RewardsCompanion Function({
  required String id,
  required DateTime updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  required String currency,
  required String kind,
  required int amount,
  required DateTime day,
  required String explanation,
  Value<String?> refId,
  Value<int> rowid,
});
typedef $$RewardsTableUpdateCompanionBuilder = RewardsCompanion Function({
  Value<String> id,
  Value<DateTime> updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  Value<String> currency,
  Value<String> kind,
  Value<int> amount,
  Value<DateTime> day,
  Value<String> explanation,
  Value<String?> refId,
  Value<int> rowid,
});

class $$RewardsTableFilterComposer
    extends Composer<_$AppDatabase, $RewardsTable> {
  $$RewardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refId => $composableBuilder(
    column: $table.refId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RewardsTableOrderingComposer
    extends Composer<_$AppDatabase, $RewardsTable> {
  $$RewardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refId => $composableBuilder(
    column: $table.refId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RewardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RewardsTable> {
  $$RewardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get refId =>
      $composableBuilder(column: $table.refId, builder: (column) => column);
}

class $$RewardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RewardsTable,
          RewardRow,
          $$RewardsTableFilterComposer,
          $$RewardsTableOrderingComposer,
          $$RewardsTableAnnotationComposer,
          $$RewardsTableCreateCompanionBuilder,
          $$RewardsTableUpdateCompanionBuilder,
          (RewardRow, BaseReferences<_$AppDatabase, $RewardsTable, RewardRow>),
          RewardRow,
          PrefetchHooks Function()
        > {
  $$RewardsTableTableManager(_$AppDatabase db, $RewardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RewardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RewardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RewardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<DateTime> day = const Value.absent(),
                Value<String> explanation = const Value.absent(),
                Value<String?> refId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RewardsCompanion(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                currency: currency,
                kind: kind,
                amount: amount,
                day: day,
                explanation: explanation,
                refId: refId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String currency,
                required String kind,
                required int amount,
                required DateTime day,
                required String explanation,
                Value<String?> refId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RewardsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                currency: currency,
                kind: kind,
                amount: amount,
                day: day,
                explanation: explanation,
                refId: refId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RewardsTable, RewardRow>(table),
                  BaseReferences<_$AppDatabase, $RewardsTable, RewardRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RewardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RewardsTable,
      RewardRow,
      $$RewardsTableFilterComposer,
      $$RewardsTableOrderingComposer,
      $$RewardsTableAnnotationComposer,
      $$RewardsTableCreateCompanionBuilder,
      $$RewardsTableUpdateCompanionBuilder,
      (RewardRow, BaseReferences<_$AppDatabase, $RewardsTable, RewardRow>),
      RewardRow,
      PrefetchHooks Function()
    >;
typedef $$RecoveriesTableCreateCompanionBuilder = RecoveriesCompanion Function({
  required String id,
  required DateTime updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  required String habitId,
  required DateTime startedOn,
  Value<DateTime?> completedOn,
  Value<String> forgiven,
  Value<int> rowid,
});
typedef $$RecoveriesTableUpdateCompanionBuilder = RecoveriesCompanion Function({
  Value<String> id,
  Value<DateTime> updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  Value<String> habitId,
  Value<DateTime> startedOn,
  Value<DateTime?> completedOn,
  Value<String> forgiven,
  Value<int> rowid,
});

class $$RecoveriesTableFilterComposer
    extends Composer<_$AppDatabase, $RecoveriesTable> {
  $$RecoveriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedOn => $composableBuilder(
    column: $table.startedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedOn => $composableBuilder(
    column: $table.completedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get forgiven => $composableBuilder(
    column: $table.forgiven,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecoveriesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecoveriesTable> {
  $$RecoveriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedOn => $composableBuilder(
    column: $table.startedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedOn => $composableBuilder(
    column: $table.completedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get forgiven => $composableBuilder(
    column: $table.forgiven,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecoveriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecoveriesTable> {
  $$RecoveriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<DateTime> get startedOn =>
      $composableBuilder(column: $table.startedOn, builder: (column) => column);

  GeneratedColumn<DateTime> get completedOn => $composableBuilder(
    column: $table.completedOn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get forgiven =>
      $composableBuilder(column: $table.forgiven, builder: (column) => column);
}

class $$RecoveriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecoveriesTable,
          RecoveryRow,
          $$RecoveriesTableFilterComposer,
          $$RecoveriesTableOrderingComposer,
          $$RecoveriesTableAnnotationComposer,
          $$RecoveriesTableCreateCompanionBuilder,
          $$RecoveriesTableUpdateCompanionBuilder,
          (
            RecoveryRow,
            BaseReferences<_$AppDatabase, $RecoveriesTable, RecoveryRow>,
          ),
          RecoveryRow,
          PrefetchHooks Function()
        > {
  $$RecoveriesTableTableManager(_$AppDatabase db, $RecoveriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecoveriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecoveriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecoveriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<DateTime> startedOn = const Value.absent(),
                Value<DateTime?> completedOn = const Value.absent(),
                Value<String> forgiven = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecoveriesCompanion(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                habitId: habitId,
                startedOn: startedOn,
                completedOn: completedOn,
                forgiven: forgiven,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String habitId,
                required DateTime startedOn,
                Value<DateTime?> completedOn = const Value.absent(),
                Value<String> forgiven = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecoveriesCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                habitId: habitId,
                startedOn: startedOn,
                completedOn: completedOn,
                forgiven: forgiven,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecoveriesTable, RecoveryRow>(table),
                  BaseReferences<_$AppDatabase, $RecoveriesTable, RecoveryRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecoveriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecoveriesTable,
      RecoveryRow,
      $$RecoveriesTableFilterComposer,
      $$RecoveriesTableOrderingComposer,
      $$RecoveriesTableAnnotationComposer,
      $$RecoveriesTableCreateCompanionBuilder,
      $$RecoveriesTableUpdateCompanionBuilder,
      (
        RecoveryRow,
        BaseReferences<_$AppDatabase, $RecoveriesTable, RecoveryRow>,
      ),
      RecoveryRow,
      PrefetchHooks Function()
    >;
typedef $$VisionsTableCreateCompanionBuilder = VisionsCompanion Function({
  required String id,
  required DateTime updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  required String title,
  Value<String?> why,
  required String category,
  Value<double?> targetValue,
  Value<String?> unit,
  Value<double> currentValue,
  required DateTime startedOn,
  required DateTime deadline,
  Value<double?> ambition,
  Value<DateTime?> completedOn,
  Value<int> rowid,
});
typedef $$VisionsTableUpdateCompanionBuilder = VisionsCompanion Function({
  Value<String> id,
  Value<DateTime> updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  Value<String> title,
  Value<String?> why,
  Value<String> category,
  Value<double?> targetValue,
  Value<String?> unit,
  Value<double> currentValue,
  Value<DateTime> startedOn,
  Value<DateTime> deadline,
  Value<double?> ambition,
  Value<DateTime?> completedOn,
  Value<int> rowid,
});

class $$VisionsTableFilterComposer
    extends Composer<_$AppDatabase, $VisionsTable> {
  $$VisionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get why => $composableBuilder(
    column: $table.why,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentValue => $composableBuilder(
    column: $table.currentValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedOn => $composableBuilder(
    column: $table.startedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ambition => $composableBuilder(
    column: $table.ambition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedOn => $composableBuilder(
    column: $table.completedOn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VisionsTableOrderingComposer
    extends Composer<_$AppDatabase, $VisionsTable> {
  $$VisionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get why => $composableBuilder(
    column: $table.why,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentValue => $composableBuilder(
    column: $table.currentValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedOn => $composableBuilder(
    column: $table.startedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ambition => $composableBuilder(
    column: $table.ambition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedOn => $composableBuilder(
    column: $table.completedOn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VisionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VisionsTable> {
  $$VisionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get why =>
      $composableBuilder(column: $table.why, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get currentValue => $composableBuilder(
    column: $table.currentValue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedOn =>
      $composableBuilder(column: $table.startedOn, builder: (column) => column);

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<double> get ambition =>
      $composableBuilder(column: $table.ambition, builder: (column) => column);

  GeneratedColumn<DateTime> get completedOn => $composableBuilder(
    column: $table.completedOn,
    builder: (column) => column,
  );
}

class $$VisionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VisionsTable,
          VisionRow,
          $$VisionsTableFilterComposer,
          $$VisionsTableOrderingComposer,
          $$VisionsTableAnnotationComposer,
          $$VisionsTableCreateCompanionBuilder,
          $$VisionsTableUpdateCompanionBuilder,
          (VisionRow, BaseReferences<_$AppDatabase, $VisionsTable, VisionRow>),
          VisionRow,
          PrefetchHooks Function()
        > {
  $$VisionsTableTableManager(_$AppDatabase db, $VisionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VisionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VisionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VisionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> why = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double?> targetValue = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<double> currentValue = const Value.absent(),
                Value<DateTime> startedOn = const Value.absent(),
                Value<DateTime> deadline = const Value.absent(),
                Value<double?> ambition = const Value.absent(),
                Value<DateTime?> completedOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VisionsCompanion(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                title: title,
                why: why,
                category: category,
                targetValue: targetValue,
                unit: unit,
                currentValue: currentValue,
                startedOn: startedOn,
                deadline: deadline,
                ambition: ambition,
                completedOn: completedOn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String title,
                Value<String?> why = const Value.absent(),
                required String category,
                Value<double?> targetValue = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<double> currentValue = const Value.absent(),
                required DateTime startedOn,
                required DateTime deadline,
                Value<double?> ambition = const Value.absent(),
                Value<DateTime?> completedOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VisionsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                title: title,
                why: why,
                category: category,
                targetValue: targetValue,
                unit: unit,
                currentValue: currentValue,
                startedOn: startedOn,
                deadline: deadline,
                ambition: ambition,
                completedOn: completedOn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VisionsTable, VisionRow>(table),
                  BaseReferences<_$AppDatabase, $VisionsTable, VisionRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VisionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VisionsTable,
      VisionRow,
      $$VisionsTableFilterComposer,
      $$VisionsTableOrderingComposer,
      $$VisionsTableAnnotationComposer,
      $$VisionsTableCreateCompanionBuilder,
      $$VisionsTableUpdateCompanionBuilder,
      (VisionRow, BaseReferences<_$AppDatabase, $VisionsTable, VisionRow>),
      VisionRow,
      PrefetchHooks Function()
    >;
typedef $$MilestonesTableCreateCompanionBuilder = MilestonesCompanion Function({
  required String id,
  required DateTime updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  required String visionId,
  required String title,
  Value<double?> targetValue,
  Value<int> position,
  Value<DateTime?> completedOn,
  Value<int> rowid,
});
typedef $$MilestonesTableUpdateCompanionBuilder = MilestonesCompanion Function({
  Value<String> id,
  Value<DateTime> updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  Value<String> visionId,
  Value<String> title,
  Value<double?> targetValue,
  Value<int> position,
  Value<DateTime?> completedOn,
  Value<int> rowid,
});

class $$MilestonesTableFilterComposer
    extends Composer<_$AppDatabase, $MilestonesTable> {
  $$MilestonesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get visionId => $composableBuilder(
    column: $table.visionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedOn => $composableBuilder(
    column: $table.completedOn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MilestonesTableOrderingComposer
    extends Composer<_$AppDatabase, $MilestonesTable> {
  $$MilestonesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visionId => $composableBuilder(
    column: $table.visionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedOn => $composableBuilder(
    column: $table.completedOn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MilestonesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MilestonesTable> {
  $$MilestonesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get visionId =>
      $composableBuilder(column: $table.visionId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<DateTime> get completedOn => $composableBuilder(
    column: $table.completedOn,
    builder: (column) => column,
  );
}

class $$MilestonesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MilestonesTable,
          MilestoneRow,
          $$MilestonesTableFilterComposer,
          $$MilestonesTableOrderingComposer,
          $$MilestonesTableAnnotationComposer,
          $$MilestonesTableCreateCompanionBuilder,
          $$MilestonesTableUpdateCompanionBuilder,
          (
            MilestoneRow,
            BaseReferences<_$AppDatabase, $MilestonesTable, MilestoneRow>,
          ),
          MilestoneRow,
          PrefetchHooks Function()
        > {
  $$MilestonesTableTableManager(_$AppDatabase db, $MilestonesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MilestonesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MilestonesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MilestonesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> visionId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double?> targetValue = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<DateTime?> completedOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MilestonesCompanion(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                visionId: visionId,
                title: title,
                targetValue: targetValue,
                position: position,
                completedOn: completedOn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String visionId,
                required String title,
                Value<double?> targetValue = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<DateTime?> completedOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MilestonesCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                visionId: visionId,
                title: title,
                targetValue: targetValue,
                position: position,
                completedOn: completedOn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MilestonesTable, MilestoneRow>(table),
                  BaseReferences<_$AppDatabase, $MilestonesTable, MilestoneRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MilestonesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MilestonesTable,
      MilestoneRow,
      $$MilestonesTableFilterComposer,
      $$MilestonesTableOrderingComposer,
      $$MilestonesTableAnnotationComposer,
      $$MilestonesTableCreateCompanionBuilder,
      $$MilestonesTableUpdateCompanionBuilder,
      (
        MilestoneRow,
        BaseReferences<_$AppDatabase, $MilestonesTable, MilestoneRow>,
      ),
      MilestoneRow,
      PrefetchHooks Function()
    >;
typedef $$FinanceSettingsTableTableCreateCompanionBuilder =
    FinanceSettingsTableCompanion Function({
      required String id,
      required DateTime updatedAt,
      Value<bool> deleted,
      Value<bool> dirty,
      required int essentialsWeekly,
      required int funWeekly,
      required int dailySavingsTarget,
      Value<bool> penaltiesEnabled,
      Value<String> currency,
      Value<int> rowid,
    });
typedef $$FinanceSettingsTableTableUpdateCompanionBuilder =
    FinanceSettingsTableCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> deleted,
      Value<bool> dirty,
      Value<int> essentialsWeekly,
      Value<int> funWeekly,
      Value<int> dailySavingsTarget,
      Value<bool> penaltiesEnabled,
      Value<String> currency,
      Value<int> rowid,
    });

class $$FinanceSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $FinanceSettingsTableTable> {
  $$FinanceSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get essentialsWeekly => $composableBuilder(
    column: $table.essentialsWeekly,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get funWeekly => $composableBuilder(
    column: $table.funWeekly,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dailySavingsTarget => $composableBuilder(
    column: $table.dailySavingsTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get penaltiesEnabled => $composableBuilder(
    column: $table.penaltiesEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FinanceSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FinanceSettingsTableTable> {
  $$FinanceSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get essentialsWeekly => $composableBuilder(
    column: $table.essentialsWeekly,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get funWeekly => $composableBuilder(
    column: $table.funWeekly,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dailySavingsTarget => $composableBuilder(
    column: $table.dailySavingsTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get penaltiesEnabled => $composableBuilder(
    column: $table.penaltiesEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FinanceSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinanceSettingsTableTable> {
  $$FinanceSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<int> get essentialsWeekly => $composableBuilder(
    column: $table.essentialsWeekly,
    builder: (column) => column,
  );

  GeneratedColumn<int> get funWeekly =>
      $composableBuilder(column: $table.funWeekly, builder: (column) => column);

  GeneratedColumn<int> get dailySavingsTarget => $composableBuilder(
    column: $table.dailySavingsTarget,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get penaltiesEnabled => $composableBuilder(
    column: $table.penaltiesEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);
}

class $$FinanceSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FinanceSettingsTableTable,
          FinanceSettingsRow,
          $$FinanceSettingsTableTableFilterComposer,
          $$FinanceSettingsTableTableOrderingComposer,
          $$FinanceSettingsTableTableAnnotationComposer,
          $$FinanceSettingsTableTableCreateCompanionBuilder,
          $$FinanceSettingsTableTableUpdateCompanionBuilder,
          (
            FinanceSettingsRow,
            BaseReferences<
              _$AppDatabase,
              $FinanceSettingsTableTable,
              FinanceSettingsRow
            >,
          ),
          FinanceSettingsRow,
          PrefetchHooks Function()
        > {
  $$FinanceSettingsTableTableTableManager(
    _$AppDatabase db,
    $FinanceSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinanceSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FinanceSettingsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$FinanceSettingsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<int> essentialsWeekly = const Value.absent(),
                Value<int> funWeekly = const Value.absent(),
                Value<int> dailySavingsTarget = const Value.absent(),
                Value<bool> penaltiesEnabled = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinanceSettingsTableCompanion(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                essentialsWeekly: essentialsWeekly,
                funWeekly: funWeekly,
                dailySavingsTarget: dailySavingsTarget,
                penaltiesEnabled: penaltiesEnabled,
                currency: currency,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required int essentialsWeekly,
                required int funWeekly,
                required int dailySavingsTarget,
                Value<bool> penaltiesEnabled = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinanceSettingsTableCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                essentialsWeekly: essentialsWeekly,
                funWeekly: funWeekly,
                dailySavingsTarget: dailySavingsTarget,
                penaltiesEnabled: penaltiesEnabled,
                currency: currency,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FinanceSettingsTableTable, FinanceSettingsRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $FinanceSettingsTableTable,
                    FinanceSettingsRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FinanceSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FinanceSettingsTableTable,
      FinanceSettingsRow,
      $$FinanceSettingsTableTableFilterComposer,
      $$FinanceSettingsTableTableOrderingComposer,
      $$FinanceSettingsTableTableAnnotationComposer,
      $$FinanceSettingsTableTableCreateCompanionBuilder,
      $$FinanceSettingsTableTableUpdateCompanionBuilder,
      (
        FinanceSettingsRow,
        BaseReferences<
          _$AppDatabase,
          $FinanceSettingsTableTable,
          FinanceSettingsRow
        >,
      ),
      FinanceSettingsRow,
      PrefetchHooks Function()
    >;
typedef $$ExpensesTableCreateCompanionBuilder = ExpensesCompanion Function({
  required String id,
  required DateTime updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  required int amount,
  required String category,
  required DateTime day,
  Value<String?> note,
  Value<int> rowid,
});
typedef $$ExpensesTableUpdateCompanionBuilder = ExpensesCompanion Function({
  Value<String> id,
  Value<DateTime> updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  Value<int> amount,
  Value<String> category,
  Value<DateTime> day,
  Value<String?> note,
  Value<int> rowid,
});

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          ExpenseRow,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (
            ExpenseRow,
            BaseReferences<_$AppDatabase, $ExpensesTable, ExpenseRow>,
          ),
          ExpenseRow,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<DateTime> day = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                amount: amount,
                category: category,
                day: day,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required int amount,
                required String category,
                required DateTime day,
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                amount: amount,
                category: category,
                day: day,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExpensesTable, ExpenseRow>(table),
                  BaseReferences<_$AppDatabase, $ExpensesTable, ExpenseRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      ExpenseRow,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (ExpenseRow, BaseReferences<_$AppDatabase, $ExpensesTable, ExpenseRow>),
      ExpenseRow,
      PrefetchHooks Function()
    >;
typedef $$SavingsDepositsTableCreateCompanionBuilder =
    SavingsDepositsCompanion Function({
      required String id,
      required DateTime updatedAt,
      Value<bool> deleted,
      Value<bool> dirty,
      required int amount,
      required DateTime day,
      Value<String?> visionId,
      Value<int> rowid,
    });
typedef $$SavingsDepositsTableUpdateCompanionBuilder =
    SavingsDepositsCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> deleted,
      Value<bool> dirty,
      Value<int> amount,
      Value<DateTime> day,
      Value<String?> visionId,
      Value<int> rowid,
    });

class $$SavingsDepositsTableFilterComposer
    extends Composer<_$AppDatabase, $SavingsDepositsTable> {
  $$SavingsDepositsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get visionId => $composableBuilder(
    column: $table.visionId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavingsDepositsTableOrderingComposer
    extends Composer<_$AppDatabase, $SavingsDepositsTable> {
  $$SavingsDepositsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visionId => $composableBuilder(
    column: $table.visionId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavingsDepositsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavingsDepositsTable> {
  $$SavingsDepositsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<String> get visionId =>
      $composableBuilder(column: $table.visionId, builder: (column) => column);
}

class $$SavingsDepositsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavingsDepositsTable,
          SavingsDepositRow,
          $$SavingsDepositsTableFilterComposer,
          $$SavingsDepositsTableOrderingComposer,
          $$SavingsDepositsTableAnnotationComposer,
          $$SavingsDepositsTableCreateCompanionBuilder,
          $$SavingsDepositsTableUpdateCompanionBuilder,
          (
            SavingsDepositRow,
            BaseReferences<
              _$AppDatabase,
              $SavingsDepositsTable,
              SavingsDepositRow
            >,
          ),
          SavingsDepositRow,
          PrefetchHooks Function()
        > {
  $$SavingsDepositsTableTableManager(
    _$AppDatabase db,
    $SavingsDepositsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavingsDepositsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavingsDepositsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavingsDepositsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<DateTime> day = const Value.absent(),
                Value<String?> visionId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavingsDepositsCompanion(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                amount: amount,
                day: day,
                visionId: visionId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required int amount,
                required DateTime day,
                Value<String?> visionId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavingsDepositsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                amount: amount,
                day: day,
                visionId: visionId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SavingsDepositsTable, SavingsDepositRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SavingsDepositsTable,
                    SavingsDepositRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavingsDepositsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavingsDepositsTable,
      SavingsDepositRow,
      $$SavingsDepositsTableFilterComposer,
      $$SavingsDepositsTableOrderingComposer,
      $$SavingsDepositsTableAnnotationComposer,
      $$SavingsDepositsTableCreateCompanionBuilder,
      $$SavingsDepositsTableUpdateCompanionBuilder,
      (
        SavingsDepositRow,
        BaseReferences<_$AppDatabase, $SavingsDepositsTable, SavingsDepositRow>,
      ),
      SavingsDepositRow,
      PrefetchHooks Function()
    >;
typedef $$BudgetWeeksTableCreateCompanionBuilder =
    BudgetWeeksCompanion Function({
      required String id,
      required DateTime updatedAt,
      Value<bool> deleted,
      Value<bool> dirty,
      required DateTime weekStart,
      required int funBudget,
      Value<int> rowid,
    });
typedef $$BudgetWeeksTableUpdateCompanionBuilder =
    BudgetWeeksCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> deleted,
      Value<bool> dirty,
      Value<DateTime> weekStart,
      Value<int> funBudget,
      Value<int> rowid,
    });

class $$BudgetWeeksTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetWeeksTable> {
  $$BudgetWeeksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get weekStart => $composableBuilder(
    column: $table.weekStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get funBudget => $composableBuilder(
    column: $table.funBudget,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BudgetWeeksTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetWeeksTable> {
  $$BudgetWeeksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get weekStart => $composableBuilder(
    column: $table.weekStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get funBudget => $composableBuilder(
    column: $table.funBudget,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BudgetWeeksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetWeeksTable> {
  $$BudgetWeeksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<DateTime> get weekStart =>
      $composableBuilder(column: $table.weekStart, builder: (column) => column);

  GeneratedColumn<int> get funBudget =>
      $composableBuilder(column: $table.funBudget, builder: (column) => column);
}

class $$BudgetWeeksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BudgetWeeksTable,
          BudgetWeekRow,
          $$BudgetWeeksTableFilterComposer,
          $$BudgetWeeksTableOrderingComposer,
          $$BudgetWeeksTableAnnotationComposer,
          $$BudgetWeeksTableCreateCompanionBuilder,
          $$BudgetWeeksTableUpdateCompanionBuilder,
          (
            BudgetWeekRow,
            BaseReferences<_$AppDatabase, $BudgetWeeksTable, BudgetWeekRow>,
          ),
          BudgetWeekRow,
          PrefetchHooks Function()
        > {
  $$BudgetWeeksTableTableManager(_$AppDatabase db, $BudgetWeeksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetWeeksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetWeeksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetWeeksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<DateTime> weekStart = const Value.absent(),
                Value<int> funBudget = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetWeeksCompanion(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                weekStart: weekStart,
                funBudget: funBudget,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required DateTime weekStart,
                required int funBudget,
                Value<int> rowid = const Value.absent(),
              }) => BudgetWeeksCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                weekStart: weekStart,
                funBudget: funBudget,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BudgetWeeksTable, BudgetWeekRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BudgetWeeksTable,
                    BudgetWeekRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BudgetWeeksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BudgetWeeksTable,
      BudgetWeekRow,
      $$BudgetWeeksTableFilterComposer,
      $$BudgetWeeksTableOrderingComposer,
      $$BudgetWeeksTableAnnotationComposer,
      $$BudgetWeeksTableCreateCompanionBuilder,
      $$BudgetWeeksTableUpdateCompanionBuilder,
      (
        BudgetWeekRow,
        BaseReferences<_$AppDatabase, $BudgetWeeksTable, BudgetWeekRow>,
      ),
      BudgetWeekRow,
      PrefetchHooks Function()
    >;
typedef $$BooksTableCreateCompanionBuilder = BooksCompanion Function({
  required String id,
  required DateTime updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  required String title,
  Value<String?> author,
  required String format,
  Value<String?> localPath,
  Value<int?> totalPages,
  Value<int> position,
  Value<double> progress,
  Value<String?> visionId,
  Value<DateTime?> lastOpenedAt,
  Value<DateTime?> finishedOn,
  Value<int> rowid,
});
typedef $$BooksTableUpdateCompanionBuilder = BooksCompanion Function({
  Value<String> id,
  Value<DateTime> updatedAt,
  Value<bool> deleted,
  Value<bool> dirty,
  Value<String> title,
  Value<String?> author,
  Value<String> format,
  Value<String?> localPath,
  Value<int?> totalPages,
  Value<int> position,
  Value<double> progress,
  Value<String?> visionId,
  Value<DateTime?> lastOpenedAt,
  Value<DateTime?> finishedOn,
  Value<int> rowid,
});

class $$BooksTableFilterComposer extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPages => $composableBuilder(
    column: $table.totalPages,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get visionId => $composableBuilder(
    column: $table.visionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finishedOn => $composableBuilder(
    column: $table.finishedOn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BooksTableOrderingComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPages => $composableBuilder(
    column: $table.totalPages,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visionId => $composableBuilder(
    column: $table.visionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finishedOn => $composableBuilder(
    column: $table.finishedOn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<int> get totalPages => $composableBuilder(
    column: $table.totalPages,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<String> get visionId =>
      $composableBuilder(column: $table.visionId, builder: (column) => column);

  GeneratedColumn<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get finishedOn => $composableBuilder(
    column: $table.finishedOn,
    builder: (column) => column,
  );
}

class $$BooksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BooksTable,
          BookRow,
          $$BooksTableFilterComposer,
          $$BooksTableOrderingComposer,
          $$BooksTableAnnotationComposer,
          $$BooksTableCreateCompanionBuilder,
          $$BooksTableUpdateCompanionBuilder,
          (BookRow, BaseReferences<_$AppDatabase, $BooksTable, BookRow>),
          BookRow,
          PrefetchHooks Function()
        > {
  $$BooksTableTableManager(_$AppDatabase db, $BooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String> format = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<int?> totalPages = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<String?> visionId = const Value.absent(),
                Value<DateTime?> lastOpenedAt = const Value.absent(),
                Value<DateTime?> finishedOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BooksCompanion(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                title: title,
                author: author,
                format: format,
                localPath: localPath,
                totalPages: totalPages,
                position: position,
                progress: progress,
                visionId: visionId,
                lastOpenedAt: lastOpenedAt,
                finishedOn: finishedOn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String title,
                Value<String?> author = const Value.absent(),
                required String format,
                Value<String?> localPath = const Value.absent(),
                Value<int?> totalPages = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<String?> visionId = const Value.absent(),
                Value<DateTime?> lastOpenedAt = const Value.absent(),
                Value<DateTime?> finishedOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BooksCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                title: title,
                author: author,
                format: format,
                localPath: localPath,
                totalPages: totalPages,
                position: position,
                progress: progress,
                visionId: visionId,
                lastOpenedAt: lastOpenedAt,
                finishedOn: finishedOn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BooksTable, BookRow>(table),
                  BaseReferences<_$AppDatabase, $BooksTable, BookRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BooksTable,
      BookRow,
      $$BooksTableFilterComposer,
      $$BooksTableOrderingComposer,
      $$BooksTableAnnotationComposer,
      $$BooksTableCreateCompanionBuilder,
      $$BooksTableUpdateCompanionBuilder,
      (BookRow, BaseReferences<_$AppDatabase, $BooksTable, BookRow>),
      BookRow,
      PrefetchHooks Function()
    >;
typedef $$AnnotationsTableCreateCompanionBuilder =
    AnnotationsCompanion Function({
      required String id,
      required DateTime updatedAt,
      Value<bool> deleted,
      Value<bool> dirty,
      required String bookId,
      required String kind,
      required int position,
      Value<String?> quote,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$AnnotationsTableUpdateCompanionBuilder =
    AnnotationsCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> deleted,
      Value<bool> dirty,
      Value<String> bookId,
      Value<String> kind,
      Value<int> position,
      Value<String?> quote,
      Value<String?> note,
      Value<int> rowid,
    });

class $$AnnotationsTableFilterComposer
    extends Composer<_$AppDatabase, $AnnotationsTable> {
  $$AnnotationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quote => $composableBuilder(
    column: $table.quote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AnnotationsTableOrderingComposer
    extends Composer<_$AppDatabase, $AnnotationsTable> {
  $$AnnotationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quote => $composableBuilder(
    column: $table.quote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AnnotationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnnotationsTable> {
  $$AnnotationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get quote =>
      $composableBuilder(column: $table.quote, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$AnnotationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnnotationsTable,
          AnnotationRow,
          $$AnnotationsTableFilterComposer,
          $$AnnotationsTableOrderingComposer,
          $$AnnotationsTableAnnotationComposer,
          $$AnnotationsTableCreateCompanionBuilder,
          $$AnnotationsTableUpdateCompanionBuilder,
          (
            AnnotationRow,
            BaseReferences<_$AppDatabase, $AnnotationsTable, AnnotationRow>,
          ),
          AnnotationRow,
          PrefetchHooks Function()
        > {
  $$AnnotationsTableTableManager(_$AppDatabase db, $AnnotationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnnotationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnnotationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnnotationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String?> quote = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnnotationsCompanion(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                bookId: bookId,
                kind: kind,
                position: position,
                quote: quote,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String bookId,
                required String kind,
                required int position,
                Value<String?> quote = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnnotationsCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                bookId: bookId,
                kind: kind,
                position: position,
                quote: quote,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AnnotationsTable, AnnotationRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AnnotationsTable,
                    AnnotationRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AnnotationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnnotationsTable,
      AnnotationRow,
      $$AnnotationsTableFilterComposer,
      $$AnnotationsTableOrderingComposer,
      $$AnnotationsTableAnnotationComposer,
      $$AnnotationsTableCreateCompanionBuilder,
      $$AnnotationsTableUpdateCompanionBuilder,
      (
        AnnotationRow,
        BaseReferences<_$AppDatabase, $AnnotationsTable, AnnotationRow>,
      ),
      AnnotationRow,
      PrefetchHooks Function()
    >;
typedef $$CouncilMessagesTableCreateCompanionBuilder =
    CouncilMessagesCompanion Function({
      required String id,
      required DateTime updatedAt,
      Value<bool> deleted,
      Value<bool> dirty,
      required String thread,
      required String author,
      required String body,
      Value<int> rowid,
    });
typedef $$CouncilMessagesTableUpdateCompanionBuilder =
    CouncilMessagesCompanion Function({
      Value<String> id,
      Value<DateTime> updatedAt,
      Value<bool> deleted,
      Value<bool> dirty,
      Value<String> thread,
      Value<String> author,
      Value<String> body,
      Value<int> rowid,
    });

class $$CouncilMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $CouncilMessagesTable> {
  $$CouncilMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thread => $composableBuilder(
    column: $table.thread,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CouncilMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $CouncilMessagesTable> {
  $$CouncilMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thread => $composableBuilder(
    column: $table.thread,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CouncilMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CouncilMessagesTable> {
  $$CouncilMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get thread =>
      $composableBuilder(column: $table.thread, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);
}

class $$CouncilMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CouncilMessagesTable,
          CouncilMessageRow,
          $$CouncilMessagesTableFilterComposer,
          $$CouncilMessagesTableOrderingComposer,
          $$CouncilMessagesTableAnnotationComposer,
          $$CouncilMessagesTableCreateCompanionBuilder,
          $$CouncilMessagesTableUpdateCompanionBuilder,
          (
            CouncilMessageRow,
            BaseReferences<
              _$AppDatabase,
              $CouncilMessagesTable,
              CouncilMessageRow
            >,
          ),
          CouncilMessageRow,
          PrefetchHooks Function()
        > {
  $$CouncilMessagesTableTableManager(
    _$AppDatabase db,
    $CouncilMessagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CouncilMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CouncilMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CouncilMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> thread = const Value.absent(),
                Value<String> author = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CouncilMessagesCompanion(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                thread: thread,
                author: author,
                body: body,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String thread,
                required String author,
                required String body,
                Value<int> rowid = const Value.absent(),
              }) => CouncilMessagesCompanion.insert(
                id: id,
                updatedAt: updatedAt,
                deleted: deleted,
                dirty: dirty,
                thread: thread,
                author: author,
                body: body,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CouncilMessagesTable, CouncilMessageRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CouncilMessagesTable,
                    CouncilMessageRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CouncilMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CouncilMessagesTable,
      CouncilMessageRow,
      $$CouncilMessagesTableFilterComposer,
      $$CouncilMessagesTableOrderingComposer,
      $$CouncilMessagesTableAnnotationComposer,
      $$CouncilMessagesTableCreateCompanionBuilder,
      $$CouncilMessagesTableUpdateCompanionBuilder,
      (
        CouncilMessageRow,
        BaseReferences<_$AppDatabase, $CouncilMessagesTable, CouncilMessageRow>,
      ),
      CouncilMessageRow,
      PrefetchHooks Function()
    >;
typedef $$AppMetaTableCreateCompanionBuilder = AppMetaCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$AppMetaTableUpdateCompanionBuilder = AppMetaCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$AppMetaTableFilterComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppMetaTable,
          AppMetaRow,
          $$AppMetaTableFilterComposer,
          $$AppMetaTableOrderingComposer,
          $$AppMetaTableAnnotationComposer,
          $$AppMetaTableCreateCompanionBuilder,
          $$AppMetaTableUpdateCompanionBuilder,
          (
            AppMetaRow,
            BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaRow>,
          ),
          AppMetaRow,
          PrefetchHooks Function()
        > {
  $$AppMetaTableTableManager(_$AppDatabase db, $AppMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => AppMetaCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) => AppMetaCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppMetaTable, AppMetaRow>(table),
                  BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppMetaTable,
      AppMetaRow,
      $$AppMetaTableFilterComposer,
      $$AppMetaTableOrderingComposer,
      $$AppMetaTableAnnotationComposer,
      $$AppMetaTableCreateCompanionBuilder,
      $$AppMetaTableUpdateCompanionBuilder,
      (AppMetaRow, BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaRow>),
      AppMetaRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$CompletionsTableTableManager get completions =>
      $$CompletionsTableTableManager(_db, _db.completions);
  $$ExcusesTableTableManager get excuses =>
      $$ExcusesTableTableManager(_db, _db.excuses);
  $$RewardsTableTableManager get rewards =>
      $$RewardsTableTableManager(_db, _db.rewards);
  $$RecoveriesTableTableManager get recoveries =>
      $$RecoveriesTableTableManager(_db, _db.recoveries);
  $$VisionsTableTableManager get visions =>
      $$VisionsTableTableManager(_db, _db.visions);
  $$MilestonesTableTableManager get milestones =>
      $$MilestonesTableTableManager(_db, _db.milestones);
  $$FinanceSettingsTableTableTableManager get financeSettingsTable =>
      $$FinanceSettingsTableTableTableManager(_db, _db.financeSettingsTable);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$SavingsDepositsTableTableManager get savingsDeposits =>
      $$SavingsDepositsTableTableManager(_db, _db.savingsDeposits);
  $$BudgetWeeksTableTableManager get budgetWeeks =>
      $$BudgetWeeksTableTableManager(_db, _db.budgetWeeks);
  $$BooksTableTableManager get books =>
      $$BooksTableTableManager(_db, _db.books);
  $$AnnotationsTableTableManager get annotations =>
      $$AnnotationsTableTableManager(_db, _db.annotations);
  $$CouncilMessagesTableTableManager get councilMessages =>
      $$CouncilMessagesTableTableManager(_db, _db.councilMessages);
  $$AppMetaTableTableManager get appMeta =>
      $$AppMetaTableTableManager(_db, _db.appMeta);
}
