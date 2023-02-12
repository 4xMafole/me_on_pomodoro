import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/timer/timer.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerCubit(),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueGrey.shade800.withOpacity(0.9),
              Colors.blueGrey.shade800.withOpacity(0.95),
              Colors.blueGrey.shade800.withOpacity(1),
            ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomLeft,
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: const TimerView(),
      ),
    );
  }
}
