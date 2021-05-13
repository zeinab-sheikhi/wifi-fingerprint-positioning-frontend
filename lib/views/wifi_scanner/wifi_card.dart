import 'package:access_point/utils/util.dart';
import 'package:access_point/views/wifi_scanner/wifi_information_dialog.dart';
import 'package:access_point/views/wifi_scanner/wifi_level_indicator.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    return _wifiItemCard(SSID, BSSID, RSSI, freq, channel, level, width, height, context);
  }

  Widget _wifiItemCard(
      String SSID,
      String BSSID,
      String RSSI,
      String frequency,
      String channel,
      int level,
      double width,
      double height,
      BuildContext context) {

    return ListTile(
      tileColor: Color(0xff242c42),
      title: _wifiInfoTopSection(SSID, BSSID, level, width, height),
      subtitle: _wifiInfoBottomSection(frequency, channel, RSSI, height),
      contentPadding: EdgeInsets.symmetric(horizontal: width / 20),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return WifiInfoDialog(
                iconColor: Util.progressColorBasedOnLevel(level),
                ssid: SSID,
                bssid: BSSID,
                band: frequency,
                signal: RSSI,
                channel: channel,
              );
            }
        );
      },
    );
  }

  Widget _ssidTextContainer(String SSID, double height) {
    return AutoSizeText(
      SSID,
      maxLines: 1,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _bssidTextContainer(String BSSID, double height) {
    return AutoSizeText(
      BSSID,
      maxLines: 1,
      style: TextStyle(
          color: Colors.white,
          fontSize: 15
      ),
    );
  }

  Widget _wifiInfoTopSection(String SSID, String BSSID, int level, double width, double height) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height / 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ssidTextContainer(SSID, height),
              SizedBox(height: height / 50),
              _bssidTextContainer(BSSID, height),
            ],
          ),
          SizedBox(
            width: 10,
            height: height / 10,
            child: WifiLevelIndicator(
              progress: Util.levelToProgress(level),
              backgroundColor: Util.backgroundColorBasedOnLevel(level),
              progressColor: Util.progressColorBasedOnLevel(level),
            ),
          )
        ],
      ),
    );
  }

  Widget _wifiInfoBottomSection(String frequency, String channel, String RSSI, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: height / 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _wifiFeatureContainer(
                  Util.getChannel(frequency) + ' GHz',
                  Icons.settings_input_antenna,
                  width,
                  height
              ),
              _wifiFeatureContainer(
                  'CH ' + channel,
                  Icons.settings_remote,
                  width,
                  height
              ),
              _wifiFeatureContainer(
                  RSSI + ' dBm',
                  Icons.equalizer,
                  width,
                  height
              ),
              SizedBox()
            ],
          ),
        ),
        Divider(color: Colors.white)
      ],
    );
  }

  Widget _wifiFeatureContainer(String title, IconData icon, width, height) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height / 100, horizontal: width / 40),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 15,
                color: Colors.white
            ),
          ),
          SizedBox(width: width / 40),
          Icon(
            icon,
            size: 20,
            color: Colors.white,
          )
          // Icon(MdiIcons)
        ],
      ),
    );
  }
  }
