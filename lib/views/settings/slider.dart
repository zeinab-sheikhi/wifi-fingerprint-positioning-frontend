import 'package:access_point/utils/color_utils.dart' as colors;
import 'package:access_point/utils/preferences_util.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingsSlider extends StatefulWidget {

  double min;
  double max;
  int division;
  int value;
  String sharedPreferencesKey;

  SettingsSlider({
    required this.min,
    required this.max,
    required this.division,
    required this.value,
    required this.sharedPreferencesKey
  });

  @override
  _SettingsSliderState createState() => _SettingsSliderState();
}

class _SettingsSliderState extends State<SettingsSlider> {

  @override
  Widget build(BuildContext context) {

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        // activeTickMarkColor: Color(0xFFEC6395),
        activeTickMarkColor: colors.accentColor,
        // inactiveTickMarkColor: Color(0xFFE4276B),
        inactiveTickMarkColor: colors.sliderInactiveTickMark,
        valueIndicatorColor: colors.primaryColor,
        // activeTrackColor: Color(0xFFEC6395),
        activeTrackColor: colors.sliderActiveTrack,
        inactiveTrackColor: colors.primaryColor,
        // thumbColor: Color(0xFFE4276B),
        thumbColor: colors.sliderThumbColor,
      ),
      child: Slider(
        min: widget.min,
        max: widget.max,
        divisions: widget.division,
        value: widget.value.toDouble(),
        label: '${widget.value}',
        onChanged: (double newValue) {
          setState(() {
            widget.value = newValue.toInt();
            _saveToPrefs(widget.value);
          });
        },
      ),
    );
  }

  _saveToPrefs(int value) async {
    PreferenceUtils.setInt(widget.sharedPreferencesKey, value);
    }
}

