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

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Core(title: 'Timely Essence'),
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
