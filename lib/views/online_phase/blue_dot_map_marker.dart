import 'package:flutter/material.dart';
import 'package:access_point/utils/color_utils.dart' as colors;

class BlueDotIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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



