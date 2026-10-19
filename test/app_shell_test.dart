import 'package:ascension/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home is the first tab and finance is its first section', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: AscensionApp()));
    await tester.pumpAndSettle();

    expect(find.text('Financial Snapshot'), findsOneWidget);
    expect(find.text('Good morning'), findsOneWidget);
  });

  testWidgets('Bottom navigation switches between the five tabs', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: AscensionApp()));
    await tester.pumpAndSettle();

    for (final tab in ['Missions', 'Finance', 'Knowledge', 'Profile']) {
      await tester.tap(find.widgetWithText(NavigationDestination, tab));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(AppBar, tab), findsOneWidget);
    }
  });
}
