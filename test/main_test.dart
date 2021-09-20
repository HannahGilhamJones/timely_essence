import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:timely_essence/main.dart';
import 'package:timely_essence/core.dart';

void main() {
  testWidgets(
    'App creates a Material app with the app as a title',
    (WidgetTester tester) async {
      await tester.pumpWidget(TimelyEssence());

      final finder = find.byType(MaterialApp);

      expect(finder, findsOneWidget);

      MaterialApp app = finder.evaluate().first.widget as MaterialApp;

      expect(app.title, 'Timely Essence');
    },
  );

  testWidgets(
    'App creates a material app with Core as the home',
    (WidgetTester tester) async {
      await tester.pumpWidget(TimelyEssence());

      final finder = find.byType(MaterialApp);

      expect(finder, findsOneWidget);

      MaterialApp app = finder.evaluate().first.widget as MaterialApp;

      expect(app.home.runtimeType, Core);
    },
  );
}
