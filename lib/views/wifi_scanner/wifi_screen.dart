import 'package:access_point/views/wifi_scanner/wifi_card.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: _buildAppbar(),
        body: Container(
            child: _buildList(height, width)
        )
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: AutoSizeText(
        'Wi-Fi Scanner',
        style: TextStyle(
            color: Colors.white
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildList(height, width) {
    return _wifis.length != 0 ?
    RefreshIndicator(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
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

}
