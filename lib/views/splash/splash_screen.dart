import 'dart:async';

import 'package:access_point/views/home/home_screen.dart';
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
      backgroundColor: Color(0xff252525),
      body: Center(
        child: Image(
          image: new AssetImage('assets/images/wifi.gif'),
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
