import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'dart:async';


import 'package:access_point/model/access_point.dart';
import 'package:access_point/model/point.dart';
import 'package:access_point/utils/preferences_util.dart';
import 'package:access_point/utils/util.dart';
import 'package:access_point/views/offline_phase/offline_phase_collect_button.dart';
import 'package:access_point/utils/custom_widgets/custom_text_field.dart';
import 'package:access_point/views/offline_phase/offline_phase_circular_timer.dart';
import 'package:access_point/views/screens/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wifi_plugin/wifi_plugin.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import '../../utils/constants.dart';


class OfflinePhase extends StatefulWidget {
  @override
  _OfflinePhaseState createState() => _OfflinePhaseState();
}

class _OfflinePhaseState extends State<OfflinePhase> {

  final _xCoordinateController = TextEditingController();
  final _yCoordinateController = TextEditingController();
  final CountDownController _controller = CountDownController();

  String _url = '';
  int _duration = 0;
  int _selectXItems = 0;
  int _average = 0;
  var _sampleTime;
  late Timer _timer;
  bool _isStopped = false;
  List<AccessPoint> _accessPointsList = [];
  Map<dynamic, dynamic> _accessPointsMap = {};

  @override
  void initState() {
    super.initState();
    _initializeVariables();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(body: _buildBody(height, width));
  }

  Widget _buildBody(height, width) {
    return Stack(
        alignment: Alignment.center,
        children: [
          _customScrollView(width, height),
          _buttonContainer(width, height)
        ]
    );
  }

  Widget _customScrollView(width, height) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _topContainer(width, height),
                _bottomContainer(width, height)
              ]
          ),
        )
      ],
    );
  }

  Widget _topContainer(width, height) {
    return Container(
      height: (height * 3) / 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircularTimer(
              width: width,
              height: height,
              duration: _duration,
              controller: _controller,
              startTimer: _startTimer,
              completeTimer: _completeTimer),
          SizedBox(
            width: width * 4 / 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width * 2 / 5,
                  child: MyTextField(
                      hintText: "0",
                      labelText: "X",
                      prefixIcon: Icon(Icons.location_on, color: Colors.white),
                      controller: _xCoordinateController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true)
                  ),
                ),
                Container(
                  width: width * 2 / 5,
                  child: MyTextField(
                      hintText: "0",
                      labelText: "Y",
                      prefixIcon: Icon(Icons.location_on, color: Colors.white),
                      controller: _yCoordinateController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true)
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomContainer(width, height) {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Color(0xff0c132d),
          borderRadius: BorderRadius.only(
              topLeft: Radius.elliptical(100, 30),
              topRight: Radius.elliptical(100, 30)),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 20, vertical: height / 60),
            child: SizedBox(
              width: width,
              height: height * 2 / 5 - (height / 16 + height / 30),
              child: Card(
                margin: EdgeInsets.only(top: height / 20),
                child: Center(),
                elevation: 9,
                color: Color(0xff162648),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonContainer(width, height) {
    return Positioned(
      top: height * 3 / 5 - height / 16,
      child: CollectButton(
        fontSize: 20,
        callBack: () {_resetTimer();},
        loading: true,
      ),
    );
  }

  _initializeVariables()  {
    setState(() {
      _url = Util.getUrl('/fingerprint/api/v1/points');
      _sampleTime = Duration(milliseconds: PreferenceUtils.getInt('intervalTime', 100));
      _duration = PreferenceUtils.getInt('scanTime', 20);
      _selectXItems = PreferenceUtils.getInt('X', 1);
    });
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
      List<int> wifiRSSIs = List.of(mapEntry.value).cast<int>();
      if(wifiRSSIs.length > _selectXItems) {
        wifiRSSIs = Util().makeList(wifiRSSIs, _selectXItems);
        _average = Util().calculateMean(wifiRSSIs);
        _accessPointsList.add(new AccessPoint(wifiBSSID, _average));
      }
    }
  }

  Future<void> _sendData(List<AccessPoint> accessPointList) async {

    int xCoordinate = int.parse(_xCoordinateController.text);
    int yCoordinate = int.parse(_yCoordinateController.text);
    Point _point = new Point(xCoordinate, yCoordinate, accessPointList);
    String json = jsonEncode(_point);
    Response response = await post(_url, headers:Constants.headers, body: json);
    int statusCode = response.statusCode;
    if(statusCode == 200)
      Util.showToast("AccessPoint added Successfully", context);
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