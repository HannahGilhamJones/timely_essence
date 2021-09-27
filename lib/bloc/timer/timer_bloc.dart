import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:timely_essence/models/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const int _duration = 15;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(
          TimerInitial(_duration),
        ) {
    on<TimerStart>(_onStarted);
    on<TimerTick>(_onTicked);
    on<TimerPause>(_onPaused);
    on<TimerResume>(_onResumed);
    on<TimerReset>(_onReset);
    on<TimerComplete>(_onCompleted);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimerBloc &&
          runtimeType == other.runtimeType &&
          _ticker == other._ticker &&
          _tickerSubscription == other._tickerSubscription;

  @override
  int get hashCode => _ticker.hashCode + _tickerSubscription.hashCode;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStart event, Emitter<TimerState> emit) {
    if (state is TimerInProgress) {
      return;
    }

    emit(TimerInProgress(event.duration));
    _tickerSubscription = _ticker
        .tickStream(ticks: event.duration)
        .listen((duration) => add(TimerTick(duration: duration)));
  }

  void _onTicked(TimerTick event, Emitter<TimerState> emit) {
    bool running = event.duration > 0;

    if (running) {
      emit(TimerInProgress(event.duration));
      return;
    }

    emit(TimerCompleted());
    this.add(TimerComplete());
  }

  void _onPaused(TimerPause event, Emitter<TimerState> emit) {
    if (state is TimerInProgress) {
      _tickerSubscription?.pause();

      emit(TimerPaused(state.duration));
    }
  }

  void _onResumed(TimerResume event, Emitter<TimerState> emit) {
    if (state is TimerPaused) {
      _tickerSubscription?.resume();
      emit(TimerInProgress(state.duration));
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(TimerInitial(_duration));
  }

  void _onCompleted(TimerComplete event, Emitter<TimerState> emit) {
    if (state is TimerInitial) {
      return;
    }

    _tickerSubscription?.cancel();
    emit(TimerCompleted());
    print('Timer has completed');
  }
}
