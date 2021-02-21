
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
        primarySwatch: Colors.blue,
        primaryColorDark:Colors.black ,
        primaryColor:Colors.white ,
        primaryColorLight: Color.fromRGBO(130, 130, 130, 1),
        accentColor: Color.fromRGBO(0, 167, 157, 1),
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        textSelectionColor: Color.fromRGBO(224, 224, 224, 1).withOpacity(0.5),
        textSelectionHandleColor: Color.fromRGBO(160, 160, 160, 1),
        cardColor: Color.fromRGBO(54, 54, 54, 1),
        disabledColor:  Color.fromRGBO(108, 108, 108, 1),
        unselectedWidgetColor: Colors.grey,
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
