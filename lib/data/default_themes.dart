import 'package:flutter/material.dart';

abstract class DefaultThemes {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.dark().copyWith(
      primary: Colors.green[800],
      secondary: Colors.blue[200],
    ),
  );

  static ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.light().copyWith(
      primary: Colors.green[300],
    ),
  );
}
