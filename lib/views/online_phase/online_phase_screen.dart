import 'dart:convert';

import 'package:access_point/model/online_phase.dart';
import 'package:access_point/utils/data/helper.dart';
import 'package:access_point/utils/data/preferences_util.dart';
import 'package:access_point/utils/data/string_utils.dart';
import 'package:access_point/utils/views/floor_map.dart';
import 'package:access_point/utils/views/map_marker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wifi_plugin/wifi_plugin.dart';
class OnlinePhase extends StatefulWidget {

  @override
  _OnlinePhaseState createState() => _OnlinePhaseState();
}

class _OnlinePhaseState extends State<OnlinePhase> {

  String _response = "Nothing From Server";
  Map<String, int> _accessPointsMap = {};
  double _xOffset = 100;
  double _yOffset = 100;

  @override
  void initState() {
    _collectAccessPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: _buildBody(width, height)
    );
  }
  Widget body(double width, double height) {
    return LayoutBuilder(
        builder: (context, constraints){
          return Center(
            child: Stack(
              children: [
                FloorMap(),
                _mapMarker()
              ],
            ),
          );
        }
    );
  }
  Widget _mapMarker() {
    return Positioned(
        top: _xOffset,
        left: _yOffset,
        child: MapMarker()
    );
  }
  
  Widget _buildBody(double width, double height) {
    return Center(
        child: Container(
          color: Colors.black,
          width: width,
          height: height / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: (){
                    _collectAccessPoints();
                    _sendData();
                  },
                  child: Text('Calculate Position')
              ),
              AutoSizeText(
                _response,
                maxLines: 10,
                maxFontSize: 16,
                style: TextStyle(
                  color: Colors.white
                ),
              )
            ],
          ),
        )
    );
  }

  void _collectAccessPoints() async {
    var result = await Wifi.accessPoints;
    setState(() {
      for(MapEntry mapEntry in result.entries) {
        String wifiBSSID = mapEntry.key;
        int wifiRSSI = List
            .of(mapEntry.value)
            .cast<int>()
            .first;
        _accessPointsMap[wifiBSSID] = wifiRSSI;
      }
    });
  }

  Future<void> _sendData() async {

    String _url = Helper.getUrl('/fingerprint/api/v1/position');
    int _hour = Helper().getHour();
    int _minute = Helper().getMinute();
    OnlinePhaseModel _onlinePhaseModel = new OnlinePhaseModel(
        accessPoints: _accessPointsMap, hour: _hour, minute: _minute);
    String json = jsonEncode(_onlinePhaseModel);
    print(json);
    Response response = await post(_url, headers:StringUtils.headers, body: json);
    print(response.body);
    setState(() {
      _response = response.body;
    });
    // int statusCode = response.statusCode;
    // if(statusCode == 200)
    //   Helper.showToast("AccessPoint added Successfully", context);
  }
  _getTilePosition(int tileNumber) async {

    double xOffset = PreferenceUtils.getDouble("tile${tileNumber}X", 100);
    double yOffset = PreferenceUtils.getDouble("tile${tileNumber}Y", 100);

    setState(() {
      _xOffset = xOffset;
      _yOffset = yOffset;
    });
  }
}
