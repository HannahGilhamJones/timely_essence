import 'package:flutter_test/flutter_test.dart';
import 'package:timely_essence/bloc/timer/timer_bloc.dart';
import 'package:timely_essence/models/ticker.dart';

void main() {
  test('initial state should be TimerInitial', () async {
    final Ticker ticker = Ticker();
    final TimerBloc timerBloc = TimerBloc(ticker: ticker);

    await expectLater(timerBloc.state.runtimeType, TimerInitial);
  });
}
