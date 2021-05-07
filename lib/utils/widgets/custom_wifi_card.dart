import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'custom_level_indicator.dart';

// ignore: must_be_immutable
class WiFiCard extends StatelessWidget {


  double elevation;
  double width;
  double height;
  dynamic wifi;

  WiFiCard({

    this.elevation = 8,
    required this.width,
    required this.height,
    required this.wifi,

});

  @override
  Widget build(BuildContext context) {

    String SSID = wifi['SSID'];
    String BSSID = wifi['BSSID'];
    String RSSI = wifi['RSSI'];
    int level = int.parse(RSSI);
    String freq = wifi['frequency'];
    String channel = wifi['channel'];

    return InkWell(
      onTap: (){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return _wifiSpecsDialog(BSSID, SSID, RSSI, freq, channel, context);
            }
        );
      },
      child: Card(
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
            WiFiLevelIndicator(level: level),
          ),
          title: AutoSizeText(
            SSID,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoSizeText(
                  BSSID,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MyApp.MAIN_FONT()
                  ),
                ),
                AutoSizeText(
                  RSSI.toString(),
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MyApp.MAIN_FONT()),
                ),
              ],
            ),
          ),
          dense: true,
        ),
      ),
    );
  }

  _wifiSpecsDialog(String bssid, String ssid, String rssi, String freq, String channel, BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          height: height / 3,
          padding: EdgeInsets.symmetric(
            horizontal: 20
          ),
          // margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _specRow('SSID', ssid),
              _specRow('BSSID', bssid),
              _specRow('Signal', rssi),
              _specRow('Band', freq),
              _specRow('Channel', channel),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text('close',style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        )
    );
  }
  
  _specRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: Colors.black12),),
        AutoSizeText(value, maxLines: 1, style: TextStyle(color: Colors.black))
      ],
    );
  }


}
