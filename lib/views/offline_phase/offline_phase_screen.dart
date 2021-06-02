import 'dart:convert';
import 'dart:ui';
import 'dart:async';

import 'package:access_point/model/access_point.dart';
import 'package:access_point/model/point.dart';
import 'package:access_point/utils/data/preferences_util.dart';
import 'package:access_point/utils/data/helper.dart';
import 'package:access_point/views/offline_phase/offline_phase_circular_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wifi_plugin/wifi_plugin.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import '../../utils/data/string_utils.dart';
import 'offline_phase_text_field.dart';


class OfflinePhase extends StatefulWidget {
  @override
  _OfflinePhaseState createState() => _OfflinePhaseState();
}

class _OfflinePhaseState extends State<OfflinePhase> {

  final CountDownController _controller = CountDownController();

  String _url = '';
  int _duration = 0;
  int _intervalTime = 0;
  int _xValue = 0;
  int _yValue = 0;
  var _sampleTime;
  late Timer _timer;
  bool _isStopped = false;
  List<AccessPoint> _accessPointsList = [];
  Map<dynamic, dynamic> _accessPointsMap = {};

  @override
  void initState() {
    Helper.changeScreenToPortrait();
    _initializeVariables();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _container(height, width);
  }


  Widget _container(double width, double height) {
    return Center(
      child: Container(
        color: Color(0xff030712),
        width: width,
        height: height * 2 / 3  + height / 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: _resetTimer,
              child: CircularTimer(
                  width: width * 2 / 5,
                  height: height * 1 / 3,
                  duration: _duration,
                  controller: _controller,
                  startTimer: _startTimer,
                  completeTimer: _completeTimer),
            ),
            SizedBox(height: height / 20),
            _xCoordinateContainer(width, height),
            SizedBox(height: height / 20),
            _yCoordinateContainer(width, height),
          ],
        ),
      ),
    );
  }

  Widget _xCoordinateContainer(double width, double height) {
    return Container(
      height: height * 1 / 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _minusButton(
              height,
                  (){
                setState(() {
                  _xValue = _subtract(_xValue);
                });
              }),
          CoordinateTextField(text: _xValue.toString(), labelText: 'X'),
          _addButton(
              height,
              (){
                setState(() {
                  _xValue = _plus(_xValue);
                });
              }
              )
        ],
      ),
    );
  }

  Widget _yCoordinateContainer(double width, double height) {
    return Container(
      height: height * 1 / 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _minusButton(
              height,
              (){
                setState(() {
                  _yValue = _subtract(_yValue);
                });
              }),
          CoordinateTextField(text: _yValue.toString(), labelText: 'Y'),
          _addButton(
              height,
              () {
                setState(() {
                  _yValue = _plus(_yValue);
                });
              }
              )
        ],
      ),
    );
  }

  Widget _addButton(double height, Function add) {
    return Container(
      // height: height / 15,
      child: ElevatedButton(
          onPressed: () {add();},
          child: Icon(Icons.add, color: Color(0xff43adb7)),
          style: ElevatedButton.styleFrom(
              primary: Color(0xff030712),
              shape: CircleBorder(),
              side: BorderSide(width: 2.0, color: Color(0xff43adb7))
          )
      ),
    );
  }

  Widget _minusButton(double height, Function subtract) {
    return Container(
      // height: height / 15,
      child: ElevatedButton(
          onPressed: (){subtract();},
          child: Icon(Icons.remove, color: Color(0xff43adb7)),
          style: ElevatedButton.styleFrom(
            primary: Color(0xff030712),
            shape: CircleBorder(),
            side: BorderSide(width: 2.0, color: Color(0xff43adb7))
          )
      ),
    );
  }
  _initializeVariables()  {
    setState(() {
      _url = Helper.getUrl('/fingerprint/api/v1/points');
      _duration = PreferenceUtils.getInt('scanTime', 20);
      _intervalTime = PreferenceUtils.getInt('intervalTime', 1000);
      _sampleTime = Duration(milliseconds: _intervalTime);
    });
  }

  int _plus(int value) {
    return value + 40;
  }

  int _subtract(int value) {
    if( value >= 40)
      return value - 40;
    return value;
  }

  void _collectAccessPoints() async {
    var result = await Wifi.accessPoints;
    setState(() {
      _accessPointsMap = result;
    });
  }

  void _filterData() {

    for(MapEntry mapEntry in _accessPointsMap.entries) {
      String wifiBSSID = mapEntry.key;
      List<int> wifiRSSIList = List.of(mapEntry.value).cast<int>();
      _accessPointsList.add(new AccessPoint(wifiBSSID, wifiRSSIList));
    }
  }

  Future<void> _sendData(List<AccessPoint> accessPointList) async {

    int xCoordinate = _xValue;
    int yCoordinate = _yValue;
    int totalScanTime = _duration;
    int intervalTime = _intervalTime ~/ 1000;
    String dateTime = Helper().getDateTime();
    Point _point = new Point(
        xCoordinate,
        yCoordinate,
        totalScanTime,
        intervalTime,
        dateTime,
        accessPointList);
    String json = jsonEncode(_point);
    Response response = await post(_url, headers:StringUtils.headers, body: json);
    int statusCode = response.statusCode;
    if(statusCode == 200)
      Helper.showToast("AccessPoint added Successfully", context);
  }

  _startTimer() {
    _timer = new Timer.periodic(
      _sampleTime, (Timer timer) {
      if (_isStopped == false) {
        _collectAccessPoints();
        Wifi.requestNewScan(false);
      }
      else
        timer.cancel();
    },
    );
  }
  _completeTimer() {
    _filterData();
    _sendData(_accessPointsList);
    setState(() {
      _resetVariables();
    });
  }

  _resetTimer() {
    setState(() {
      _initializeVariables();
      Wifi.requestNewScan(true);
      _isStopped = false;
      _controller.restart();
    });
  }

  void _resetVariables() {
    _isStopped = true;
    _timer.cancel();
    _accessPointsList = [];
    _accessPointsMap = {};
  }
}