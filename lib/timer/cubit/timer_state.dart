part of 'timer_cubit.dart';

enum TimerBreak {
  long,
  short,
  pomodoro,
}

class TimerState extends Equatable {
  const TimerState({
    this.timerState = CustomTimerState.reset,
    this.timerBreak = TimerBreak.pomodoro,
    this.time = 25,
  });

  final CustomTimerState timerState;
  final TimerBreak timerBreak;
  final int time;

  TimerState copyWith({
    CustomTimerState? timerState,
    TimerBreak? timerBreak,
    int? time,
  }) {
    return TimerState(
      timerState: timerState ?? this.timerState,
      timerBreak: timerBreak ?? this.timerBreak,
      time: time ?? this.time,
    );
  }

  @override
  List<Object?> get props => [timerState, timerBreak, time];
}
