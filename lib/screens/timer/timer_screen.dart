import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timely_essence/bloc/timer/timer_bloc.dart';
import 'package:timely_essence/models/ticker.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

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
                  child: TimerText(),
                ),
              ),
              BlocBuilder<TimerBloc, TimerState>(
                buildWhen: (prev, state) =>
                    prev.runtimeType != state.runtimeType,
                builder: (context, state) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state is TimerInitial || state is TimerPaused) ...[
                        IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: () => context.read<TimerBloc>().add(
                                TimerStart(duration: state.duration),
                              ),
                        ),
                      ],
                      if (state is TimerInProgress) ...[
                        IconButton(
                          icon: Icon(Icons.pause),
                          onPressed: () => context.read<TimerBloc>().add(
                                TimerPause(),
                              ),
                        ),
                      ],
                      if (state is TimerInProgress ||
                          state is TimerPaused ||
                          state is TimerCompleted) ...[
                        IconButton(
                          icon: Icon(Icons.restart_alt),
                          onPressed: () => context.read<TimerBloc>().add(
                                TimerReset(),
                              ),
                        ),
                      ]
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');

    return Text(
      '$minutesStr:$secondsStr',
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
