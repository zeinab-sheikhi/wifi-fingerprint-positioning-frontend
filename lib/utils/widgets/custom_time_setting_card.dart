
import 'package:access_point/constants.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

import 'custom_round_button.dart';

// ignore: must_be_immutable
class SettingTimeCard extends StatefulWidget {

  String text;
  int baseTime;
  int chooseTerm;

  SettingTimeCard({
    required this.text,
    required this.baseTime,
    required this.chooseTerm
});
  @override
  _SettingTimeCardState createState() => _SettingTimeCardState();
}

class _SettingTimeCardState extends State<SettingTimeCard> {
  int timeText = 0;

  @override
  void initState() {
    super.initState();
    _loadSampleTime();
  }
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height / 8,
      child: Card(
        elevation: 2,
        margin: new EdgeInsets.symmetric(vertical: 6.0),
        color: Color(0xff242c42),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            AutoSizeText(
            widget.text,
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
                    onPressed: () {decreaseTime();},
                    width: width, 
                    height: height),
                AutoSizeText(
                  timeText.toString(),
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                RoundButton(
                    icon: Icon(Icons.add, color: Color(0xfffdfeff),), 
                    onPressed: () { increaseTime();},
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

  _loadSampleTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (widget.chooseTerm) {
      case Constants.chooseScanTime: {
        setState(() {
          timeText = (prefs.getInt('scanTime') ?? 20);
        });
      }
      break;
      case Constants.chooseIntervalTime :{
        setState(() {
          timeText = (prefs.getInt('intervalTime') ?? 100);
        });
      }
    }
  }

  decreaseTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int _time = 0;
    switch (widget.chooseTerm) {
      case Constants.chooseScanTime: {
        _time = (prefs.getInt('scanTime') ?? 20);
        _time -= widget.baseTime;
        if(_time <= 0) {
          _showToast("Scan Time must be a Positive Integer", context);
          _time = 5;
        }
        prefs.setInt('scanTime', _time);
      }
      break;
      case Constants.chooseIntervalTime: {
        _time = (prefs.getInt('intervalTime') ?? 100);
        _time -= widget.baseTime;
        if(_time <= 0) {
          _showToast("Interval Time must be a Positive Integer", context);
          _time = 100;
        }
        prefs.setInt('intervalTime', _time);
      }
      break;
    }
    setState(() {
      timeText = _time;
    });

  }

  increaseTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int _time = 0;
    switch (widget.chooseTerm) {
      case Constants.chooseScanTime: {
        _time = (prefs.getInt('scanTime') ?? 20);
        _time += widget.baseTime;
        if(_time > 30) {
          _showToast("Maximum Scan Time is 30s", context);
          _time = 30;
        }
        prefs.setInt('scanTime', _time);
      }
      break;
      case Constants.chooseIntervalTime: {
        _time = (prefs.getInt('intervalTime') ?? 100);
        _time += widget.baseTime;
        if(_time > 900) {
          _showToast("Maximum Interval Time is 1000ms", context);
          _time = 900;
        }
        prefs.setInt('intervalTime', _time);
      }

    }
    setState(() {
      timeText = _time;
    });
  }

  _showToast(String toastMessage, BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content:  Text(toastMessage),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffoldMessenger.hideCurrentSnackBar),
      ),
    );
  }

}
