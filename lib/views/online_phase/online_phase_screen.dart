import 'dart:convert';

import 'package:access_point/api/api.dart';
import 'package:access_point/api/api_result.dart';
import 'package:access_point/models/online_phase.dart';
import 'package:access_point/utils/preferences_util.dart';
import 'package:access_point/utils/helper.dart' as helper;
import 'package:access_point/utils/color_utils.dart' as colors;
import 'package:access_point/views/widgets/my_icons.dart' as icons;
import 'package:access_point/utils/string_utils.dart' as strings;
import 'package:access_point/views/widgets/floor_map.dart';
import 'package:access_point/views/online_phase/blue_dot_map_marker.dart';
import 'package:access_point/views/online_phase/position_container.dart';
import 'package:flutter/material.dart';
import 'package:wifi_plugin/wifi_plugin.dart';

class OnlinePhase extends StatefulWidget {
  @override
  _OnlinePhaseState createState() => _OnlinePhaseState();
}

class _OnlinePhaseState extends State<OnlinePhase> {

  Map<String, int> _accessPointsMap = {};
  Map<dynamic, dynamic> _map = {};
  double _xOffset = 180.66666666666663;
  double _yOffset = 100;
  int _xCoordinate = 0;
  int _yCoordinate = 0;
  int _tileNumber = 1;
  bool _visible = false;
  String _classificationModel = strings.knn;
  String _regressionModel = strings.knn;

  @override
  void initState() {
    helper.changeScreenToLandscape();
    _initVariables();
    super.initState();
  }

  _initVariables() {
    _classificationModel = PreferenceUtils.getString(strings.classification, strings.knn);
    _regressionModel = PreferenceUtils.getString(strings.regression, strings.knn);
    Wifi.setRssiListSize(1);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _body(width, height),
    );
  }

  Widget _body(double width, double height) {
    return LayoutBuilder(
        builder: (context, constraints){
          return Container(
            color: colors.primaryColor,
            child: Stack(
              children: [
                FloorMap(),
                PositionContainer(
                  xCoordinate: _xCoordinate,
                  yCoordinate: _yCoordinate,
                  tileNumber: _tileNumber
                ),
                _navigationButton(),
                _visible? _currentPositionMarker() : Container()
              ],
            ),
          );
        }
    );
  }

  Widget _navigationButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        child: IconButton(
          iconSize: 35,
          icon: Icon(icons.myLocation, color: colors.mapMarker),
          onPressed: (){
            _collectAccessPoints();
            _filterData();
            _getPosition();
          }
        ),
      ),
    );
  }

  Widget _currentPositionMarker() {
    return Positioned(
        top: _xOffset,
        left: _yOffset,
      child: BlueDotIcon()
    );
  }

  _collectAccessPoints() async {
    Wifi.requestNewScan(true);
    var result = await Wifi.getAccessPoints(0);
    setState(() => _map = result);
  }

  _filterData() {
    setState(() {
      for(MapEntry mapEntry in _map.entries) {
        String bssid = mapEntry.key;
        int rssi = List.of(mapEntry.value).cast<int>().first;
        _accessPointsMap[bssid] = rssi;
      }
    });
  }

  _getPosition() async {
    OnlinePhaseModel newOnlinePhaseModel = OnlinePhaseModel(
        accessPoints: _accessPointsMap,
        classificationModel: _classificationModel,
        regressionModel: _regressionModel);
    APIResult response = await API.onlinePhaseAPI.getLocation(newOnlinePhaseModel);
    if(response.isSuccessful()) {
      var data = jsonDecode(response.data);
      setState(() {
        _tileNumber = data[strings.tileNumber].toInt();
        _xCoordinate = data[strings.x].toInt();
        _yCoordinate = data[strings.y].toInt();
        _yOffset = helper.getPosition(_tileNumber);
        _visible = true;
      });
      /// handle server error
    }else
      print(response.error);
  }
}
