import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'dart:async';


import 'package:access_point/model/access_point.dart';
import 'package:access_point/model/point.dart';
import 'package:access_point/utils/widgets/custom_collect_button.dart';
import 'package:access_point/utils/widgets/custom_text_field.dart';
import 'package:access_point/utils/widgets/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wifi_scan_plugin/wifi_scan_plugin.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:fl_chart/fl_chart.dart';



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
  int _duration = 5;
  late Timer _timer;
  late bool isStopped; //global
  var accessPoints;
  List<AccessPoint> accessPointsList = [];
  var accessPointMap = <dynamic, List<dynamic>>{};
  final List<FlSpot> dummyData1 = List.generate(5, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  @override
  void initState() {
    super.initState();
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
                    child: MyTextField(
                      labelText: "",
                      hintText: 'Enter Coordinate',
                      prefixIcon: Icon(Icons.location_on, color: Colors.white,),
                      controller: pointCoordinateController,
                      keyboardType: TextInputType.text,
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
                        child: Center(
                          child: LineChart(
                            LineChartData(

                              gridData: FlGridData(
                                show: false,
                              ),
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  dotData: FlDotData(
                                    show: true,
                                    getDotPainter: (spot, percent, barData, index) =>
                                        FlDotCirclePainter(radius: 5, color: Color(0xffbe0ee2)),
                                  ),
                                  spots: dummyData1,
                                  isCurved: true,
                                  barWidth: 3,
                                  colors: [
                                    Color(0xff2b4592),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
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
    accessPointsList = accessPointMap.entries.map((entry) =>
        AccessPoint(entry.key, entry.value)).toList();
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
    completeAction();
    postToServer(accessPointsList);
    setState(() {
      resetVariables();
    });
  }

   resetTimer() {
     setState(() {
      Wifi.requestNewScan(true);
      isStopped = false;
       _controller.restart();
     });

   }

  void resetVariables() {
    isStopped = true;
    _timer.cancel();
    accessPoints = {};
    accessPointsList = [];
    accessPointMap = {};
  }

}