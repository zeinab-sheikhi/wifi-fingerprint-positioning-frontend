import 'package:access_point/utils/constants.dart';
import 'package:access_point/utils/preferences_util.dart';
import 'package:flutter/material.dart';

class Util {

  List<int> makeList(List<int> rssiList, int numOfItems) {

    List<int> modifiedList = [];
    //sort list in ascending order
    rssiList.sort((b, a) => a.compareTo(b));
    //make sublist which has numOfItems items
    modifiedList = rssiList.sublist(0, numOfItems + 1);
    return modifiedList;
  }

  int calculateMean(List<int> list) {
    var mean = list.reduce((a,b) => a + b) ~/ list.length;
    return mean;
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
      return Constants.excellentSignal;
    else if(level <= -50 && level > -60)
      return Constants.goodSignal;
    else if(level <= -60 && level > -70)
      return Constants.fairSignal;
    else
      return Constants.weakSignal;
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