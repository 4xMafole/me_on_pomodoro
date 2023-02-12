import 'package:flutter/material.dart';
import 'package:pomodoro/timer/view/widgets/widgets.dart';

class TimerView extends StatelessWidget {
  const TimerView({
    super.key,
  });

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
                const PomodoroAnim(),
                SizedBox(
                  height: size.height * (2.4 / 100),
                ),
                const TimerText(),
                SizedBox(
                  height: size.height * (2 / 100),
                ),
                const TimerBreakText(
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
