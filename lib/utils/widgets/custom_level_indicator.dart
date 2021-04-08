import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// ignore: must_be_immutable
class WiFiLevelIndicator extends StatelessWidget {
  int level;

  WiFiLevelIndicator({
    required this.level
});
  @override
  Widget build(BuildContext context) {

    Color highLightColor;
    IconData iconData;

    if(level > -50) {
      highLightColor = Color(0xff3fcd88);
      iconData = MdiIcons.wifiStrength4;
    }
    else if(level <= -50 && level > -60) {
      highLightColor = Color(0xff118efc);
      iconData = MdiIcons.wifiStrength3;
    }
    else if(level <= -60 && level > -70) {
      highLightColor = Color(0xfff5e552);
      iconData = MdiIcons.wifiStrength2;
    }
    else if(level <= -70) {
      highLightColor = Color(0xffee5e65);
      iconData = MdiIcons.wifiStrength1;
    }
    else {
      iconData = MdiIcons.wifiStrengthOff;
      highLightColor = Colors.transparent;
    }
    return Icon(iconData,size: 35, color: highLightColor);
  }
}
