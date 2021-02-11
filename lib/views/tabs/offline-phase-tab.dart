import 'dart:convert';
import 'dart:ui';

import 'package:access_point/main.dart';
import 'package:access_point/model/accesspoint.dart';
import 'package:access_point/model/point.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wifi/wifi.dart';


class OfflinePhaseTab extends StatefulWidget {
  @override
  _OfflinePhaseTabState createState() => _OfflinePhaseTabState();
}

class _OfflinePhaseTabState extends State<OfflinePhaseTab> {

  final xCoordinateController = TextEditingController();
  final yCoordinateController = TextEditingController();
  final String url = 'http://192.168.1.4:3005/v1/accesspoint/add';
  final Map<String, String> headers = {"Content-type": "application/json"};
  List<WifiResult> scanResultList = [];

  @override
  void initState() {
    super.initState();
    loadAccessPoints();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter X Coordinate'),
              keyboardType: TextInputType.number,
              controller: xCoordinateController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter Y Coordinate'),
              keyboardType: TextInputType.number,
              controller: yCoordinateController,
            ),
          ),
          FlatButton(
            onPressed: () {collectAccessPoints();},
            child: Text(
              'Collect',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MyApp.EXTRA_LARGE_TITLE_FONT()),
            ),
            color: Colors.orangeAccent,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.deepOrange)),
          ),
        ],
      ),
    );
  }
  void loadAccessPoints() async {
    Wifi.list('').then((list) {
      setState(() {
        scanResultList = list;
      });
    });
  }

  void collectAccessPoints() async {
    List<int> rssiList = [];
    List<AccessPoint> accessPoints = [];
    int x = int.parse(xCoordinateController.text);
    int y = int.parse(yCoordinateController.text);

    for(WifiResult wifiResult in scanResultList) {
      for(int i = 0; i < 100 ; i++) {
        rssiList.add(wifiResult.level);
      }
      AccessPoint _accessPoint =  new AccessPoint(wifiResult.ssid, rssiList);
      accessPoints.add(_accessPoint);
      rssiList = [];
    }
    Point _point = new Point(x, y, accessPoints);
    String json = jsonEncode(_point);
    print(json);
    Response response = await post(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    String body = response.body;

    print(statusCode);
    print(body);
  }
}
