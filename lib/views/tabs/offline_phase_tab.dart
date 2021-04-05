import 'dart:convert';
import 'dart:ui';
import 'dart:async';


import 'package:access_point/main.dart';
import 'package:access_point/model/access_point.dart';
import 'package:access_point/model/point.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wifi_scan_plugin/wifi_scan_plugin.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:circular_countdown_timer/circular_countdown_timer.dart';



class OfflinePhaseTab extends StatefulWidget {
  @override
  _OfflinePhaseTabState createState() => _OfflinePhaseTabState();
}

class _OfflinePhaseTabState extends State<OfflinePhaseTab> {

  final pointCoordinateController = TextEditingController();
  final String url = 'http://192.168.1.4:3005/v1/accesspoint/add';
  final Map<String, String> headers = {"Content-type": "application/json"};
  CountDownController _controller = CountDownController();
  final sampleTime = Duration(milliseconds: 1000);
  int _duration = 20;
  late Timer _timer;
  late bool isStopped; //global
  var accessPoints;
  List<AccessPoint> accessPointsList = [];
  var accessPointMap = <dynamic, List<dynamic>>{};

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
                  border: InputBorder.none, hintText: 'Enter Point Coordinate'),
              keyboardType: TextInputType.text,
              controller: pointCoordinateController,
            ),
          ),

          ElevatedButton(
            onPressed: () {resetTimer();},
            child: Text(
              'Collect',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MyApp.EXTRA_LARGE_TITLE_FONT()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CircularCountDownTimer(
              onStart: () {
                startTimer();
              },
              onComplete: () {
                completeAction();
                postToServer(accessPointsList);
                setState(() {
                  isStopped = true;
                  _timer.cancel();
                  accessPoints = {};
                  accessPointsList = [];
                  accessPointMap = {};
                });
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
        ],
      ),
    );
  }

  void collectAccessPoints() async {

    accessPoints = await Wifi.accessPoints;
    accessPoints.forEach(
            (accessPointSSID, accessPointRSSIValues) {
                accessPointMap.update(accessPointSSID,
                        (value) => accessPointRSSIValues,
                    ifAbsent: () => accessPointRSSIValues);
    });
  }
  void completeAction() {
    accessPointsList = accessPointMap.entries.map((entry) => AccessPoint(entry.key, entry.value)).toList();
  }

  Future<void> postToServer(List<AccessPoint> accessPointList) async {
    String pointCoordinate = pointCoordinateController.text.toString();
    Point _point = new Point(pointCoordinate, accessPointList);
    String json = jsonEncode(_point);
    print(json);
    Response response = await post(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    String body = response.body;
  }
  void startTimer() {
    _timer = new Timer.periodic(
      sampleTime, (Timer timer)
    {
      if(isStopped == false) {
        collectAccessPoints();
        Wifi.requestNewScan(false);
      }
      else
        timer.cancel();
    },
    );
  }
  void resetTimer() {
    setState(() {
      Wifi.requestNewScan(true);
      isStopped = false;
      _controller.restart();
    });
  }
}
