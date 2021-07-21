import 'package:access_point/views/widgets/my_list_tile.dart';
import 'package:access_point/views/widgets/my_tile_icon.dart';
import 'package:flutter/material.dart';
import 'package:access_point/utils/color_utils.dart' as colors;
import 'package:access_point/views/widgets/my_icons.dart' as icons;
import 'package:access_point/utils/string_utils.dart' as strings;
import 'package:wifi_plugin/wifi_plugin.dart';

class WifiTile extends StatefulWidget {
  @override
  _WifiTileState createState() => _WifiTileState();
}

class _WifiTileState extends State<WifiTile> {
  bool isSwitched = false;

  @override
  void initState() {
    _isWifiEnable();
    super.initState();
  }

  _isWifiEnable() async{
    bool result = await Wifi.isWiFiEnable;
    setState(() => isSwitched = result);
  }

  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
        title: strings.wifi,
        subtitle: isSwitched? strings.disableWifi : strings.enableWifi,
        leadingIcon: TileLeadingIcon(iconData: icons.wifi),
        trailingWidget: _wifiSwitch()
    );
  }

  Widget _wifiSwitch() {
    return Switch(
        value: isSwitched,
        activeColor: colors.primaryColor,
        activeTrackColor: colors.accentColor,
        inactiveThumbColor: colors.primaryColor,
        inactiveTrackColor: colors.inactiveSwitch,
        onChanged: (bool value) {
          setState(() {
            isSwitched = value;
            Wifi.enableWiFi(isSwitched);
          });
        }
    );
  }
}

