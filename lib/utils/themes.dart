import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:timely_essence/data/default_themes.dart';

class Themes {
  ThemeData get currentTheme {
    return _isDarkMode() ? DefaultThemes.darkTheme : DefaultThemes.lightTheme;
  }

  bool _isDarkMode() {
    Brightness brightness =
        SchedulerBinding.instance!.window.platformBrightness;
    return brightness == Brightness.dark;
  }
}
