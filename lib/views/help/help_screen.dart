import 'package:access_point/utils/assets_urls.dart' as assets;
import 'package:access_point/utils/string_utils.dart' as strings;
import 'package:access_point/utils/color_utils.dart' as colors;
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
      colorDot: colors.dotColor,
      colorActiveDot: colors.activeDotColor,
    );
  }

  _initSlides() {
    slides.add(
        _createSlide(
            strings.offlinePhase,
            strings.offlinePhaseDescription,
            assets.addLocation
        ));
    slides.add(
        _createSlide(
            strings.onlinePhase,
            strings.onlinePhaseDescription,
            assets.currentLocation
        ));
    slides.add(
        _createSlide(
            strings.wifiScanner,
            strings.wifiScannerDescription,
            assets.scanWiFi
        ));
  }

  Slide _createSlide(String title, String description, String imagePath) {
    return Slide(
      title: title,
      styleTitle: TextStyle(color: colors.textColor, fontSize: 30, fontWeight: FontWeight.bold),
      pathImage: imagePath,
      description: description,
      styleDescription: TextStyle(color: colors.descriptionText, fontSize: 18),
      backgroundColor: colors.primaryColor
    );

  }
}
