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


}