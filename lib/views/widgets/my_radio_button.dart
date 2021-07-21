import 'package:access_point/utils/preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:access_point/utils/color_utils.dart' as colors;

class MyRadioButton extends StatefulWidget {
  String sharedPrefKey;
  String sharedPrefValue;
  String groupValue;

  MyRadioButton({
    required this.sharedPrefKey,
    required this.sharedPrefValue,
    required this.groupValue});

  @override
  _MyRadioButtonState createState() => _MyRadioButtonState();
}

class _MyRadioButtonState extends State<MyRadioButton> {
  @override
  Widget build(BuildContext context) {
    return RadioListTile(
        title: Text(
            widget.sharedPrefValue,
            style: TextStyle(color: colors.primaryColor, fontSize: 14)
        ),
        value: widget.sharedPrefValue,
        groupValue: widget.groupValue,
        activeColor: colors.accentColor,
        onChanged: (newValue) {
          setState(() => widget.groupValue = newValue.toString());
          PreferenceUtils.setString(widget.sharedPrefKey, widget.sharedPrefValue);
        }
    );
  }
}
