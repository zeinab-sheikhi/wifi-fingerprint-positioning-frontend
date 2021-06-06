import 'dart:convert';
import 'dart:async';

import 'package:access_point/model/online_phase.dart';
import 'package:access_point/utils/data/helper.dart';
import 'package:access_point/utils/data/preferences_util.dart';
import 'package:access_point/utils/data/string_utils.dart';
import 'package:access_point/utils/views/floor_map.dart';
import 'package:access_point/views/online_phase/online_phase_blue_dot_icon.dart';
import 'package:access_point/views/online_phase/online_phase_position_card.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
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

  String _classificationModel = "KNN";
  String _regressionModel = "KNN";
  String _url = "url";

  @override
  void initState() {
    Helper.changeScreenToLandscape();
    _loadSharedPrefs();
    _collectAccessPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: body(width, height),
    );
  }

  Widget body(double width, double height) {
    return LayoutBuilder(
        builder: (context, constraints){
          return Container(
            color: Colors.white,
            child: Stack(
              children: [
                FloorMap(),
                UserPositionCard(
                  xCoordinate: _xCoordinate,
                  yCoordinate: _yCoordinate,
                  tileNumber: _tileNumber
                ),
                _navigationButton(width, height),
                _visible? _currentPositionMarker() : Container()
              ],
            ),
          );
        }
    );
  }

  Widget _navigationButton(double width, double height) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        child: IconButton(
          onPressed: (){
            setState(() {
              _collectAccessPoints();
              _filterData();
              _postData();
            });
          },
          iconSize: 35,
          icon: Icon(
              Icons.my_location,
            color: Color(0xff073980)
          ),
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

  Future _collectAccessPoints() async {
    Wifi.requestNewScan(true);
    var result = await Wifi.accessPoints;
    setState(() {
      _map = result;
    });
  }

  void _filterData() {

    setState(() {
      for(MapEntry mapEntry in _map.entries) {
        String wifiBSSID = mapEntry.key;
        int wifiRSSI = List
            .of(mapEntry.value)
            .cast<int>()
            .first;
        _accessPointsMap[wifiBSSID] = wifiRSSI;

      }
    });
  }

  Future _postData() async {
    OnlinePhaseModel _onlinePhaseModel = new OnlinePhaseModel(
        accessPoints: _accessPointsMap,
        classificationModel: _classificationModel,
        regressionModel: _regressionModel);

    String json = jsonEncode(_onlinePhaseModel);
    print(json);
    Response response = await post(_url, headers:StringUtils.headers, body: json);
    var responseBody = jsonDecode(response.body);
    int statusCode = response.statusCode;
    if(statusCode == 200) {
      setState(() {
        _tileNumber = responseBody["tileNumber"];
        _xCoordinate = responseBody["X"].toInt();
        _yCoordinate = responseBody["Y"].toInt();
        _yOffset = Helper().getPosition(_tileNumber);
        _visible = true;
      });
    }
  }

  _loadSharedPrefs() {
    _classificationModel = PreferenceUtils.getString("classificationModel", "KNN");
    _regressionModel = PreferenceUtils.getString("regressionModel", "KNN");
    _url = Helper.getUrl('/fingerprint/api/v1/position');
  }
}
