// ignore: import_of_legacy_library_into_null_safe
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CircularTimer extends StatelessWidget {

  double width;
  double height;
  int duration;
  CountDownController controller;
  Function startTimer;
  Function completeTimer;


  CircularTimer({
    required this.width,
    required this.height,
    required this.duration,
    required this.controller,
    required this.startTimer,
    required this.completeTimer
  });

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      onStart: () {
        startTimer();
      },
      onComplete: () {
        completeTimer();
      },
      duration: duration,
      initialDuration: 0,
      controller: controller,
      width: width,
      height: height,
      ringColor: Color(0xff33406b),
      ringGradient: LinearGradient(
        colors: [ Color(0xff95859b), Color(0xff60cbda)]
      ),
      fillColor: Color(0xffad6075),
      fillGradient: null,
      backgroundColor: Color(0xff030712),
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: TextStyle(
          fontSize: 60.0, color: Colors.white, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.S,
      isReverse: false,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: false,
    );
  }
}
