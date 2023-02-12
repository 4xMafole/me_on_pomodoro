import 'package:bloc/bloc.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:equatable/equatable.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(const TimerState());

  void timerBreak() {
    if (state.timerBreak == TimerBreak.pomodoro) {
      emit(
        state.copyWith(
          timerBreak: TimerBreak.short,
          time: 5,
        ),
      );
    } else if (state.timerBreak == TimerBreak.short) {
      emit(
        state.copyWith(
          timerBreak: TimerBreak.long,
          time: 15,
        ),
      );
    } else {
      emit(
        state.copyWith(
          timerBreak: TimerBreak.pomodoro,
          time: 25,
        ),
      );
    }
  }
}
