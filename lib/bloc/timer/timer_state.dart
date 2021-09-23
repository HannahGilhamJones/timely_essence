part of 'timer_bloc.dart';

@immutable
abstract class TimerState extends Equatable {
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial(int duration) : super(duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

class TimerPaused extends TimerState {
  const TimerPaused(int duration) : super(duration);

  @override
  String toString() => 'TimerPaused { duration: $duration }';
}

class TimerInProgress extends TimerState {
  const TimerInProgress(int duration) : super(duration);

  @override
  String toString() => 'TimerInProgress { duration: $duration }';
}

class TimerCompleted extends TimerState {
  const TimerCompleted() : super(0);
}
