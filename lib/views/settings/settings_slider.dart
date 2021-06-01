import 'package:access_point/utils/data/string_utils.dart';
import 'package:access_point/utils/data/preferences_util.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        // activeTickMarkColor: Color(0xFFEC6395),
        activeTickMarkColor: Color(0xff5dfdcd),
        // inactiveTickMarkColor: Color(0xFFE4276B),
        inactiveTickMarkColor: Color(0xFF0db8ba),
        valueIndicatorColor: Colors.white,
        // activeTrackColor: Color(0xFFEC6395),
        activeTrackColor: Color(0xFF5dfdcd),
        inactiveTrackColor: Colors.white,
        // thumbColor: Color(0xFFE4276B),
        thumbColor: Color(0xFF29bb89),
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

