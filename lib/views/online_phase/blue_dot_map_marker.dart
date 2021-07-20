import 'package:flutter/material.dart';
import 'package:access_point/utils/color_utils.dart' as colors;

class BlueDotIcon extends StatefulWidget {
  @override
  _BlueDotIconState createState() => _BlueDotIconState();
}

class _BlueDotIconState extends State<BlueDotIcon> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _glowingContainer(width, height);
  }

  Widget _glowingContainer(double width, double height) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.mapMarker,
          boxShadow: [
            BoxShadow(
              color: colors.mapMarkerShadow,
              blurRadius: 3,
              spreadRadius: 4
          )]
      ),
    );
  }
}



