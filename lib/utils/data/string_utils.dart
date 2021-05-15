import 'dart:core';

import 'dart:ui';

class StringUtils{

  StringUtils._();

  // D, the interval time between access point scans
  static const int parameterD = 1;
  // T, the total scanning time
  static const int parameterT = 2;
  // x, the amount of (maximum) values before averaging
  static const int parameterX = 3;

  static final Map<String, String> headers = {"Content-type": "application/json"};
  static const double cardRadius =20;

  ///Constant colors
  static const Color excellentSignal = Color(0xff00cd76);
  static const Color goodSignal = Color(0xff108FFF);
  static const Color fairSignal = Color(0xfff0c545);
  static const Color weakSignal = Color(0xffEA333C);
}