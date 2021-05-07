import 'dart:core';

class Constants{

  Constants._();

  // D, the interval time between access point scans
  static const int parameterD = 1;
  // T, the total scanning time
  static const int parameterT = 2;
  // x, the amount of (maximum) values before averaging
  static const int parameterX = 3;

  static final Map<String, String> headers = {"Content-type": "application/json"};
  static const double cardRadius =20;

}