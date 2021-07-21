import 'package:access_point/views/settings/text_field.dart';
import 'package:access_point/utils/color_utils.dart' as colors;
import 'package:access_point/utils/string_utils.dart' as strings;
import 'package:access_point/views/widgets/my_expansion_tile.dart';
import 'package:access_point/views/widgets/my_icons.dart' as icons;
import 'package:access_point/views/widgets/my_tile_icon.dart';
import 'package:flutter/material.dart';

class ServerTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SettingExpandedTile(
      title: strings.server,
      subtitle: strings.serverTile,
      leadingIcon: TileLeadingIcon(iconData: icons.database),
      accentColor: colors.accentColor,
      childrenWidgets: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: width / 20, vertical: width / 40),
          child: SettingsTextField(
              sharedPrefKey: strings.ipAddress,
              defaultValue: strings.defaultIpAddress,
              errorText: strings.checkInput,
              labelText: strings.ipAddressTitle,
              textColor: colors.primaryColor,
              cursorColor: colors.grey,
              enableColor: colors.accentColor,
              disableColor: Colors.transparent,
              focusedColor: colors.accentColor,
              errorColor: colors.error,
              contentPadding: width / 20,
              isIP: true
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: width / 20, vertical: width / 40),
          child: SettingsTextField(
              sharedPrefKey: strings.port,
              defaultValue: strings.defaultPort,
              errorText: strings.checkInput,
              labelText: strings.portTitle,
              textColor: colors.primaryColor,
              cursorColor: colors.grey,
              enableColor: colors.accentColor,
              disableColor: Colors.transparent,
              focusedColor: colors.accentColor,
              errorColor: colors.error,
              contentPadding: width / 20,
              isIP: false
          ),
        )
      ],
    );
  }
}
