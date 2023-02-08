import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/l10n/l10n.dart';
import 'package:pomodoro/timer/timer.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage>
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
    return CounterView(
      timerController: _timerController,
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({
    super.key,
    required CustomTimerController timerController,
  }) : _timerController = timerController;

  final CustomTimerController _timerController;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerText(timerController: _timerController),
            const SizedBox(
              height: 24,
            ),
            const TimerBreakText(),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _timerController.reset,
            child: const Text('reset'),
          ),
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({
    super.key,
    required CustomTimerController timerController,
  }) : _timerController = timerController;

  final CustomTimerController _timerController;

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
              child: Text(
                '${time.minutes}:${time.seconds}',
                style: theme.textTheme.headlineMedium,
              ),
            );
          },
        );
      },
    );
  }
}

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
            firstChild: Text('pomodoro ${state.time} mins'),
            secondChild: state.timerBreak == TimerBreak.short
                ? Text('break ${state.time} mins')
                : Text('long ${state.time} mins'),
            crossFadeState: state.timerBreak == TimerBreak.pomodoro
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300),
          );
        },
      ),
    );
  }
}
