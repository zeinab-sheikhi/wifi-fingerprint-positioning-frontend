import 'dart:async';

import 'package:access_point/main.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wifi_scan_plugin/wifi_scan_plugin.dart';

class WiFiScannerTab extends StatefulWidget {
  @override
  _WiFiScannerTabState createState() => _WiFiScannerTabState();
}

class _WiFiScannerTabState extends State<WiFiScannerTab> {

   var accessPointList;

   @override
   void initState() {
     super.initState();
     Wifi.wifiScanner.then((value)  {
       setState(() {
         accessPointList = value;
       });
     });
   }

   @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: FutureBuilder(
          future: loadAccessPoints(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return new Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return new Text('Error: ${snapshot.error}');
              } else {
                return RefreshIndicator(
                  onRefresh: refreshList,
                  child: ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    itemCount: accessPointList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return _accessPointItem(index);
                    },
                  ),
                );
              }
            }
        ),
      ),
    );
  }



   loadAccessPoints() async {
       accessPointList = await Wifi.wifiScanner;
       return accessPointList;
    }
  Future<void> refreshList() async {
    Wifi.wifiScanner.then((value)  {
      setState(() {
        accessPointList = value;
      });
    });
  }

   @override
   void dispose() {
     super.dispose();
   }

  Widget _accessPointItem(index) {

     var ssid =  accessPointList.keys.elementAt(index);
     var rssi = accessPointList[ssid];

    return Column(children: <Widget>[
      ListTile(
        leading:
            Icon(Icons.wifi, color: getColor(rssi)),
        title: Text(ssid,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18.0,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            rssi.toString(),
            style: TextStyle(
                color: getColor(rssi),
                fontSize: MyApp.MAIN_FONT()),
          ),
        ),
        dense: true,
      ),
      Divider(),
    ]);
  }

  Color getColor(int level) {
    if (level > -50) {
      return Colors.greenAccent;
    } else if (level < -50 && level > -60) {
      return Colors.blueAccent;
    } else if (level < -60 && level > -70) {
      return Colors.yellow;
    } else {
      return Colors.redAccent;
    }
  }
}
