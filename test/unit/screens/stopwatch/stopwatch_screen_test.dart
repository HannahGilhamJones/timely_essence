import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:timely_essence/screens/stopwatch/stopwatch_screen.dart';

void main() {
  testWidgets(
    'Screen should have Stopwatch somewhere on the screen',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: StopwatchScreen(),
        ),
      );

      final finder = find.text('Stopwatch');

      expect(finder, findsOneWidget,
          reason: 'Stopwatch text should exist on the screen');
    },
  );
}
