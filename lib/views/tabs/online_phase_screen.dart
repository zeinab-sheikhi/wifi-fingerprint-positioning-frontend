import 'package:access_point/views/tabs/chart.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class OnLinePhaseTab extends StatefulWidget {
  @override
  _OnLinePhaseTabState createState() => _OnLinePhaseTabState();
}

class _OnLinePhaseTabState extends State<OnLinePhaseTab> {

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
            child: Container(
                child: ChartPage(),
            )));
  }
}
