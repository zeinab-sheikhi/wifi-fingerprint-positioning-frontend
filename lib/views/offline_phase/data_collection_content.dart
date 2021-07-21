import 'dart:async';

import 'package:access_point/api/api.dart';
import 'package:access_point/api/api_result.dart';
import 'package:access_point/models/point.dart';
import 'package:access_point/utils/preferences_util.dart';
import 'package:access_point/utils/helper.dart' as helper;
import 'package:access_point/utils/string_utils.dart' as strings;
import 'package:access_point/utils/color_utils.dart' as colors;
import 'package:access_point/views/offline_phase/add_button.dart';
import 'package:access_point/views/offline_phase/minus_button.dart';
import 'package:access_point/views/widgets/my_icons.dart' as icons;
import 'package:access_point/views/widgets/my_snackbar.dart' as snackbar;
import 'coordinate_text_field.dart';
import 'package:access_point/views/offline_phase/circular_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wifi_plugin/wifi_plugin.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class DataCollectionContent extends StatefulWidget {
  @override
  _DataCollectionContentState createState() => _DataCollectionContentState();
}

class _DataCollectionContentState extends State<DataCollectionContent> {
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
    _initVariables();
    super.initState();
  }

  _initVariables()  {
    _duration = PreferenceUtils.getInt(strings.scanTime, 20);
    _intervalTime = PreferenceUtils.getInt(strings.intervalTime, 1000);
    _sampleTime = Duration(milliseconds: _intervalTime);
    Wifi.setRssiListSize(_duration);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height * 2 / 3;
    return _body(height, width);
  }

  Widget _body(double width, double height) {
    return Center(
      child: Container(
        color: colors.backgroundColor,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: _resetTimer,
              child: CircularTimer(
                  duration: _duration,
                  controller: _controller,
                  startTimer: _startTimer,
                  completeTimer: _completeTimer),
            ),
            SizedBox(height: height / 20),
            _coordinateContainer(height, true),
            SizedBox(height: height / 20),
            _coordinateContainer(height, false),
          ],
        ),
      ),
    );
  }

  Widget _coordinateContainer(double height, bool isX) {
    return Container(
      height: height / 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MinusButton(
            icon: icons.minus,
            callBack: (val) => setState(() => isX? _xValue += val : _yValue += val),
          ),
          isX? CoordinateTextField(text: _xValue.toString(), labelText: strings.x) :
          CoordinateTextField(text: _yValue.toString(), labelText: strings.y),
          AddButton(
              icon: icons.plus,
              callBack: (val) => setState(() => isX? _xValue += val : _yValue += val)
          ),
        ],
      ),
    );
  }

  _collectAccessPoints() async {
    var result = await Wifi.getAccessPoints(index);
    setState(() => _accessPointsMap = result);
  }

   _filterData() {
    for(MapEntry mapEntry in _accessPointsMap.entries) {
      String bssid = mapEntry.key;
      List<int> rssiList = List.of(mapEntry.value).cast<int>();
      _accessPointsList.add(AccessPoint(bssid: bssid, rssiList: rssiList));
    }
  }

  _postData() async{
    Point newPoint = Point(
        xCoordinate: _xValue,
        yCoordinate: _yValue,
        totalScanTime: _duration,
        intervalTime: _intervalTime ~/ 1000,
        dateTime: helper.getDateTime(),
        accessPoints: _accessPointsList);
    APIResult response = await API.offlinePhaseAPI.postPoints(newPoint);
    if(response.isSuccessful())
      ScaffoldMessenger.of(context)
          .showSnackBar(snackbar.infoMessage(strings.postedSuccessfully));
    else
      print(response.error);
  }

  _startTimer() {
    _timer = new Timer.periodic(
      _sampleTime, (Timer timer) {
      if (_isStopped == false) {
        _collectAccessPoints();
        Wifi.requestNewScan(false);
        setState(() => index = index + 1);
      }
      else
        timer.cancel();
    });
  }

  _completeTimer() {
    _filterData();
    _postData();
    setState(() => _resetVariables());
  }

  _resetTimer() {
    Wifi.requestNewScan(true);
    setState(() {
      _isStopped = false;
      _controller.restart();
    });
  }

   _resetVariables() {
    _isStopped = true;
    _timer.cancel();
    _accessPointsList = [];
    _accessPointsMap = {};
    index = 0;
  }
}