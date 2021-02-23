
import 'package:access_point/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wifi',
      theme: new ThemeData(
        primaryColor: Colors.white,
        primaryColorLight: Color.fromRGBO(246, 246, 246, 1),
        primaryColorDark: Colors.black,
        highlightColor: Color.fromRGBO(185, 185, 185, 1),
        primarySwatch: Colors.grey,
        accentColor: Color.fromRGBO(228, 39, 107, 1),
        toggleableActiveColor: Color.fromRGBO(72, 189, 255, 1),
        backgroundColor: Color.fromRGBO(30, 31, 40, 1),
        cardColor: Color.fromRGBO(51, 52, 62, 1),
        unselectedWidgetColor: Color.fromRGBO(176, 176, 176, 0.5),
        hintColor: Color.fromRGBO(176, 176, 176, 0.5),
        textSelectionColor: Color.fromRGBO(176, 176, 176, 0.5),
        textSelectionHandleColor: Color.fromRGBO(176, 176, 176, 0.5),
        disabledColor: Color.fromRGBO(176, 176, 176, 0.5),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: Home()
    );
  }

  static double HEIGHT(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double WIDTH(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double TITLE_FONT() {
    return 15;
  }
  static double LARGE_TITLE_FONT() {
    return 18;
  }
  static double EXTRA_LARGE_TITLE_FONT() {
    return 25;
  }
  static double MAIN_FONT() {
    return 13;
  }
  static double SMALL_FONT() {
    return 11;
  }
  static double VERY_SMALL_FONT() {
    return 9;
  }
}
