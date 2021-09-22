import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:timely_essence/screens/timer/timer_screen.dart';

void main() {
  testWidgets(
    'Screen should have Timer somewhere on the screen',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: TimerScreen(),
        ),
      );

      final finder = find.text('Timer');

      expect(finder, findsOneWidget,
          reason: 'Timer text should exist on the screen');
    },
  );
}
