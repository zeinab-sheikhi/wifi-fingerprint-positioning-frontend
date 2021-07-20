import 'dart:async';

import 'package:access_point/api/api.dart';
import 'package:access_point/api/api_result.dart';
import 'package:access_point/models/point.dart';
import 'package:access_point/utils/preferences_util.dart';
import 'package:access_point/utils/helper.dart' as helper;
import 'package:access_point/utils/string_utils.dart' as strings;
import 'package:access_point/utils/color_utils.dart' as colors;
import 'package:access_point/views/offline_phase/circular_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wifi_plugin/wifi_plugin.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'text_field.dart';


class OfflinePhase extends StatefulWidget {
  @override
  _OfflinePhaseState createState() => _OfflinePhaseState();
}

class _OfflinePhaseState extends State<OfflinePhase> {

  final CountDownController _controller = CountDownController();

  int _duration = 0;
  int _intervalTime = 0;
  int _xValue = 0;
  int _yValue = 0;
  int index = 0;
  var _sampleTime;
  late Timer _timer;
  bool _isStopped = false;
  List<AccessPoint> _accessPointsList = [];
  Map<dynamic, dynamic> _accessPointsMap = {};

  @override
  void initState() {
    helper.changeScreenToPortrait();
    _initializeVariables();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _body(height, width);
  }

  Widget _body(double width, double height) {
    return Center(
      child: Container(
        color: colors.backgroundColor,
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
          CoordinateTextField(text: _xValue.toString(), labelText: strings.x),
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
          CoordinateTextField(text: _yValue.toString(), labelText: strings.y),
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
          onPressed: ()=> add(),
          child: Icon(Icons.add, color: colors.accentDarkColor),
          style: ElevatedButton.styleFrom(
              primary: colors.backgroundColor,
              shape: CircleBorder(),
              side: BorderSide(width: 2.0, color: colors.accentDarkColor)
          )
      ),
    );
  }

  Widget _minusButton(double height, Function subtract) {
    return Container(
      // height: height / 15,
      child: ElevatedButton(
          onPressed: (){subtract();},
          child: Icon(Icons.remove, color: colors.accentDarkColor),
          style: ElevatedButton.styleFrom(
            primary: colors.backgroundColor,
            shape: CircleBorder(),
            side: BorderSide(width: 2.0, color: colors.accentDarkColor)
          )
      ),
    );
  }
  _initializeVariables()  {
    setState(() {
      _duration = PreferenceUtils.getInt(strings.scanTime, 20);
      _intervalTime = PreferenceUtils.getInt(strings.intervalTime, 1000);
      _sampleTime = Duration(milliseconds: _intervalTime);
    });
    Wifi.setRssiListSize(_duration);
  }

  int _plus(int value) {
    return value + 40;
  }

  int _subtract(int value) {
    if(value >= 40)
      return value - 40;
    return value;
  }

  void _collectAccessPoints() async {
    var result = await Wifi.getAccessPoints(index);
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

  _postPoints(int xCoordinate, int yCoordinate, int totalScanTime, int intervalTime, String dateTime,
      List<AccessPoint> accessPoints) async{
    Point newPoint = Point(xCoordinate, yCoordinate, totalScanTime, intervalTime, dateTime, accessPoints);
    APIResult response = await API.offlinePhaseAPI.postPoints(newPoint);
    if(response.isSuccessful())
      helper.showToast(strings.postedSuccessfully, context);
    else
      print(response.error);
  }

  _startTimer() {
    _timer = new Timer.periodic(
      _sampleTime, (Timer timer) {
      if (_isStopped == false) {
        _collectAccessPoints();
        Wifi.requestNewScan(false);
        setState(() {
          index = index + 1;
        });
      }
      else
        timer.cancel();
    },
    );
  }
  _completeTimer() {
    _filterData();
    // print(_accessPointsMap);
    _postPoints(
        _xValue,
        _yValue,
        _duration,
        _intervalTime ~/ 1000,
        helper.getDateTime(),
        _accessPointsList);
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
    index = 0;
  }
}