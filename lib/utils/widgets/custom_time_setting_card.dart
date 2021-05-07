
import 'package:access_point/utils/constants.dart';
import 'package:access_point/utils/preferences_util.dart';
import 'package:access_point/utils/util.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';

import 'custom_round_button.dart';

// ignore: must_be_immutable
class SettingParameterCard extends StatefulWidget {

  String title;
  int supplement;
  int parameter;

  SettingParameterCard({
    required this.title,
    required this.supplement,
    required this.parameter
});
  @override
  _SettingParameterCardState createState() => _SettingParameterCardState();
}

class _SettingParameterCardState extends State<SettingParameterCard> {
  int supplement = 0;

  @override
  void initState() {
    super.initState();
    _loadParameters();
  }
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height / 8,
      child: Card(
        elevation: 2,
        margin: new EdgeInsets.symmetric(vertical: 5.0),
        color: Color(0xff242c42),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            AutoSizeText(
            widget.title,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold
            ),
          ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                RoundButton(
                    icon: Icon(Icons.remove_rounded, color: Color(0xfffdfeff),), 
                    onPressed: () { _decrease(); },
                    width: width, 
                    height: height),
                AutoSizeText(
                  supplement.toString(),
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                RoundButton(
                    icon: Icon(Icons.add, color: Color(0xfffdfeff),), 
                    onPressed: () { _increase(); },
                    width: width, 
                    height: height),
              ],
            ),
            ]
          ),
        ),
      ),
    );
  }

  ///load algorithm parameters(T, D, X) from shared preferences
  _loadParameters() async {

    int _supplement = 0;
    switch (widget.parameter) {
      case Constants.parameterT: {
          _supplement = PreferenceUtils.getInt('scanTime', 20);
      }
      break;
      case Constants.parameterD :{
          _supplement = PreferenceUtils.getInt('intervalTime', 100);
      break;
      }
      case Constants.parameterX: {
          _supplement = PreferenceUtils.getInt('X', 1);
      }
    }
    setState(() {
      supplement = _supplement;
    });
  }

  ///Decrease parameter value when user presses minus button.
  _decrease()  {

    int _supplement = 0;
    
    switch (widget.parameter) {
      case Constants.parameterT: {
        _supplement = PreferenceUtils.getInt('scanTime', 20);
        _supplement -= widget.supplement;
        if(_supplement <= 0) {
          Util.showToast("Scan Time must be a Positive Integer", context);
          _supplement = 5;
        }
        PreferenceUtils.setInt('scanTime', _supplement);
      }
      break;
      case Constants.parameterD: {
        _supplement = PreferenceUtils.getInt('intervalTime', 100);
        _supplement -= widget.supplement;
        if(_supplement <= 0) {
          Util.showToast("Interval Time must be a Positive Integer", context);
          _supplement = 100;
        }
        PreferenceUtils.setInt('intervalTime', _supplement);
      }
      break;
      case Constants.parameterX: {
        _supplement = PreferenceUtils.getInt('X', 1);
        _supplement -= widget.supplement;
        if(_supplement <= 0) {
          Util.showToast('X must be a Positive Integer', context);
          _supplement = 1;
        }
        PreferenceUtils.setInt('X', _supplement);
      }
    }
    setState(() {
      supplement = _supplement;
    });
  }

  ///Increase parameter value when user presses plus button.
  _increase() {

    int _supplement = 0;
    int _parameterD = 0;
    int _parameterT = 0;

    switch (widget.parameter) {
      case Constants.parameterT: {
        _supplement = PreferenceUtils.getInt('scanTime', 20);
        _supplement += widget.supplement;
        if(_supplement > 30) {
          Util.showToast("Maximum Scan Time is 30s", context);
          _supplement = 30;
        }
        PreferenceUtils.setInt('scanTime', _supplement);
      }
      break;
      case Constants.parameterD: {
        _supplement = PreferenceUtils.getInt('intervalTime', 100);
        _supplement += widget.supplement;
        PreferenceUtils.setInt('intervalTime', _supplement);
      }
      break;
      case Constants.parameterX: {
        _supplement = PreferenceUtils.getInt('X', 1);
        _supplement += widget.supplement;
        _parameterD = PreferenceUtils.getInt('intervalTime', 100);
        _parameterT = PreferenceUtils.getInt('scanTime', 20);
        int max = (_parameterD ~/ 1000) * _parameterT;
        if(_supplement >= max) {
          Util.showToast('Check your X parameter', context);
          _supplement = 1;
        }
        PreferenceUtils.setInt('X', _supplement);
      }
    }
    setState(() {
      supplement = _supplement;
    });
  }

}
