import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:timely_essence/core.dart';

void main() {
  testWidgets(
    'Core app has an app bar with the app title',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Core(title: 'Timely Essence'),
        ),
      );

      final finder = find.byType(AppBar);

      expect(finder, findsOneWidget);

      AppBar appBar = finder.evaluate().first.widget as AppBar;
      Text appBarTitle = appBar.title as Text;

      expect(appBarTitle.data, 'Timely Essence');
    },
  );

  testWidgets('Application has three pages', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Core(title: 'Timely Essence'),
      ),
    );

    final finder = find.byType(PageView);

    expect(finder, findsOneWidget);

    PageView pageView = finder.evaluate().first.widget as PageView;
    SliverChildDelegate pageViewDelegate = pageView.childrenDelegate;
    int? childrenCount = pageViewDelegate.estimatedChildCount;

    expect(childrenCount, 3);
  });

  testWidgets('There is a bottom navigation bar with three items',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Core(
          title: 'Timely Essence',
        ),
      ),
    );

    final finder = find.byType(BottomNavigationBar);

    expect(finder, findsOneWidget);

    BottomNavigationBar bar =
        finder.evaluate().first.widget as BottomNavigationBar;
    int barItemCount = bar.items.length;

    expect(barItemCount, 3);
  });

  testWidgets(
      'The bottom navigation bar has a timer, stopwatch and settings item',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Core(
          title: 'Timely Essence',
        ),
      ),
    );

    final finder = find.byType(BottomNavigationBar);

    expect(finder, findsOneWidget);

    BottomNavigationBar bar =
        finder.evaluate().first.widget as BottomNavigationBar;
    int barItemCount = bar.items.length;

    expect(barItemCount, 3);

    List<BottomNavigationBarItem> barItems = bar.items;
    bool foundTimer = false;
    bool foundStopwatch = false;
    bool foundSettings = false;

    barItems.forEach((element) {
      BottomNavigationBarItem barItem = element;
      switch (barItem.label) {
        case 'Timer':
          foundTimer = true;
          break;
        case 'Stopwatch':
          foundStopwatch = true;
          break;
        case 'Settings':
          foundSettings = true;
          break;
      }

      Icon barItemIcon = barItem.icon as Icon;
      expect(barItemIcon.semanticLabel?.isNotEmpty, true,
          reason: 'Icon should have a semantic label');
    });

    expect(foundTimer, true);
    expect(foundStopwatch, true);
    expect(foundSettings, true);
  });
}
