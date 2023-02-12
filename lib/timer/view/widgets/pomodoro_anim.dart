import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/timer/timer.dart';
import 'package:rive/rive.dart' as rive;

class PomodoroAnim extends StatefulWidget {
  const PomodoroAnim({super.key, required this.timerController});
  final CustomTimerController timerController;

  @override
  State<PomodoroAnim> createState() => _PomodoroAnimState();
}

class _PomodoroAnimState extends State<PomodoroAnim> {
  late rive.Artboard? _pomodoro;
  late rive.StateMachineController? _pomodoro1Controller;
  late rive.SMIInput<bool>? _isBreak;

  @override
  void initState() {
    _pomodoro = rive.RuntimeArtboard();
    rootBundle.load('assets/pomodoro.riv').then((data) async {
      final file = rive.RiveFile.import(data);
      final artboard = file.mainArtboard;
      final pomodoro1Controller = rive.StateMachineController.fromArtboard(
        artboard,
        'pomodoro 1',
      );
      if (pomodoro1Controller != null) {
        artboard.addController(pomodoro1Controller);
        _isBreak = pomodoro1Controller.findInput('break');

        setState(() {
          _pomodoro = artboard;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.height / 1.5;
    return BlocListener<TimerCubit, TimerState>(
      listener: (context, state) {
        switch (state.timerBreak) {
          case TimerBreak.long:
            _isBreak!.value = true;
            if (widget.timerController.state.value ==
                CustomTimerState.counting) {}

            break;
          case TimerBreak.short:
            _isBreak!.value = true;
            if (widget.timerController.state.value ==
                CustomTimerState.counting) {}

            break;
          case TimerBreak.pomodoro:
            if (widget.timerController.state.value == CustomTimerState.reset) {
              _isBreak!.value = false;
            }

            break;
        }
      },
      child: _pomodoro != null
          ? SizedBox(
              height: width,
              child: rive.Rive(
                alignment: Alignment.center,
                artboard: _pomodoro!,
              ),
            )
          : const SizedBox(),
    );
  }
}
