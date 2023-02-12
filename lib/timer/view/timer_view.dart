import 'package:flutter/material.dart';
import 'package:pomodoro/timer/view/widgets/widgets.dart';

class TimerView extends StatelessWidget {
  const TimerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                PomodoroAnim(),
                SizedBox(
                  height: 24,
                ),
                TimerText(),
                SizedBox(
                  height: 20,
                ),
                TimerBreakText(
                  key: Key('timerBreak_text'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
