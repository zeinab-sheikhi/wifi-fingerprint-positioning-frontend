import 'package:access_point/utils/preferences_util.dart';
import 'package:access_point/views/settings/expansion_tile.dart';
import 'package:access_point/views/settings/list_tile.dart';
import 'package:access_point/views/settings/slider.dart';
import 'package:access_point/utils/color_utils.dart' as colors;
import 'package:access_point/views/settings/text_field.dart';
import 'package:access_point/views/widgets/my_icons.dart' as icons;
import 'package:access_point/utils/string_utils.dart' as strings;
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
  Color _color = colors.accentColor;
  int _Tvalue = 0;
  int _Dvalue = 0;
  String _classificationGroupValue = strings.knn;
  String _regressionGroupValue = strings.knn;

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
        strings.settings,
        style: TextStyle(
            color: colors.primaryColor
        ),
      ),
      leading: IconButton(
        icon: Icon(
          icons.backArrow,
          color: colors.primaryColor,
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
        title: strings.wifi,
        subtitle: isSwitched? strings.disableWifi : strings.enableWifi,
        leadingIcon: _tileLeadingIcon(icons.wifi, width),
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
        activeColor: colors.primaryColor,
        activeTrackColor: _color,
        inactiveThumbColor: colors.primaryColor,
        inactiveTrackColor: colors.inactiveSwitch
    );
  }

  Widget _offlinePhaseTile(double width, double height) {
    return SettingExpandedTile(
        title: strings.offlinePhase,
        subtitle: 'Total Scan Time, Interval Time',
        leadingIcon: _tileLeadingIcon(MdiIcons.tune, width),
        accentColor: _color,
        childrenWidgets: [
          _sliderContainer(
              width,
              height,
              strings.t,
              5,
              30,
              5,
              strings.scanTime,
              _Tvalue
          ),
          Divider(color: colors.grey, indent: width / 20, endIndent: width / 20),
          _sliderContainer(
              width,
              height,
              strings.d,
              500,
              3000,
              5,
              strings.intervalTime,
              _Dvalue
          ),
          Divider(color: colors.grey, indent: width / 20, endIndent: width / 20),
        ],
    );
  }

  Widget _sliderContainer(double width, double height, String title,
      double min, double max, int division, String key, int value) {
    return Container(
      alignment: Alignment.center,
      height: height / 12,
      margin: EdgeInsets.symmetric(horizontal: width / 20),
      color: colors.primaryColorLight,
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
          color: colors.primaryColor,
          width: 2
        ),
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Text(
        title,
        style: TextStyle(color: colors.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
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
              sharedPrefKey: strings.ipAddress,
              defaultValue: strings.defaultIpAddress,
              errorText: strings.checkInput,
              labelText: strings.ipAddressTitle,
              textColor: colors.primaryColor,
              cursorColor: colors.grey,
              enableColor: _color,
              disableColor: Colors.transparent,
              focusedColor: _color,
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
              enableColor: _color,
              disableColor: Colors.transparent,
              focusedColor: _color,
              errorColor: colors.error,
              contentPadding: width / 20,
              isIP: false
          ),
        )
      ],
    );
  }


  Widget _classificationModelsTile(BuildContext context, double width) {
    return SettingExpandedTile(
        title: strings.classificationModel,
        subtitle: _classificationGroupValue,
        leadingIcon: _tileLeadingIcon(icons.mlAlgorithm, width),
        accentColor: _color,
        childrenWidgets: [
          _radioButton(strings.catboost, strings.classification, true),
          _radioButton(strings.knn, strings.classification, true),
          _radioButton(strings.randomForest, strings.classification, true)
        ]
    );
  }

  Widget _regressionModelsTile(BuildContext context, double width) {

    return SettingExpandedTile(
        title: strings.regressionModel,
        subtitle: _regressionGroupValue,
        leadingIcon: _tileLeadingIcon(icons.mlAlgorithm, width),
        accentColor: _color,
        childrenWidgets: [
          _radioButton(strings.decisionTree, strings.regression, false),
          _radioButton(strings.decisionTreeDistinct, strings.regression, false),
          _radioButton(strings.extraTree, strings.regression, false),
          _radioButton(strings.extraTreeDistinct, strings.regression, false),
          _radioButton(strings.knn, strings.regression, false),
        ]
    );
  }

  Widget _radioButton(String value, String key, bool isClassification) {

    return RadioListTile(
        title: Text(
            value,
            style: TextStyle(
                color: colors.primaryColor,
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
    int Tvalue = PreferenceUtils.getInt(strings.scanTime, 20);
    int Dvalue = PreferenceUtils.getInt(strings.intervalTime, 1000);
    String _classificationModel = PreferenceUtils.getString(strings.classification, strings.knn);
    String _regressionModel = PreferenceUtils.getString(strings.regression, strings.knn);
    setState(() {
      _Tvalue = Tvalue;
      _Dvalue = Dvalue;
      _classificationGroupValue = _classificationModel;
      _regressionGroupValue = _regressionModel;
    });
  }
}
