import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/timer/timer.dart';

class TimerText extends StatelessWidget {
  const TimerText({
    super.key,
    required this.controller,
  });

  final CustomTimerController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        controller
          ..begin = Duration(minutes: state.time)
          ..reset();
        return CustomTimer(
          controller: controller,
          builder: (state, time) {
            return GestureDetector(
              onTap: () => controller.state.value == CustomTimerState.counting
                  ? controller.pause()
                  : controller.start(),
              onDoubleTap: controller.reset,
              child: Text(
                '${time.minutes}:${time.seconds}',
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
