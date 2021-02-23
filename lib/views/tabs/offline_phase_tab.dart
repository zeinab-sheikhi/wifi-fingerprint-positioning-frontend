import 'dart:convert';
import 'dart:ui';
import 'dart:async';


import 'package:access_point/main.dart';
import 'package:access_point/model/access_point.dart';
import 'package:access_point/model/point.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wifi/wifi.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';



class OfflinePhaseTab extends StatefulWidget {
  @override
  _OfflinePhaseTabState createState() => _OfflinePhaseTabState();
}

class _OfflinePhaseTabState extends State<OfflinePhaseTab> {

  final xCoordinateController = TextEditingController();
  final yCoordinateController = TextEditingController();
  final String url = 'http://192.168.1.2:3005/v1/accesspoint/add';
  final Map<String, String> headers = {"Content-type": "application/json"};
  List<int> rssiValues = [];
  CountDownController _controller = CountDownController();
  final sampleTime = Duration(milliseconds: 100);
  int _duration = 20;
  Timer _timer;
  bool isStopped; //global
  int sum = 0;
  String wifiSSID = "";
  int level = 0;
  int average = 0;
  List<WifiResult> scanResultList = [];

  @override
  void initState() {
    super.initState();
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
            onPressed: () {resetTimer();},
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CircularCountDownTimer(
              onStart: () {
                print('Start Called');
                startTimer();
              },
              onComplete: () {
                setState(() {
                  isStopped = true;
                  _timer.cancel();
                  collectAccessPoints();
                });
                print('Finish Called');
              },
              duration: _duration,
              initialDuration: 0,
              controller: _controller,
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height / 4,
              ringColor: Colors.grey[300],
              ringGradient: null,
              fillColor: Colors.purpleAccent[100],
              fillGradient: null,
              backgroundColor: Colors.purple[500],
              backgroundGradient: null,
              strokeWidth: 20.0,
              strokeCap: StrokeCap.round,
              textStyle: TextStyle(
                  fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
              textFormat: CountdownTextFormat.S,
              isReverse: false,
              isReverseAnimation: false,
              isTimerTextShown: true,
              autoStart: false,
            ),
          ),
          Table(
            children: [
              TableRow(children: [Text('SSID'), Text('Current RSSI'), Text('Avergae RSSI')]),
              TableRow(children: [Text('$wifiSSID'), Text('$level'), Text('$average')]),
            ],
          ),
        ],
      ),
    );
  }

  void collectAccessPoints() async {

    List<AccessPoint> accessPoints = [];

    int x = int.parse(xCoordinateController.text);
    int y = int.parse(yCoordinateController.text);
    String ssid = await Wifi.bssid;

    for(int i in rssiValues) {
      sum = sum + i;
    }
    average = sum ~/ rssiValues.length;

    AccessPoint _accessPoint =  new AccessPoint(ssid, average);
    accessPoints.add(_accessPoint);


    Point _point = new Point(x, y, accessPoints);
    String json = jsonEncode(_point);
    print(json);
    Response response = await post(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    String body = response.body;

    print(statusCode);
    print(body);
    print(rssiValues.length);
  }
  void startTimer() {
    _timer = new Timer.periodic(
      sampleTime, (Timer timer)
    {
      if(isStopped == false)
        collectBSSID();
      else
        timer.cancel();
    },
    );
  }
  void resetTimer() {
    setState(() {
      isStopped = false;
      rssiValues.clear();
      sum = 0;
      _controller.restart();
    });
  }

  void collectBSSID() async {

     level = await Wifi.level;
     wifiSSID = await Wifi.ssid;
    rssiValues.add(level);
  }
}
