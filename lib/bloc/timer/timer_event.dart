part of 'timer_bloc.dart';

@immutable
abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStart extends TimerEvent {
  final int duration;

  const TimerStart({required this.duration});
}

class TimerPause extends TimerEvent {
  const TimerPause();
}

class TimerResume extends TimerEvent {
  const TimerResume();
}

class TimerReset extends TimerEvent {
  const TimerReset();
}

class TimerComplete extends TimerEvent {
  const TimerComplete();
}

class TimerTick extends TimerEvent {
  final int duration;

  const TimerTick({required this.duration});

  @override
  List<Object> get props => [duration];
}
