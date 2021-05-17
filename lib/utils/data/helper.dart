import 'package:access_point/utils/data/string_utils.dart';
import 'package:access_point/utils/data/preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;


class Helper {

  // /// Sort List in Ascending Order
  // List<int> sortList(List<int> list) {
  //
  //   list.sort((b, a) => a.compareTo(b));
  //   return list;
  // }
  //
  // double calculateAverage(List<int> list) {
  //   var average = list.reduce((a,b) => a + b) / list.length;
  //   return average;
  // }
  //
  // double calculateStandardDeviation(List<int> list, double average, int length) {
  //
  //   num sumOfSquaredDiffFromMean = 0;
  //   for (var value in list) {
  //     var squareDiffFromMean = math.pow(value - average, 2);
  //     sumOfSquaredDiffFromMean += squareDiffFromMean;
  //   }
  //   var variance = sumOfSquaredDiffFromMean / length;
  //   var standardDeviation = math.sqrt(variance);
  //   return standardDeviation;
  // }

  String getDateTime() {
    var dt = DateTime.now();
    String newDt = DateFormat.yMMMMd().add_jms().format(dt);
    return newDt;
  }

  static String getChannel(String frequency) {

    int freq = int.parse(frequency);
    if( freq > 2000 && freq < 3000)
      return 2.4.toString();
    else
      return 5.toString();
  }

  static String getUrl(String path) {
    String ipAddress = PreferenceUtils.getString('ipAddress', '192.168.1.5');
    String port = PreferenceUtils.getString('port', '5000');
    String url = 'http://' + ipAddress + ':' + port + path;
    return url;
  }

  static showToast(String toastMessage, BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content:  Text(toastMessage),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffoldMessenger.hideCurrentSnackBar),
      ),
    );
  }

  static Color backgroundColorBasedOnLevel(int level) {

    if (level > -50)
      return Color(0xffc5fded);
    else if(level <= -50 && level > -60)
      return Color(0xffDDEFFF);
    else if(level <= -60 && level > -70)
      return Color(0xffFCF7CD);
    else
      return Color(0xffF8BABD);
  }

  static Color progressColorBasedOnLevel(int level) {
    if (level > -50)
      return StringUtils.excellentSignal;
    else if(level <= -50 && level > -60)
      return StringUtils.goodSignal;
    else if(level <= -60 && level > -70)
      return StringUtils.fairSignal;
    else
      return StringUtils.weakSignal;
  }

  ///convert rssi value in dBm to an integer between 0 and 100
  static int levelToProgress(int level) {
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


}