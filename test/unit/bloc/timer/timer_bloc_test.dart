import 'package:flutter_test/flutter_test.dart';
import 'package:timely_essence/bloc/timer/timer_bloc.dart';
import 'package:timely_essence/models/ticker.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('Default states', () {
    test('initial state should be TimerInitial', () async {
      final Ticker ticker = Ticker();
      final TimerBloc timerBloc = TimerBloc(ticker: ticker);

      await expectLater(timerBloc.state.runtimeType, TimerInitial);
    });

    test('initial duration should be 15 seconds', () {
      final Ticker ticker = Ticker();
      final TimerBloc timerBloc = TimerBloc(ticker: ticker);

      expect(timerBloc.state.duration, 15);
    });
  });

  group('Timer states', () {
    group(
      'Timer start',
      () {
        blocTest<TimerBloc, TimerState>(
          'puts timer in progress state',
          build: () => TimerBloc(ticker: Ticker()),
          act: (bloc) => bloc.add(TimerStart(duration: 20)),
          expect: () => [TimerInProgress(20)],
        );

        blocTest<TimerBloc, TimerState>(
          'starting a timer when already running does not start a new timer',
          build: () => TimerBloc(ticker: Ticker()),
          act: (bloc) {
            bloc.add(TimerStart(duration: 12));
            bloc.add(TimerStart(duration: 15));
          },
          expect: () => [TimerInProgress(12)],
        );
      },
    );

    group('Timer tick', () {
      blocTest<TimerBloc, TimerState>(
        'changes to a timer in progress with matching duration',
        build: () => TimerBloc(ticker: Ticker()),
        act: (bloc) {
          bloc.add(TimerTick(duration: 8));
        },
        expect: () => [
          TimerInProgress(8),
        ],
      );
    });

    group('Timer pause', () {
      blocTest<TimerBloc, TimerState>(
        'changes to a timer paused state when state was in progress',
        build: () => TimerBloc(ticker: Ticker()),
        act: (bloc) {
          bloc.add(TimerTick(duration: 12));
          bloc.add(TimerPause());
        },
        expect: () => [
          TimerInProgress(12),
          TimerPaused(12),
        ],
      );

      blocTest<TimerBloc, TimerState>(
        'does not change state to timer paused if the timer was never in progress',
        build: () => TimerBloc(ticker: Ticker()),
        act: (bloc) {
          bloc.add(TimerPause());
        },
        expect: () => [],
      );

      blocTest<TimerBloc, TimerState>(
        'does not change to a timer paused state when the state is already paused',
        build: () => TimerBloc(ticker: Ticker()),
        act: (bloc) {
          bloc.add(TimerStart(duration: 15));
          bloc.add(TimerPause());
          bloc.add(TimerPause());
        },
        expect: () => [
          TimerInProgress(15),
          TimerPaused(15),
        ],
      );
    });

    group('Timer resume', () {
      blocTest<TimerBloc, TimerState>(
        'does not do anything if the timer has not started',
        build: () => TimerBloc(ticker: Ticker()),
        act: (bloc) {
          bloc.add(TimerResume());
        },
        expect: () => [],
      );

      blocTest<TimerBloc, TimerState>(
        'does not do anything if the timer has not been paused',
        build: () => TimerBloc(ticker: Ticker()),
        act: (bloc) {
          bloc.add(TimerStart(duration: 14));
          bloc.add(TimerResume());
        },
        expect: () => [TimerInProgress(14)],
      );

      blocTest<TimerBloc, TimerState>(
        'changes to timer in progress when timer is restarted from paused',
        build: () => TimerBloc(ticker: Ticker()),
        act: (bloc) {
          bloc.add(TimerStart(duration: 12));
          bloc.add(TimerPause());
          bloc.add(TimerResume());
        },
        expect: () => [
          TimerInProgress(12),
          TimerPaused(12),
          TimerInProgress(12),
        ],
      );
    });

    group('Timer reset', () {
      blocTest<TimerBloc, TimerState>(
        'changes to a timer initial state',
        build: () => TimerBloc(ticker: Ticker()),
        act: (bloc) {
          bloc.add(TimerReset());
        },
        expect: () => [
          TimerInitial(15),
        ],
      );

      blocTest<TimerBloc, TimerState>(
        'does not repeat a state call if timer reset is called more than once',
        build: () => TimerBloc(ticker: Ticker()),
        act: (bloc) {
          bloc.add(TimerReset());
          bloc.add(TimerReset());
        },
        expect: () => [
          TimerInitial(15),
        ],
      );
    });

    group('Timer complete', () {
      blocTest<TimerBloc, TimerState>(
        'changes to a timer completed state',
        build: () => TimerBloc(ticker: Ticker()),
        act: (bloc) {
          bloc.add(TimerTick(duration: 10));
          bloc.add(TimerComplete());
        },
        expect: () => [
          TimerInProgress(10),
          TimerCompleted(),
        ],
      );

      blocTest<TimerBloc, TimerState>(
        'does not change state if timer has not been started',
        build: () => TimerBloc(ticker: Ticker()),
        act: (bloc) {
          bloc.add(TimerComplete());
        },
        expect: () => [],
      );

      blocTest<TimerBloc, TimerState>(
        'does not send a duplicate completed state if already sent',
        build: () => TimerBloc(ticker: Ticker()),
        act: (bloc) {
          bloc.add(TimerStart(duration: 15));
          bloc.add(TimerComplete());
          bloc.add(TimerComplete());
        },
        expect: () => [
          TimerInProgress(15),
          TimerCompleted(),
        ],
      );
    });
  });

  test('Timer when counting down emits timers in progress', () async {
    final TimerBloc timerBloc = TimerBloc(ticker: Ticker());

    timerBloc.add(TimerStart(duration: 15));
    timerBloc.add(TimerTick(duration: 14));
    timerBloc.add(TimerTick(duration: 13));

    expectLater(
      timerBloc.stream,
      emitsInOrder(
        [
          TimerInProgress(15),
          TimerInProgress(14),
          TimerInProgress(13),
        ],
      ),
    );
  });

  test('Timer when at zero emits timer completed', () async {
    final TimerBloc timerBloc = TimerBloc(ticker: Ticker());

    timerBloc.add(TimerStart(duration: 15));
    timerBloc.add(TimerTick(duration: 0));

    expectLater(
      timerBloc.stream,
      emitsInOrder(
        [
          TimerInProgress(15),
          TimerCompleted(),
        ],
      ),
    );
  });

  group('Equality', () {
    test('Timer blocs are equal', () {
      final Ticker ticker = Ticker();
      final TimerBloc timerBloc = TimerBloc(ticker: ticker);
      final TimerBloc timerBlocTwo = TimerBloc(ticker: ticker);

      expect(timerBloc, timerBlocTwo);
    });
  });
}
