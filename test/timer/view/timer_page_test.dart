import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro/app/app.dart';
import 'package:pomodoro/timer/timer.dart';
import 'package:pomodoro/timer/view/widgets/pomodoro_anim.dart';
import 'package:pomodoro/timer/view/widgets/time_break_text.dart';
import 'package:pomodoro/timer/view/widgets/time_text.dart';

void main() {
  group(
    'Timer',
    () {
      testWidgets(
        'renders TimerView',
        (tester) async {
          // Builds the app and trigger a frame
          await tester.pumpWidget(const App());

          // Verifies the presents of the widgets
          expect(
            find.bySubtype<TimerView>(),
            findsOneWidget,
          );
          expect(find.bySubtype<PomodoroAnim>(), findsOneWidget);
          expect(find.bySubtype<TimerText>(), findsOneWidget);
          expect(find.bySubtype<TimerBreakText>(), findsOneWidget);
        },
      );

      testWidgets(
        'toggles time breaks(pomodoro, short-break an long-break)',
        (tester) async {
          //Builds the app and trigger a frame.
          await tester.pumpWidget(const App());

          // Verifies only pomodoro and long texts show.
          expect(
            find.byKey(const Key('pomodoro_cross_fade_text')),
            findsOneWidget,
          );
          expect(
            find.byKey(const Key('shortBreak_cross_fade_text')),
            findsNothing,
          );
          expect(
            find.byKey(const Key('longBreak_cross_fade_text')),
            findsOneWidget,
          );

          // Tap a timerBreak widget and trigger a frame.
          await tester.tap(find.byKey(const Key('timerBreak_text')));
          await tester.pump();

          // Verifies only pomodoro and short-break texts show.
          expect(
            find.byKey(const Key('pomodoro_cross_fade_text')),
            findsOneWidget,
          );
          expect(
            find.byKey(const Key('shortBreak_cross_fade_text')),
            findsOneWidget,
          );
          expect(
            find.byKey(const Key('longBreak_cross_fade_text')),
            findsNothing,
          );
        },
      );
    },
  );
}
