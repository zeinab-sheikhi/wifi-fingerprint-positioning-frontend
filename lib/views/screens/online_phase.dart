
import 'package:access_point/utils/custom_widgets/custom_text_field.dart';
import 'package:access_point/utils/preferences_util.dart';
import 'package:access_point/views/settings/settings_slider.dart';
import 'package:access_point/views/settings/settings_text_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnLinePhase extends StatefulWidget {
  @override
  _OnLinePhaseState createState() => _OnLinePhaseState();
}

class _OnLinePhaseState extends State<OnLinePhase> {

  late TextEditingController ipAddressTextFieldController;
  late TextEditingController portTextFieldController;
  String _ipAddress = '';
  String _port = "";
  FocusNode _focusNode = FocusNode();
  String sharedPrefKey = 'ipAddress';


  @override
  void initState() {
    _loadSharedPref();
    _initializeVariables();
    super.initState();
  }
  @override
  void dispose() {
    ipAddressTextFieldController.dispose();
    portTextFieldController.dispose();
    super.dispose();
  }
  _initializeVariables() {
    ipAddressTextFieldController =  TextEditingController(text: _ipAddress);
    portTextFieldController  = TextEditingController(text: _port);
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      backgroundColor: Color(0xff030712),
      body: Center(
        child: Container(
          height: height / 2,
          margin: EdgeInsets.symmetric(horizontal: width / 10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff242c42),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

            ],
          ),
        ),
      ),
    );
  }
  _loadSharedPref() async {
    String ipAddress = PreferenceUtils.getString('ipAddress', '192.168.1.');
    setState(() {
      _ipAddress = ipAddress;
      // _port = (prefs.getString('port') ?? '3000');
    });
  }

  _saveSharedPref(String value) async {
    PreferenceUtils.setString(sharedPrefKey, value);
  }

  _focused(){
    String value= "";
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
          value = '192.168.1.';
      } else {
        value = _ipAddress;
      }
    });

    setState(() {
      _ipAddress = value;
    });
  }

  _setServerSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _ipAddress = ipAddressTextFieldController.text;
      prefs.setString('ipAddress', _ipAddress);
      _port = portTextFieldController.text;
      prefs.setString('port', _port);
    });
  }


}
