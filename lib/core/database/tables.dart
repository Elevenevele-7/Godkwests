import 'package:drift/drift.dart';

/// Columns every synced table has. `dirty` marks rows changed on this
/// device since the last sync; `deleted` is a soft delete so deletions sync.
mixin Syncable on Table {
  TextColumn get id => text()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  BoolColumn get dirty => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// One row: the user's profile and preferences.
@DataClassName('ProfileRow')
class Profiles extends Table with Syncable {
  TextColumn get displayName => text().withDefault(const Constant(''))();
  TextColumn get accountability =>
      text().withDefault(const Constant('balanced'))();

  /// JSON list of chosen growth areas.
  TextColumn get areas => text().withDefault(const Constant('[]'))();
  TextColumn get advisor => text().withDefault(const Constant('strategist'))();

  /// 1 (gentle) – 3 (direct) coaching strictness.
  IntColumn get strictness => integer().withDefault(const Constant(2))();
  BoolColumn get onboarded => boolean().withDefault(const Constant(false))();
}

@DataClassName('HabitRow')
class Habits extends Table with Syncable {
  TextColumn get name => text()();
  IntColumn get baseXp => integer()();

  /// Comma-separated weekdays, 1 = Monday … 7 = Sunday.
  TextColumn get weekdays => text()();
  DateTimeColumn get createdOn => dateTime()();
  TextColumn get area => text().nullable()();
  TextColumn get visionId => text().nullable()();
  IntColumn get target => integer().nullable()();
  TextColumn get unit => text().nullable()();
  IntColumn get previousTarget => integer().nullable()();
  IntColumn get previousBaseXp => integer().nullable()();
  DateTimeColumn get evolvedOn => dateTime().nullable()();
  DateTimeColumn get evolveDeclinedOn => dateTime().nullable()();
  DateTimeColumn get archivedOn => dateTime().nullable()();
}

/// A habit done on a day. id is `habitId:yyyy-mm-dd`, so it's unique.
@DataClassName('CompletionRow')
class Completions extends Table with Syncable {
  TextColumn get habitId => text()();
  DateTimeColumn get day => dateTime()();
}

@DataClassName('ExcuseRow')
class Excuses extends Table with Syncable {
  DateTimeColumn get day => dateTime()();
  TextColumn get reason => text()();
  TextColumn get note => text().nullable()();
}

/// Append-only XP / DP / VP ledger. id is the reward key.
@DataClassName('RewardRow')
class Rewards extends Table with Syncable {
  TextColumn get currency => text()();
  TextColumn get kind => text()();
  IntColumn get amount => integer()();
  DateTimeColumn get day => dateTime()();
  TextColumn get explanation => text()();
  TextColumn get refId => text().nullable()();
}

@DataClassName('RecoveryRow')
class Recoveries extends Table with Syncable {
  TextColumn get habitId => text()();
  DateTimeColumn get startedOn => dateTime()();
  DateTimeColumn get completedOn => dateTime().nullable()();

  /// JSON list of forgiven miss days (yyyy-mm-dd).
  TextColumn get forgiven => text().withDefault(const Constant('[]'))();
}

@DataClassName('VisionRow')
class Visions extends Table with Syncable {
  TextColumn get title => text()();
  TextColumn get why => text().nullable()();
  TextColumn get category => text()();
  RealColumn get targetValue => real().nullable()();
  TextColumn get unit => text().nullable()();
  RealColumn get currentValue => real().withDefault(const Constant(0))();
  DateTimeColumn get startedOn => dateTime()();
  DateTimeColumn get deadline => dateTime()();
  RealColumn get ambition => real().nullable()();
  DateTimeColumn get completedOn => dateTime().nullable()();
}

@DataClassName('MilestoneRow')
class Milestones extends Table with Syncable {
  TextColumn get visionId => text()();
  TextColumn get title => text()();
  RealColumn get targetValue => real().nullable()();
  IntColumn get position => integer().withDefault(const Constant(0))();
  DateTimeColumn get completedOn => dateTime().nullable()();
}

// Finance tables. Synced end-to-end encrypted (see docs/database.md).

@DataClassName('FinanceSettingsRow')
class FinanceSettingsTable extends Table with Syncable {
  @override
  String get tableName => 'finance_settings';

  IntColumn get essentialsWeekly => integer()();
  IntColumn get funWeekly => integer()();
  IntColumn get dailySavingsTarget => integer()();
  BoolColumn get penaltiesEnabled =>
      boolean().withDefault(const Constant(false))();
  TextColumn get currency => text().withDefault(const Constant('KSh'))();
}

@DataClassName('ExpenseRow')
class Expenses extends Table with Syncable {
  IntColumn get amount => integer()();
  TextColumn get category => text()();
  DateTimeColumn get day => dateTime()();
  TextColumn get note => text().nullable()();
}

@DataClassName('SavingsDepositRow')
class SavingsDeposits extends Table with Syncable {
  IntColumn get amount => integer()();
  DateTimeColumn get day => dateTime()();
  TextColumn get visionId => text().nullable()();
}

/// The fun budget fixed at the start of each week. id is the week's
/// Monday as yyyy-mm-dd.
@DataClassName('BudgetWeekRow')
class BudgetWeeks extends Table with Syncable {
  DateTimeColumn get weekStart => dateTime()();
  IntColumn get funBudget => integer()();
}

// Knowledge Hub.

@DataClassName('BookRow')
class Books extends Table with Syncable {
  TextColumn get title => text()();
  TextColumn get author => text().nullable()();

  /// pdf or epub.
  TextColumn get format => text()();

  /// Path of the imported copy on this device. Files don't sync.
  TextColumn get localPath => text().nullable()();
  IntColumn get totalPages => integer().nullable()();

  /// Page (PDF) or chapter index (EPUB).
  IntColumn get position => integer().withDefault(const Constant(0))();

  /// 0–1.
  RealColumn get progress => real().withDefault(const Constant(0))();
  TextColumn get visionId => text().nullable()();
  DateTimeColumn get lastOpenedAt => dateTime().nullable()();
  DateTimeColumn get finishedOn => dateTime().nullable()();
}

/// Bookmarks, highlights and notes.
@DataClassName('AnnotationRow')
class Annotations extends Table with Syncable {
  TextColumn get bookId => text()();

  /// bookmark, highlight or note.
  TextColumn get kind => text()();
  IntColumn get position => integer()();
  TextColumn get quote => text().nullable()();
  TextColumn get note => text().nullable()();
}

// AI Council.

@DataClassName('CouncilMessageRow')
class CouncilMessages extends Table with Syncable {
  /// Conversation: an advisor id, or `chamber`.
  TextColumn get thread => text()();

  /// user or an advisor id.
  TextColumn get author => text()();
  TextColumn get body => text()();
}

/// Key–value app state, e.g. the last day whose penalties were applied.
/// Local only.
@DataClassName('AppMetaRow')
class AppMeta extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
