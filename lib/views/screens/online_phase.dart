
import 'package:flutter/material.dart';


class OnLinePhase extends StatefulWidget {
  @override
  _OnLinePhaseState createState() => _OnLinePhaseState();
}

class _OnLinePhaseState extends State<OnLinePhase> {

  String xPosition = 'x';
  String yPosition = 'y';
  double accuracy = 0.0;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
        backgroundColor: Color(0xff030712),
        body: Center(

          ),
    );
  }


}
