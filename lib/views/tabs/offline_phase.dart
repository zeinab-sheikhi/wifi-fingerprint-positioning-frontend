import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'dart:async';


import 'package:access_point/model/access_point.dart';
import 'package:access_point/model/point.dart';
import 'package:access_point/utils/preferences_util.dart';
import 'package:access_point/utils/util.dart';
import 'package:access_point/utils/widgets/custom_collect_button.dart';
import 'package:access_point/utils/widgets/custom_text_field.dart';
import 'package:access_point/utils/widgets/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  final xCoordinateController = TextEditingController();
  final yCoordinateController = TextEditingController();
  final CountDownController _controller = CountDownController();

  late String url;
  late int _duration;
  var sampleTime;
  late int _selectXItems;
  late Timer _timer;
  late bool isStopped;
  List<AccessPoint> accessPointsList = [];
  Map<dynamic, dynamic> accessPointMap = {};

  int average = 0;

  @override
  void initState() {
    super.initState();
    _initializeVariables();
  }

  _initializeVariables()  {
    setState(() {
      url = Util.getUrl('/api/points');
      sampleTime = Duration(milliseconds: PreferenceUtils.getInt('intervalTime', 100));
      _duration = PreferenceUtils.getInt('scanTime', 20);
      _selectXItems = PreferenceUtils.getInt('X', 1);
    });
  }

  void collectAccessPoints() async {
    var result = await Wifi.accessPoints;
    setState(() {
      accessPointMap = result;
    });
  }

  void filterData() {

    for(MapEntry mapEntry in accessPointMap.entries) {
      String wifiBSSID = mapEntry.key;
      List<int> wifiRSSIs = List.of(mapEntry.value).cast<int>();
      if(wifiRSSIs.length > _selectXItems) {
        wifiRSSIs = Util().makeList(wifiRSSIs, _selectXItems);
        average = Util().calculateMean(wifiRSSIs);
        accessPointsList.add(new AccessPoint(wifiBSSID, average));
      }
    }
  }

  Future<void> sendData(List<AccessPoint> accessPointList) async {

    int xCoordinate = int.parse(xCoordinateController.text);
    int yCoordinate = int.parse(yCoordinateController.text);
    Point _point = new Point(xCoordinate, yCoordinate, accessPointList);
    String json = jsonEncode(_point);
    Response response = await post(url, headers:Constants.headers, body: json);
    int statusCode = response.statusCode;
    if(statusCode == 200)
      Util.showToast("AccessPoint added Successfully", context);
  }

  startTimer() {
    _timer = new Timer.periodic(
      sampleTime, (Timer timer) {
      if (isStopped == false) {
        collectAccessPoints();
        Wifi.requestNewScan(false);
      }
      else
        timer.cancel();
    },
    );
  }
  completeTimer() {
    filterData();
    sendData(accessPointsList);
    setState(() {
      resetVariables();
    });
  }

  resetTimer() {
    setState(() {
      _initializeVariables();
      Wifi.requestNewScan(true);
      isStopped = false;
      _controller.restart();
    });
  }

  void resetVariables() {
    isStopped = true;
    _timer.cancel();
    accessPointsList = [];
    accessPointMap = {};
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;


    return Scaffold(
      backgroundColor: Color(0xff030712),
      body:
      Stack(
        alignment: Alignment.center,
        children:[
          Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: (height) * 3 / 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTimer(
                      width: width,
                      height: height,
                      duration: _duration,
                      controller: _controller,
                      startTimer: startTimer,
                      completeTimer: completeTimer),
                  SizedBox(
                    width: width * 4 / 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: width * 2 / 5,
                          child: MyTextField(
                            labelText: "X",
                            hintText: '0',
                            prefixIcon: Icon(Icons.location_on, color: Colors.white,),
                            controller: xCoordinateController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                          ),
                        ),
                        Container(
                          width: width * 2 / 5,
                          child: MyTextField(
                            labelText: "Y",
                            hintText: '0',
                            prefixIcon: Icon(Icons.location_on, color: Colors.white,),
                            controller: yCoordinateController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 20, vertical: height / 60),
                    child: SizedBox(
                      width: width ,
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
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: Color(0xff0c132d),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(100, 30),
                      topRight: Radius.elliptical(100, 30)),
                ),
              ),
            ),
          ],
        ),
          Positioned(
            top: height * 3 / 5 - height / 16,
            child: CollectButton(
              widthSize: width / 5,
              heightSize: height / 8,
              fontSize: 20,
              callBack: () {resetTimer();},
              loading: true,
            ),
          )
      ]
      ),
    );
  }
}