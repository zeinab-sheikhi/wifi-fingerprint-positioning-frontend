import 'package:access_point/utils/widgets/custom_wifi_card.dart';
import 'package:access_point/views/tabs/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:wifi_scan_plugin/wifi_scan_plugin.dart';

class WiFiScanner extends StatefulWidget {
  @override
  _WiFiScannerState createState() => _WiFiScannerState();
}

class _WiFiScannerState extends State<WiFiScanner> {
  var wifiList;

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

        appBar: AppBar(
          leading: BackButton(
              color: Colors.white
          ),
          backgroundColor: Color(0xff030712),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingScreen()),
                );
              },
            )
          ],
        ),
        backgroundColor: Color(0xff030712),
        body: Container(
          child: FutureBuilder(
             future: loadAccessPoint(),
             builder: (context, snapshot) {
             if (snapshot.connectionState == ConnectionState.waiting) {
             return new Center(child: CircularProgressIndicator());
             } else if (snapshot.hasError) {
             return new Text('Error: ${snapshot.error}');
           } else {
               return ListView.builder(
                 scrollDirection: Axis.vertical,
                 padding: EdgeInsets.all(8.0),
                 itemCount: wifiList.length,
                 shrinkWrap: true,
                 itemBuilder: (BuildContext context, int index) {
                   return WiFiCard(width: width, height: height, index: index, wifiList: wifiList);
                 },
               );
             }}
          ),
        )
    );
  }
  loadAccessPoint() async {
    wifiList = await Wifi.wifiScanner;
    return wifiList;
  }
  Future<void> refreshList() async {
    Wifi.wifiScanner.then((value)  {
      setState(() {
        wifiList = value;
      });
    });
  }


}
