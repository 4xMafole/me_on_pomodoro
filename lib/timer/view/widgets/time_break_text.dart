import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/timer/timer.dart';

class TimerBreakText extends StatelessWidget {
  const TimerBreakText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<TimerCubit>().timerBreak(),
      child: BlocBuilder<TimerCubit, TimerState>(
        builder: (context, state) {
          return AnimatedCrossFade(
            firstChild: Text(
              'pomodoro ${state.time} mins',
              key: const Key('pomodoro_cross_fade_text'),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            secondChild: state.timerBreak == TimerBreak.short
                ? Text(
                    'short break ${state.time} mins',
                    key: const Key('shortBreak_cross_fade_text'),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'long break ${state.time} mins',
                    key: const Key('longBreak_cross_fade_text'),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
            crossFadeState: state.timerBreak == TimerBreak.pomodoro
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 400),
          );
        },
      ),
    );
  }
}
