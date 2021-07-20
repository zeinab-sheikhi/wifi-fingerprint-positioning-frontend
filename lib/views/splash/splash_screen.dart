import 'dart:async';
import 'package:access_point/utils/assets_urls.dart' as assets;
import 'package:access_point/utils/color_utils.dart' as colors;
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _boot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.splashBackground,
      body: Center(
        child: Image(
          image: new AssetImage(assets.wifiGif),
        ),
      ),
    );
  }

  _boot(){
    Future.delayed(const Duration(milliseconds: 12000), () {
      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
    });
  }

}
