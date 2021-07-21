import 'package:access_point/utils/color_utils.dart' as colors;
import 'package:access_point/utils/string_utils.dart' as strings;
import 'package:access_point/utils/preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

  String getDateTime() {
    var dt = DateTime.now();
    String newDt = DateFormat('yyyy-MM-dd hh:mm:ss').format(dt);
    return newDt;
  }

  String getChannel(String frequency) {
    int freq = int.parse(frequency);
    if(freq > 2000 && freq < 3000)
      return 2.4.toString();
    else
      return 5.toString();
  }

  String getUrl(String path) {
    String ipAddress = PreferenceUtils.getString(strings.ipAddress, strings.defaultIpAddress);
    String port = PreferenceUtils.getString(strings.port, strings.defaultPort);
    String url = 'http://' + ipAddress + ':' + port + path;
    return url;
  }

  changeScreenToPortrait() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  changeScreenToLandscape() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
  }

  double getPosition(int number) {
    double dy = PreferenceUtils.getDouble('tile${number}Y', 1);
    return dy;
  }

  /// Convert rssi value in dBm to an integer between 0 and 100
  int levelToProgress(int level) {
    if(level > -30 && level <= -20)
      return 100;
    else if(level > -40 && level <= -30)
      return 90;
    else if(level > -50 && level <= -40)
      return 80;
    else if(level > -55 && level <= -50)
      return 70;
    else if(level > -60 && level <= -55)
      return 60;
    else if(level > -65 && level <= -60)
      return 50;
    else if(level > -70 && level <= -65)
      return 40;
    else if(level > -80 && level <= -70)
      return 30;
    else if(level > -90 && level <= -80)
      return 20;
    else
      return 10;
  }

  Color backgroundColorBasedOnLevel(int level) {
    if (level > -50)
      return colors.excellentSignalLight;
    else if(level <= -50 && level > -60)
      return colors.goodSignalLight;
    else if(level <= -60 && level > -70)
      return colors.fairSignalLight;
    else
      return colors.weakSignalLight;
  }

  Color progressColorBasedOnLevel(int level) {
    if (level > -50)
      return colors.excellentSignal;
    else if(level <= -50 && level > -60)
      return colors.goodSignal;
    else if(level <= -60 && level > -70)
      return colors.fairSignal;
    else
      return colors.weakSignal;
  }
