import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timely_essence/screens/timer/components/timer_actions.dart';

import 'package:timely_essence/screens/timer/timer_screen.dart';
import 'package:timely_essence/screens/timer/components/timer.dart';

void main() {
  Future<void> _createApp(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TimerScreen(),
        ),
      ),
    );
  }

  group('Screen UI', () {
    testWidgets('Screen has a column', (WidgetTester tester) async {
      await _createApp(tester);

      final finder = find.byType(Column);

      expect(finder, findsOneWidget,
          reason: 'There is a column on the timer screen');
    });

    group('Timer widget', () {
      testWidgets('Screen has a timer widget', (WidgetTester tester) async {
        await _createApp(tester);

        final finder = find.byType(Timer);

        expect(finder, findsOneWidget,
            reason: 'There must be a timer widget on the screen');
      });
    });

    group('Timer action bar', () {
      testWidgets('Screen has a row of action buttons',
          (WidgetTester tester) async {
        await _createApp(tester);

        final finder = find.byType(TimerActions);

        expect(finder, findsOneWidget,
            reason: 'There must be a timer action bar on the screen');
      });
    });
  });
}
