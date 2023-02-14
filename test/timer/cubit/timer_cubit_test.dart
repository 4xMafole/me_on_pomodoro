import 'package:bloc_test/bloc_test.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro/timer/timer.dart';

void main() {
  group('timerBreak()', () {
    late TimerCubit cubit;
    late CustomTimerController timerController;
    setUpAll(() {
      cubit = TimerCubit();
      timerController = CustomTimerController(
        vsync: const TestVSync(),
        begin: const Duration(minutes: 25),
        end: Duration.zero,
      );
    });

    group('Pomodoro time to a short break', () {
      blocTest<TimerCubit, TimerState>(
        'emits [TimerState] when timerBreak() is added.',
        build: () => cubit,
        act: (bloc) => bloc.timerBreak(timerController: timerController),
        expect: () => const <TimerState>[
          TimerState(
            timerBreak: TimerBreak.short,
            time: 5,
          )
        ],
      );
    });

    tearDown(() => cubit.close());
  });
}
