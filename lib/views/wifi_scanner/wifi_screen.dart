import 'package:access_point/views/wifi_scanner/wifi_card.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:wifi_plugin/wifi_plugin.dart';
import 'package:access_point/utils/color_utils.dart' as colors;
import 'package:access_point/views/widgets/my_icons.dart' as icons;
import 'package:access_point/utils/string_utils.dart' as strings;

class WiFiScanner extends StatefulWidget {
  @override
  _WiFiScannerState createState() => _WiFiScannerState();
}

class _WiFiScannerState extends State<WiFiScanner> {
  List<dynamic> _wifiList = [];

  @override
  void initState() {
    fetchAccessPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: _appbar(),
        body: Container(
            child: _buildList(height, width)
        )
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: AutoSizeText(
        strings.wifiScanner,
        style: TextStyle(color: colors.primaryColor)
      ),
      leading: IconButton(
        icon: Icon(icons.backArrow, color: colors.primaryColor),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildList(height, width) {
    return _wifiList.length != 0 ?
    RefreshIndicator(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _wifiList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return WiFiCard(wifi: _wifiList.elementAt(index));
          }
        ),
        onRefresh: _getAccessPoints) : Center(child: CircularProgressIndicator());
  }

  fetchAccessPoints() async {
    var result = await Wifi.wifiScanner;
    setState(() => _wifiList = result);
  }

  Future<void> _getAccessPoints() async => setState(() => fetchAccessPoints());
}
