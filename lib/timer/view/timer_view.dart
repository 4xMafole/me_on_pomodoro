import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/timer/timer.dart';
import 'package:pomodoro/timer/view/widgets/widgets.dart';

class TimerView extends StatefulWidget {
  const TimerView({
    super.key,
  });

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView>
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
    final size = MediaQuery.of(context).size;
    // final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PomodoroAnim(timerController: _timerController),
                SizedBox(
                  height: size.height * (2.4 / 100),
                ),
                TimerText(controller: _timerController),
                SizedBox(
                  height: size.height * (2 / 100),
                ),
                TimerBreakText(
                  key: const Key('timerBreak_text'),
                  timerController: _timerController,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
