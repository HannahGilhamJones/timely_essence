import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:timely_essence/screens/settings/settings_screen.dart';

void main() {
  testWidgets(
    'Screen should have Settings somewhere on the screen',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SettingsScreen(),
        ),
      );

      final finder = find.text('Settings');

      expect(finder, findsOneWidget,
          reason: 'Settings text should exist on the screen');
    },
  );
}
