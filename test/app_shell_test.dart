import 'package:ascension/app/app.dart';
import 'package:ascension/core/database/app_database.dart';
import 'package:ascension/features/profile/data/profile_repository.dart';
import 'package:ascension/features/profile/domain/profile.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));

  /// Lets real database work run between frames until [until] shows up
  /// (pumpAndSettle can't: drift's queries need the real event loop).
  Future<void> settle(WidgetTester tester, {Finder? until}) async {
    for (var i = 0; i < 40; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 10)),
      );
      await tester.pump(const Duration(milliseconds: 100));
      if (until != null && until.evaluate().isNotEmpty) return;
    }
    if (until != null) expect(until, findsWidgets);
  }

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: const AscensionApp(),
      ),
    );
    await settle(tester, until: find.byType(Scaffold));
  }

  Future<void> tearDownApp(WidgetTester tester) async {
    // Unmount first so drift's stream queries are cancelled. The in-memory
    // database isn't closed: a query begun under the test's fake clock would
    // keep close() waiting.
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
  }

  testWidgets('new users start with onboarding and land on Home', (
    tester,
  ) async {
    await pumpApp(tester);
    await settle(
      tester,
      until: find.text('You choose who you want to become.'),
    );

    await tester.enterText(find.byType(TextField).first, 'Amani');
    for (final label in ['Next', 'Next', 'Next', 'Skip', 'Skip', 'Start']) {
      await tester.tap(find.text(label).last);
      await settle(tester);
    }
    await settle(tester, until: find.textContaining('Amani'));
    expect(find.text('Financial Snapshot'), findsOneWidget);
    expect(find.text('Read 20 pages'), findsWidgets);
    await tearDownApp(tester);
  });

  testWidgets('returning users go straight to Home; tabs switch', (
    tester,
  ) async {
    await ProfileRepository(db).save(const Profile(onboarded: true));
    await pumpApp(tester);
    await settle(tester, until: find.text('Financial Snapshot'));

    for (final tab in ['Missions', 'Finance', 'Knowledge', 'Profile']) {
      await tester.tap(find.widgetWithText(NavigationDestination, tab));
      await settle(tester, until: find.widgetWithText(AppBar, tab));
    }
    await tearDownApp(tester);
  });

  testWidgets('ticking a mission awards XP', (tester) async {
    await ProfileRepository(db).save(const Profile(onboarded: true));
    await pumpApp(tester);
    await settle(tester, until: find.text('Financial Snapshot'));
    await tester.tap(find.widgetWithText(NavigationDestination, 'Missions'));
    await settle(tester, until: find.text('Habit'));

    await tester.tap(find.text('Habit'));
    await settle(tester, until: find.text('New habit'));
    await tester.pump(const Duration(seconds: 1)); // sheet slide-in
    await tester.enterText(find.byType(TextFormField).first, 'Stretch');
    await tester.ensureVisible(find.text('Save'));
    await tester.pump();
    await tester.tap(find.text('Save'));
    await settle(tester, until: find.byType(Checkbox));

    await tester.tap(find.byType(Checkbox).first);
    // New habit: 2 base XP halved to 1.
    await settle(tester, until: find.textContaining('+1 XP · '));
    await tearDownApp(tester);
  });
}
