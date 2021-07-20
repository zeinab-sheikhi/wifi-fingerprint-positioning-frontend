import 'package:flutter/material.dart';
import 'package:access_point/utils/assets_urls.dart' as assets;

class MapMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _pinIconContainer(width, height);
  }
}

Widget _pinIconContainer(double width, double height) {
  return Container(
    alignment: Alignment.center,
    child: Image.asset(
        assets.mapMarker,
        height: height / 8,
        fit: BoxFit.fitWidth,
      ),
  );
}

