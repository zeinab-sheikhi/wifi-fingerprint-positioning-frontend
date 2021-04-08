import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'custom_level_indicator.dart';

// ignore: must_be_immutable
class WiFiCard extends StatelessWidget {


  double elevation;
  double width;
  double height;
  int index;
  var wifiList;

  WiFiCard({

    this.elevation = 8,
    required this.width,
    required this.height,
    required this.index,
    required this.wifiList,

});

  @override
  Widget build(BuildContext context) {

    String wifiSSID = wifiList.keys.elementAt(index);
    int wifiLevel = wifiList[wifiSSID];

    return Card(
      elevation: elevation,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      color: Color(0xff242c42),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 2.0, color: Colors.white24))),
          child:
          WiFiLevelIndicator(level: wifiLevel),
        ),
        title: AutoSizeText(
          wifiSSID,
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: AutoSizeText(
            wifiLevel.toString(),
            maxLines: 1,
            style: TextStyle(
                color: Colors.white,
                fontSize: MyApp.MAIN_FONT()),
          ),
        ),
        dense: true,
      ),
    );
  }
}
