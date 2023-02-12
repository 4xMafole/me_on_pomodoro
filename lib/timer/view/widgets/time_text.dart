import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/timer/timer.dart';

class TimerText extends StatefulWidget {
  const TimerText({
    super.key,
  });

  @override
  State<TimerText> createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText>
    with SingleTickerProviderStateMixin {
  late CustomTimerController _timerController;
  @override
  void initState() {
    _timerController = CustomTimerController(
      vsync: this,
      begin: Duration(minutes: context.read<TimerCubit>().state.time),
      end: Duration.zero,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        _timerController
          ..begin = Duration(minutes: state.time)
          ..reset();
        return CustomTimer(
          controller: _timerController,
          builder: (state, time) {
            return GestureDetector(
              onTap: () =>
                  _timerController.state.value == CustomTimerState.counting
                      ? _timerController.pause()
                      : _timerController.start(),
              onDoubleTap: _timerController.reset,
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
