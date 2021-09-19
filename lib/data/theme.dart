import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Themes {
  static ThemeData currentTheme() {
    Brightness brightness =
        SchedulerBinding.instance!.window.platformBrightness;
    print(brightness.toString());
    final bool isDarkMode = brightness == Brightness.dark;

    return isDarkMode ? _darkStyle() : _lightStyle();
  }

  static ThemeData _lightStyle() {
    return ThemeData.light().copyWith(
      colorScheme: ColorScheme.light().copyWith(
        primary: Colors.green[300],
      ),
    );
  }

  static ThemeData _darkStyle() {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark().copyWith(
        primary: Colors.green[800],
        secondary: Colors.blue[200],
      ),
    );
  }
}
