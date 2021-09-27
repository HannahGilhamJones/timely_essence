import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timely_essence/bloc/timer/timer_bloc.dart';

class TimerActions extends StatefulWidget {
  const TimerActions({Key? key}) : super(key: key);

  @override
  _TimerActionsState createState() => _TimerActionsState();
}

class _TimerActionsState extends State<TimerActions> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
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
    );
  }
}
