import 'package:access_point/utils/helper.dart' as helper;
import 'package:access_point/utils/string_utils.dart' as strings;
import 'package:access_point/utils/color_utils.dart' as colors;
import 'package:access_point/views/widgets/my_icons.dart' as icons;
import 'package:access_point/views/wifi_scanner/information_dialog.dart';
import 'package:access_point/views/wifi_scanner/level_indicator.dart';
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

    String SSID = wifi[strings.ssid];
    String BSSID = wifi[strings.bssid];
    String RSSI = wifi[strings.rssi];
    int level = int.parse(RSSI);
    String freq = wifi[strings.frequency];
    String channel = wifi[strings.channel];
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
      tileColor: colors.primaryColorLight,
      title: _wifiInfoTopSection(SSID, BSSID, level, width, height),
      subtitle: _wifiInfoBottomSection(frequency, channel, RSSI, height),
      contentPadding: EdgeInsets.symmetric(horizontal: width / 20),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return WifiInfoDialog(
                iconColor: helper.progressColorBasedOnLevel(level),
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
      maxFontSize: 20,
      minFontSize: 16,
      style: TextStyle(
        color: colors.primaryColor,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _bssidTextContainer(String BSSID, double height) {
    return AutoSizeText(
      BSSID,
      maxLines: 1,
      style: TextStyle(
          color: colors.primaryColor,
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
              progress: helper.levelToProgress(level),
              backgroundColor: helper.backgroundColorBasedOnLevel(level),
              progressColor: helper.progressColorBasedOnLevel(level),
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
                  helper.getChannel(frequency) + strings.gigaHertz,
                  icons.antenna,
                  width,
                  height
              ),
              _wifiFeatureContainer(
                  strings.ch + channel,
                  icons.remote,
                  width,
                  height
              ),
              _wifiFeatureContainer(
                  RSSI + strings.dbm,
                  icons.equalizer,
                  width,
                  height
              ),
              SizedBox()
            ],
          ),
        ),
        Divider(color: colors.primaryColor)
      ],
    );
  }

  Widget _wifiFeatureContainer(String title, IconData icon, width, height) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height / 100, horizontal: width / 40),
      decoration: BoxDecoration(
          color: colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 15,
                color: colors.primaryColor
            ),
          ),
          SizedBox(width: width / 40),
          Icon(
            icon,
            size: 20,
            color: colors.primaryColor,
          )
          // Icon(MdiIcons)
        ],
      ),
    );
  }
  }
