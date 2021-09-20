import 'package:flutter/material.dart';

import 'package:timely_essence/core.dart';
import 'package:timely_essence/data/user_messages.dart';
import 'package:timely_essence/utils/themes.dart';

void main() {
  runApp(TimelyEssence());
}

class TimelyEssence extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: UserMessages.APP_TITLE,
      theme: Themes().currentTheme,
      home: Core(
        title: UserMessages.APP_TITLE,
      ),
    );
  }
}
