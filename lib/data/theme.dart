import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Themes {
  ThemeData get currentTheme {
    return _isDarkMode() ? _darkStyle() : _lightStyle();
  }

  bool _isDarkMode() {
    Brightness brightness =
        SchedulerBinding.instance!.window.platformBrightness;
    return brightness == Brightness.dark;
  }

  ThemeData _lightStyle() {
    return ThemeData.light().copyWith(
      colorScheme: ColorScheme.light().copyWith(
        primary: Colors.green[300],
      ),
    );
  }

  ThemeData _darkStyle() {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark().copyWith(
        primary: Colors.green[800],
        secondary: Colors.blue[200],
      ),
    );
  }
}
