import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:timely_essence/screens/timer/timer_screen.dart';

void main() {
  testWidgets(
    'Screen should have Timer Text somewhere on the screen',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TimerScreen(),
          ),
        ),
      );

      final finder = find.byType(TimerText);

      expect(finder, findsOneWidget,
          reason: 'Timer text should exist on the screen');
    },
  );
}
