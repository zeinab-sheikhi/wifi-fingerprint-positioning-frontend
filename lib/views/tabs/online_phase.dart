import 'dart:convert';

import 'package:access_point/model/access_point.dart';
import 'package:access_point/utils/constants.dart';
import 'package:access_point/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wifi_plugin/wifi_plugin.dart';


class OnLinePhase extends StatefulWidget {
  @override
  _OnLinePhaseState createState() => _OnLinePhaseState();
}

class _OnLinePhaseState extends State<OnLinePhase> {

  String xPosition = 'x';
  String yPosition = 'y';
  double accuracy = 0.0;
  bool _visible = false;

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
        body: Center(
            child: Container(
              width: width,
              height: height * 2 / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text('Locate'),
                      onPressed: () {
                          _getLocation();
                      },
                    ),
                    Visibility(
                        child: Text(
                            'Your Position is (${xPosition},${yPosition}) with ${accuracy} accuracy',
                          style: TextStyle(color: Colors.white),
                        ),
                      // maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: _visible,
                    )
      ]
              ),
            )));
  }

  _getLocation() async{

    // List<AccessPoint> accessPointsList = [];
    // Map<dynamic, dynamic> accessPointMap = await Wifi.accessPoints;
    //
    //   accessPointMap.forEach((key, value) {
    //     String bssid = key;
    //     int rssi = List.of(value).cast<int>().first;
    //     accessPointsList.add(new AccessPoint(bssid, rssi));
    //   });

    // String json = jsonEncode(accessPointsList);
    // Response response = await post(Util.getUrl('/api/location'), headers: Constants.headers, body: json);
    // if(response == 200)
    //   decodeJSON(response.body);
    // else {
    //   Util.showToast(
    //       'Can not get position right now, please try again later.', context);
      setState(() {
        _visible = true;
      });
    }


  decodeJSON(String body) {
    Map<String, dynamic> map = jsonDecode(body);
    setState(() {
      xPosition = map['x'];
      yPosition = map['y'];
      accuracy = map['accuracy'];
      _visible = true;
    });
  }

}
