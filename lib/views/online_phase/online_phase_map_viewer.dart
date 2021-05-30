import 'package:access_point/views/online_phase/online_phase_screen.dart';
import 'package:flutter/material.dart';

class OnlinePhaseMap extends StatefulWidget {

  @override
  _OnlinePhaseMapState createState() => _OnlinePhaseMapState();
}

class _OnlinePhaseMapState extends State<OnlinePhaseMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: OnlinePhase(),
    );
  }
}
