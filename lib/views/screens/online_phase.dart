import 'package:access_point/utils/data/helper.dart';
import 'package:access_point/views/offline_phase/offline_phase_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OnLinePhase extends StatefulWidget {
  @override
  _OnLinePhaseState createState() => _OnLinePhaseState();
}

class _OnLinePhaseState extends State<OnLinePhase> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xff030712),
      body: Center(
        child: Container(
          height: height / 2,
          width: width,
          margin: EdgeInsets.symmetric(horizontal: width / 10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff242c42),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: width / 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CoordinateTextField(text: '9070', labelText: 'C: ',)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
