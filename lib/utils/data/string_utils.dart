import 'dart:core';

import 'dart:ui';

import 'package:flutter/material.dart';

class StringUtils{

  StringUtils._();

  static const String offlinePhaseTitle = "OffLine Phase";
  static const String offlinePhaseDescription = "Add reference point's coordinate by putting map marker in desired tile";
  static const String onlinePhaseTitle = "OnLine Phase";
  static const String onlinePhaseDescription = "Get tile's position and coordinate by pressing locate button";
  static const String wifiScannerTitle = "WiFi Scanner";
  static const String wifiScannerDescription = "Show list of nearby access points with their features";
  static const String helpTitle = "Help";
  static const String settingsTitle = "Settings";
  static const String wifiTitle = "Wi-Fi";
  static const String serverTitle = "Server";
  static const String classificationModelTitle = "Classification Model";
  static const String regressionModelTitle = "Regression Model";


  // D, the interval time between access point scans
  static const int parameterD = 1;
  // T, the total scanning time
  static const int parameterT = 2;

  static final Map<String, String> headers = {"Content-type": "application/json"};

  ///Constant colors
  static const Color excellentSignal = Color(0xff00cd76);
  static const Color goodSignal = Color(0xff108FFF);
  static const Color fairSignal = Color(0xfff0c545);
  static const Color weakSignal = Color(0xffEA333C);
}