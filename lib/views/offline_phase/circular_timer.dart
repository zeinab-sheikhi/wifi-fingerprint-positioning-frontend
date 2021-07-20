import 'package:access_point/utils/color_utils.dart' as colors;
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
      ringColor: colors.timerRingColor,
      ringGradient: LinearGradient(
        colors: [ colors.timerRingGradient1, colors.timerRingGradient2]
      ),
      fillColor: colors.timerFill,
      fillGradient: null,
      backgroundColor: colors.backgroundColor,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: TextStyle(
          fontSize: 40.0, color: colors.primaryColor, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.S,
      isReverse: false,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: false,
    );
  }
}
