import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart' as rive;

class PomodoroAnim extends StatefulWidget {
  const PomodoroAnim({super.key});

  @override
  State<PomodoroAnim> createState() => _PomodoroAnimState();
}

class _PomodoroAnimState extends State<PomodoroAnim> {
  late rive.Artboard? _pomodoro;
  // late rive.StateMachineController? _pomodoro1Controller;
  // late rive.SMIInput<bool>? _isBreak;

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
        // _isBreak = pomodoro1Controller.findInput('break');

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
    // return const Placeholder();
    return _pomodoro != null
        ? SizedBox(
            height: width,
            child: rive.Rive(
              alignment: Alignment.center,
              artboard: _pomodoro!,
            ),
          )
        : const SizedBox();
  }
}
