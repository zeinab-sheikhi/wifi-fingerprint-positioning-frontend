import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FloorMap extends StatefulWidget {

  @override
  _FloorMapState createState() => _FloorMapState();
}

class _FloorMapState extends State<FloorMap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Center(
        child: InteractiveViewer(
          panEnabled: false,
          alignPanAxis: false,
          minScale: 1,
          maxScale: 2,
          child: Image.asset(
            'assets/images/floor1.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
