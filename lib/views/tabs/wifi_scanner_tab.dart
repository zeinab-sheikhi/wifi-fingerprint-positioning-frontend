import 'package:access_point/main.dart';
import 'package:wifi/wifi.dart';
import 'package:flutter/material.dart';

class WiFiScannerTab extends StatefulWidget {
  @override
  _WiFiScannerTabState createState() => _WiFiScannerTabState();
}

class _WiFiScannerTabState extends State<WiFiScannerTab> {
   List<WifiResult> accessPointList = [];

  @override
  void initState() {
    super.initState();
    loadAccessPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: accessPointList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return accessPointItem(index);
          },
        ),
      ),
    );
  }

  void loadAccessPoints() async {
    Wifi.list('').then((list) {
      setState(() {
        accessPointList = list;
      });
    });
  }

  Widget accessPointItem(index) {
    return Column(children: <Widget>[
      ListTile(
        leading:
            Icon(Icons.wifi, color: getColor(accessPointList[index].level)),
        title: Text(
          accessPointList[index].ssid,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18.0,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            accessPointList[index].level.toString(),
            style: TextStyle(
                color: getColor(accessPointList[index].level),
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
