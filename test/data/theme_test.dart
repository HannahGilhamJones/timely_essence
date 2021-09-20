import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:timely_essence/main.dart';

void main() {
  testWidgets('Dark theme on system enables dark theme in app',
      (WidgetTester tester) async {
    tester.binding.window.platformBrightnessTestValue = Brightness.dark;

    await tester.pumpWidget(MyApp());

    final finder = find.byType(MyHomePage);

    expect(finder, findsOneWidget);

    State state = tester.state(finder);
    ThemeData data = Theme.of(state.context);

    expect(data.colorScheme.primary, Colors.green[800]);
    expect(data.colorScheme.secondary, Colors.blue[200]);
  });

  testWidgets('Light theme on system enables light theme in app',
      (WidgetTester tester) async {
    tester.binding.window.platformBrightnessTestValue = Brightness.light;

    await tester.pumpWidget(MyApp());

    final finder = find.byType(MyHomePage);

    expect(finder, findsOneWidget);

    State state = tester.state(finder);
    ThemeData data = Theme.of(state.context);

    expect(data.colorScheme.primary, Colors.green[300]);
  });
}
