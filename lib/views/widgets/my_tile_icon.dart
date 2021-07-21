import 'package:flutter/material.dart';
import 'package:access_point/utils/color_utils.dart' as colors;

class TileLeadingIcon extends StatelessWidget {
  IconData iconData;
  TileLeadingIcon({required this.iconData});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
      return Icon(
          iconData,
          size: width / 12,
          color: colors.accentColor
      );
  }
}
