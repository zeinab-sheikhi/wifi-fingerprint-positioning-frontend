import 'package:access_point/utils/data/preferences_util.dart';
import 'package:access_point/views/settings/settings_expanded_tile.dart';
import 'package:access_point/views/settings/settings_list_tile.dart';
import 'package:access_point/views/settings/settings_slider.dart';
import 'package:access_point/views/settings/settings_text_field.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:wifi_plugin/wifi_plugin.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool isSwitched = false;
  Color _color = Color(0xff5dfdcd);
  int _Tvalue = 0;
  int _Dvalue = 0;
  String _classificationGroupValue = "KNN";
  String _regressionGroupValue = "KNN";

  @override
  void initState() {

    _loadSharedPreferences();
    _isWifiEnable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context, width, height),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: AutoSizeText(
        'Settings',
        style: TextStyle(
            color: Colors.white
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildBody(BuildContext context, double width, double height) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height / 40),
              _wifiTile(width),
              SizedBox(height: height / 40),
              _offlinePhaseTile(width, height),
              SizedBox(height: height / 40),
              _serverTile(context, width, height),
              SizedBox(height: height / 40),
              _classificationModelsTile(context, width),
              SizedBox(height: height / 40),
              _regressionModelsTile(context, width),
            ],
          ),
        )
      ]
    );
  }

  Widget _tileLeadingIcon(IconData iconData, double width) {
    return Icon(
      iconData,
      size: width / 12,
      color: _color
    );
  }

  Widget _wifiTile(double width) {
    return SettingsListTile(
        title: 'Wi-Fi',
        subtitle: isSwitched? 'Toggle to Disable WiFi' : 'Toggle to Enable WiFi',
        leadingIcon: _tileLeadingIcon(Icons.wifi, width),
        trailingWidget: _wifiSwitch(),
        );
  }

  Widget _wifiSwitch() {
    return Switch(
        value: isSwitched,
        onChanged: (bool value) {
          setState(() {
            isSwitched = value;
            Wifi.enableWiFi(isSwitched);
          });
        },
        activeColor: Colors.white,
        activeTrackColor: _color,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: Color(0x80B0B0B0)
    );
  }

  Widget _offlinePhaseTile(double width, double height) {
    return SettingExpandedTile(
        title: 'Offline Phase',
        subtitle: 'Total Scan Time, Interval Time',
        leadingIcon: _tileLeadingIcon(MdiIcons.tune, width),
        accentColor: _color,
        childrenWidgets: [
          _sliderContainer(
              width,
              height,
              'T',
              5,
              30,
              5,
              'scanTime',
              _Tvalue
          ),
          Divider(color: Colors.grey, indent: width / 20, endIndent: width / 20),
          _sliderContainer(
              width,
              height,
              'D',
              500,
              3000,
              5,
              'intervalTime',
              _Dvalue
          ),
          Divider(color: Colors.grey, indent: width / 20, endIndent: width / 20),
        ],
    );
  }

  Widget _sliderContainer(double width, double height, String title,
      double min, double max, int division, String key, int value) {
    return Container(
      alignment: Alignment.center,
      height: height / 12,
      margin: EdgeInsets.symmetric(horizontal: width / 20),
      color: Color(0xff242c42),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _sliderTitleContainer(title, width),
          Expanded(
            flex: 1,
            child: SettingsSlider(
              max: max,
              min: min,
              division: division,
              value: value,
              sharedPreferencesKey: key,
            ),
          ),
        ],
      )
    );
  }

  Widget _sliderTitleContainer(String title, double width) {
    return Container(
      width: width / 12,
      height: width / 12,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2
        ),
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
  

  Widget _serverTile(BuildContext context, double width, double height) {
    return SettingExpandedTile(
        title: 'Server',
        subtitle: 'IP Address, Port',
        leadingIcon: _tileLeadingIcon(MdiIcons.databaseCog, width),
        accentColor: _color,
        childrenWidgets: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: width / 20, vertical: width / 40),
            child: SettingsTextField(
                sharedPrefKey: 'ipAddress',
                defaultValue: '192.168.1.1',
                errorText: "check your input",
                labelText: 'IP Address',
                textColor: Colors.white,
                cursorColor: Colors.grey,
                enableColor: _color,
                disableColor: Colors.transparent,
                focusedColor: _color,
                errorColor: Colors.red,
                contentPadding: width / 20,
                isIP: true
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: width / 20, vertical: width / 40),
            child: SettingsTextField(
                sharedPrefKey: 'port',
                defaultValue: '3000',
                errorText: "check your input",
                labelText: 'Port',
                textColor: Colors.white,
                cursorColor: Colors.grey,
                enableColor: _color,
                disableColor: Colors.transparent,
                focusedColor: _color,
                errorColor: Colors.red,
                contentPadding: width / 20,
                isIP: false
            ),
          )
        ],
    );
  }

  Widget _classificationModelsTile(BuildContext context, double width) {
    return SettingExpandedTile(
        title: "Classification Model",
        subtitle: _classificationGroupValue,
        leadingIcon: _tileLeadingIcon(Icons.account_tree, width),
        accentColor: _color,
        childrenWidgets: [
          _radioButton("Catboost", "classificationModel", true),
          _radioButton("KNN", "classificationModel", true),
          _radioButton("Random Forest", "classificationModel", true)
        ]
    );
  }

  Widget _regressionModelsTile(BuildContext context, double width) {

    return SettingExpandedTile(
        title: "Regression Model",
        subtitle: _regressionGroupValue,
        leadingIcon: _tileLeadingIcon(Icons.account_tree, width),
        accentColor: _color,
        childrenWidgets: [
          _radioButton("Decision Tree", "regressionModel", false),
          _radioButton("Decision Tree(Distinct)", "regressionModel", false),
          _radioButton("Extra Trees", "regressionModel", false),
          _radioButton("Extra Trees(Distinct)", "regressionModel", false),
          _radioButton("KNN", "regressionModel", false),
        ]
    );
  }

  Widget _radioButton(String value, String key, bool isClassification) {

    return RadioListTile(
        title: Text(
            value,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14
            )
        ),
        value: value,
        groupValue: isClassification? _classificationGroupValue : _regressionGroupValue,
        activeColor: _color,
        onChanged: (newValue) {
          setState(() {
            if(isClassification)
              _classificationGroupValue = newValue.toString();
            else
              _regressionGroupValue = newValue.toString();
            PreferenceUtils.setString(key, value);
          });
        }
    );
  }


  _isWifiEnable() async{
    bool result = await Wifi.isWiFiEnable;
    setState(() {
      isSwitched = result;
    });
  }

  _loadSharedPreferences() async {
    int Tvalue = PreferenceUtils.getInt('scanTime', 20);
    int Dvalue = PreferenceUtils.getInt('intervalTime', 1000);
    String _classificationModel = PreferenceUtils.getString("classificationModel", "KNN");
    String _regressionModel = PreferenceUtils.getString("regressionModel", "KNN");
    setState(() {
      _Tvalue = Tvalue;
      _Dvalue = Dvalue;
      _classificationGroupValue = _classificationModel;
      _regressionGroupValue = _regressionModel;
    });
  }
}
