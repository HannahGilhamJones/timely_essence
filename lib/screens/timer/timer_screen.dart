import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timely_essence/bloc/timer/timer_bloc.dart';
import 'package:timely_essence/models/ticker.dart';
import 'package:timely_essence/screens/timer/components/timer.dart';
import 'package:timely_essence/screens/timer/components/timer_actions.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen() : super(key: const Key('timerPage'));

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: Ticker()),
      child: Stack(
        children: [
          Container(
            color: Colors.blue,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: Center(
                  child: Timer(),
                ),
              ),
              TimerActions()
            ],
          ),
        ],
      ),
    );
  }
}
