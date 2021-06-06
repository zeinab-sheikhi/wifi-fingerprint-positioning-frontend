import 'package:access_point/utils/data/string_utils.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intro_slider/intro_slider.dart';

class HelpScreen extends StatefulWidget {

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    _initSlides();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return IntroSlider(
        slides: slides,
      isShowSkipBtn: false,
      colorDot: Color(0xffdfdfdf),
      colorActiveDot: Color(0xff1bb581),
    );
  }

  _initSlides() {
    slides.add(
        _createSlides(
            StringUtils.offlinePhaseTitle,
            StringUtils.offlinePhaseDescription,
            "assets/images/add_location.jpg"
        ));
    slides.add(
        _createSlides(
            StringUtils.onlinePhaseTitle,
            StringUtils.onlinePhaseDescription,
            "assets/images/current_location.png"
        ));
    slides.add(
        _createSlides(
            StringUtils.wifiScannerTitle,
            StringUtils.wifiScannerDescription,
            "assets/images/scan_wifi.png"
        ));
  }

  Slide _createSlides(String title, String description, String imagePath) {
    return Slide(
      title: title,
      styleTitle: TextStyle(color: Color(0xff5c6870), fontSize: 30, fontWeight: FontWeight.bold),
      pathImage: imagePath,
      description: description,
      styleDescription: TextStyle(color: Color(0xff5c6870), fontSize: 18),
      backgroundColor: Colors.white
    );

  }
}
