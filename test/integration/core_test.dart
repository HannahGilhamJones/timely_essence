import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:timely_essence/core.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Swiping between pages', () {
    testWidgets('Swipe from timer to stopwatch to settings',
        (WidgetTester tester) async {
      const Key _timerPageKey = Key('timerPage');
      const Key _stopwatchPageKey = Key('stopwatchPage');
      const Key _settingsPageKey = Key('settingsPage');

      await tester.pumpWidget(
        MaterialApp(
          home: Core(title: 'Timely Essence'),
        ),
      );

      // Drag timer page to stopwatch page
      await tester.drag(find.byKey(_timerPageKey), const Offset(-500.0, 0.0));
      await tester.pumpAndSettle();

      expect(
        find.byKey(_stopwatchPageKey),
        findsOneWidget,
        reason: 'Swiping left on timer page leads to stopwatch page',
      );

      Finder bottomNavigationBar = find.byType(BottomNavigationBar);
      expect(
        bottomNavigationBar,
        findsOneWidget,
        reason: 'Bottom navigation bar should exist on stopwatch page',
      );

      BottomNavigationBar bottomNavBar =
          bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;
      expect(
        bottomNavBar.currentIndex,
        1,
        reason:
            'Bottom navigation bar index should now match the stopwatch index',
      );

      // Drag stopwatch page to settings page
      await tester.drag(
          find.byKey(_stopwatchPageKey), const Offset(-500.0, 0.0));
      await tester.pumpAndSettle();

      expect(
        find.byKey(_settingsPageKey),
        findsOneWidget,
        reason: 'Swiping left on stopwatch page leads to settings page',
      );

      bottomNavigationBar = find.byType(BottomNavigationBar);
      expect(
        bottomNavigationBar,
        findsOneWidget,
        reason: 'Bottom navigation bar should exist on settings page',
      );

      bottomNavBar =
          bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;
      expect(
        bottomNavBar.currentIndex,
        2,
        reason:
            'Bottom navigation bar index should now match the settings index',
      );

      // Drag settings page to settings page
      await tester.drag(
          find.byKey(_settingsPageKey), const Offset(-500.0, 0.0));
      await tester.pumpAndSettle();

      expect(
        find.byKey(_settingsPageKey),
        findsOneWidget,
        reason: 'Swiping left on settings page remains on settings',
      );

      bottomNavigationBar = find.byType(BottomNavigationBar);
      expect(
        bottomNavigationBar,
        findsOneWidget,
        reason: 'Bottom navigation bar should exist on settings page',
      );

      bottomNavBar =
          bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;
      expect(
        bottomNavBar.currentIndex,
        2,
        reason:
            'Bottom navigation bar index should now match the settings index',
      );

      // Drag settings page right leads to stopwatch page
      await tester.drag(find.byKey(_settingsPageKey), const Offset(500.0, 0.0));
      await tester.pumpAndSettle();

      expect(
        find.byKey(_stopwatchPageKey),
        findsOneWidget,
        reason: 'Swiping right on settings page leads to stopwatch page',
      );

      bottomNavigationBar = find.byType(BottomNavigationBar);
      expect(
        bottomNavigationBar,
        findsOneWidget,
        reason: 'Bottom navigation bar should exist on stopwatch page',
      );

      bottomNavBar =
          bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;
      expect(
        bottomNavBar.currentIndex,
        1,
        reason:
            'Bottom navigation bar index should now match the stopwatch index',
      );

      // Drag stopwatch page right leads to timer page
      await tester.drag(
          find.byKey(_stopwatchPageKey), const Offset(500.0, 0.0));
      await tester.pumpAndSettle();

      expect(
        find.byKey(_timerPageKey),
        findsOneWidget,
        reason: 'Swiping right on stopwatch page leads to timer page',
      );

      bottomNavigationBar = find.byType(BottomNavigationBar);
      expect(
        bottomNavigationBar,
        findsOneWidget,
        reason: 'Bottom navigation bar should exist on timer page',
      );

      bottomNavBar =
          bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;
      expect(
        bottomNavBar.currentIndex,
        0,
        reason:
            'Bottom navigation bar index should now match the stopwatch index',
      );

      // Drag timer page right remains on timer page
      await tester.drag(find.byKey(_timerPageKey), const Offset(500.0, 0.0));
      await tester.pumpAndSettle();

      expect(
        find.byKey(_timerPageKey),
        findsOneWidget,
        reason: 'Swiping right on timer page remains on timer page',
      );

      bottomNavigationBar = find.byType(BottomNavigationBar);
      expect(
        bottomNavigationBar,
        findsOneWidget,
        reason: 'Bottom navigation bar should exist on settings page',
      );

      bottomNavBar =
          bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;
      expect(
        bottomNavBar.currentIndex,
        0,
        reason: 'Bottom navigation bar index should now match the timer index',
      );
    });
  });

  group('Swiping and using navigation bar item', () {
    testWidgets('Swiping and touching navigation bar navigates between screens',
        (WidgetTester tester) async {
      const Key _timerPageKey = Key('timerPage');
      const IconData _timerIcon = Icons.timer;
      const int _timerIndex = 0;
      const Key _stopwatchPageKey = Key('stopwatchPage');
      const IconData _stopwatchIcon = Icons.timelapse_rounded;
      const int _stopwatchIndex = 1;
      const Key _settingsPageKey = Key('settingsPage');
      const IconData _settingsIcon = Icons.settings;
      const int _settingsIndex = 2;

      await tester.pumpWidget(
        MaterialApp(
          home: Core(title: 'Timely Essence'),
        ),
      );

      // 1. Click on Settings navigation bar item
      await tester.tap(find.byIcon(_settingsIcon));
      await tester.pumpAndSettle();

      expect(find.byKey(_settingsPageKey), findsOneWidget,
          reason:
              'Clicking on settings navigation bar item goes to settings page');

      Finder bottomNavigationBar = find.byType(BottomNavigationBar);
      expect(
        bottomNavigationBar,
        findsOneWidget,
        reason: 'Bottom navigation bar should exist on settings page',
      );

      BottomNavigationBar bottomNavBar =
          bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;
      expect(
        bottomNavBar.currentIndex,
        _settingsIndex,
        reason:
            'Bottom navigation bar index should now match the settings index',
      );

      // 2. Swipe to Stopwatch Page
      await tester.drag(find.byKey(_settingsPageKey), const Offset(500.0, 0.0));
      await tester.pumpAndSettle();

      expect(
        find.byKey(_stopwatchPageKey),
        findsOneWidget,
        reason: 'Swiping right on settings page leads to stopwatch page',
      );

      bottomNavigationBar = find.byType(BottomNavigationBar);
      expect(
        bottomNavigationBar,
        findsOneWidget,
        reason: 'Bottom navigation bar should exist on stopwatch page',
      );

      bottomNavBar =
          bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;
      expect(
        bottomNavBar.currentIndex,
        _stopwatchIndex,
        reason:
            'Bottom navigation bar index should now match the stopwatch index',
      );

      // 3. Swipe to Settings page
      await tester.drag(
          find.byKey(_stopwatchPageKey), const Offset(-500.0, 0.0));
      await tester.pumpAndSettle();

      expect(
        find.byKey(_settingsPageKey),
        findsOneWidget,
        reason: 'Swiping left on stopwatch page leads to settings page',
      );

      bottomNavigationBar = find.byType(BottomNavigationBar);
      expect(
        bottomNavigationBar,
        findsOneWidget,
        reason: 'Bottom navigation bar should exist on settings page',
      );

      bottomNavBar =
          bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;
      expect(
        bottomNavBar.currentIndex,
        _settingsIndex,
        reason:
            'Bottom navigation bar index should now match the settings index',
      );

      // 4. Click on Timer navigation bar item
      await tester.tap(find.byIcon(_timerIcon));
      await tester.pumpAndSettle();

      expect(find.byKey(_timerPageKey), findsOneWidget,
          reason: 'Clicking on timer navigation bar item goes to timer page');

      bottomNavigationBar = find.byType(BottomNavigationBar);
      expect(
        bottomNavigationBar,
        findsOneWidget,
        reason: 'Bottom navigation bar should exist on timer page',
      );

      bottomNavBar =
          bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;
      expect(
        bottomNavBar.currentIndex,
        _timerIndex,
        reason: 'Bottom navigation bar index should now match the timer index',
      );

      // 5. Click on Timer navigation bar item
      await tester.tap(find.byIcon(_timerIcon));
      await tester.pumpAndSettle();

      expect(find.byKey(_timerPageKey), findsOneWidget,
          reason: 'Clicking on timer navigation bar item goes to timer page');

      bottomNavigationBar = find.byType(BottomNavigationBar);
      expect(
        bottomNavigationBar,
        findsOneWidget,
        reason: 'Bottom navigation bar should exist on timer page',
      );

      bottomNavBar =
          bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;
      expect(
        bottomNavBar.currentIndex,
        _timerIndex,
        reason: 'Bottom navigation bar index should now match the timer index',
      );

      // 6. Swipe to Stopwatch page
      await tester.drag(find.byKey(_timerPageKey), const Offset(-500.0, 0.0));
      await tester.pumpAndSettle();

      expect(
        find.byKey(_stopwatchPageKey),
        findsOneWidget,
        reason: 'Swiping left on timer page leads to stopwatch page',
      );

      bottomNavigationBar = find.byType(BottomNavigationBar);
      expect(
        bottomNavigationBar,
        findsOneWidget,
        reason: 'Bottom navigation bar should exist on stopwatch page',
      );

      bottomNavBar =
          bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;
      expect(
        bottomNavBar.currentIndex,
        _stopwatchIndex,
        reason:
            'Bottom navigation bar index should now match the stopwatch index',
      );

      // 7. Swipe to Settings page
      await tester.drag(
          find.byKey(_stopwatchPageKey), const Offset(-500.0, 0.0));
      await tester.pumpAndSettle();

      expect(
        find.byKey(_settingsPageKey),
        findsOneWidget,
        reason: 'Swiping left on stopwatch page leads to settings page',
      );

      bottomNavigationBar = find.byType(BottomNavigationBar);
      expect(
        bottomNavigationBar,
        findsOneWidget,
        reason: 'Bottom navigation bar should exist on settings page',
      );

      bottomNavBar =
          bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;
      expect(
        bottomNavBar.currentIndex,
        _settingsIndex,
        reason:
            'Bottom navigation bar index should now match the settings index',
      );

      // 8. Click on Stopwatch navigation bar item
      await tester.tap(find.byIcon(_stopwatchIcon));
      await tester.pumpAndSettle();

      expect(find.byKey(_stopwatchPageKey), findsOneWidget,
          reason:
              'Clicking on stopwatch navigation bar item goes to timer page');

      bottomNavigationBar = find.byType(BottomNavigationBar);
      expect(
        bottomNavigationBar,
        findsOneWidget,
        reason: 'Bottom navigation bar should exist on timer page',
      );

      bottomNavBar =
          bottomNavigationBar.evaluate().first.widget as BottomNavigationBar;
      expect(
        bottomNavBar.currentIndex,
        _stopwatchIndex,
        reason:
            'Bottom navigation bar index should now match the stopwatch index',
      );
    });
  });
}
