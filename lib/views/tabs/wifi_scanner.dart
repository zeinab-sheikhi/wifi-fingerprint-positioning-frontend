import 'package:access_point/utils/widgets/custom_wifi_card.dart';
import 'package:access_point/views/tabs/setting.dart';
import 'package:flutter/material.dart';
import 'package:wifi_plugin/wifi_plugin.dart';

class WiFiScanner extends StatefulWidget {
  @override
  _WiFiScannerState createState() => _WiFiScannerState();
}

class _WiFiScannerState extends State<WiFiScanner> {

  List<dynamic> _wifis = [];

  @override
  void initState() {
    super.initState();
    fetchAccessPoints();
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
          child: _buildList(height, width)
        )
    );
  }
  fetchAccessPoints() async {
    var result = await Wifi.wifiScanner;
    setState(() {
      _wifis = result;
    });
    return _wifis;
  }
  Future<void> _getAccessPoints() async {
    setState(() {
      fetchAccessPoints();
    });
  }

  Widget _buildList(height, width) {
    return _wifis.length != 0 ? 
        RefreshIndicator(
            child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(8.0),
                      itemCount: _wifis.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return WiFiCard(
                            width: width,
                            height: height,
                            wifi: _wifis.elementAt(index)
                        );
                      },
                    ),
            onRefresh: _getAccessPoints) : Center(child: CircularProgressIndicator());
  }

}
