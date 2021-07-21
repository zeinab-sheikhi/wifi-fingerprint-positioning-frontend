import 'package:access_point/utils/preferences_util.dart';
import 'package:access_point/views/settings/offline_phase_tile.dart';
import 'package:access_point/views/settings/server_tile.dart';
import 'package:access_point/views/settings/wifi_tile.dart';
import 'package:access_point/utils/color_utils.dart' as colors;
import 'package:access_point/views/widgets/my_expansion_tile.dart';
import 'package:access_point/views/widgets/my_icons.dart' as icons;
import 'package:access_point/utils/string_utils.dart' as strings;
import 'package:access_point/views/widgets/my_tile_icon.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _classificationGroupValue = strings.knn;
  String _regressionGroupValue = strings.knn;

  @override
  void initState() {
    _loadSharedPreferences();
    super.initState();
  }

  _loadSharedPreferences() async {
    String _classificationModel = PreferenceUtils.getString(strings.classification, strings.knn);
    String _regressionModel = PreferenceUtils.getString(strings.regression, strings.knn);
    setState(() {
      _classificationGroupValue = _classificationModel;
      _regressionGroupValue = _regressionModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _appBar(),
      body: _body(height),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: AutoSizeText(strings.settings, style: TextStyle(color: colors.primaryColor)),
      leading: IconButton(
        icon: Icon(icons.backArrow, color: colors.primaryColor),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _body(double height) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height / 40),
              WifiTile(),
              SizedBox(height: height / 40),
              OfflinePhaseTile(),
              SizedBox(height: height / 40),
              ServerTile(),
              SizedBox(height: height / 40),
              _classificationModelsTile(),
              SizedBox(height: height / 40),
              _regressionModelsTile()
            ],
          ),
        )
      ]
    );
  }
  Widget _classificationModelsTile() {
    return SettingExpandedTile(
        title: strings.classificationModel,
        subtitle: _classificationGroupValue,
        leadingIcon: TileLeadingIcon(iconData: icons.mlAlgorithm),
        accentColor: colors.accentColor,
        childrenWidgets: [
          _radioButton(strings.catboost, strings.classification, true),
          _radioButton(strings.knn, strings.classification, true),
          _radioButton(strings.randomForest, strings.classification, true)
        ]
    );
  }

  Widget _regressionModelsTile() {
    return SettingExpandedTile(
        title: strings.regressionModel,
        subtitle: _regressionGroupValue,
        leadingIcon: TileLeadingIcon(iconData: icons.mlAlgorithm),
        accentColor: colors.accentColor,
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
            style: TextStyle(color: colors.primaryColor, fontSize: 14)
        ),
        value: value,
        groupValue: isClassification? _classificationGroupValue : _regressionGroupValue,
        activeColor: colors.accentColor,
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
}
