import 'package:access_point/utils/data/string_utils.dart';
import 'package:access_point/utils/custom_widgets/custom_server_setting_card.dart';
import 'package:access_point/utils/custom_widgets/custom_time_setting_card.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: BackButton(
          color: Colors.white
      ),
      title: Text('Setting', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingParameterCard(
              title: 'Total Scan Time(S)',
              supplement: 5,
              parameter: StringUtils.parameterT,
            ),
            SettingParameterCard(
              title: 'Time Interval(mS)',
              supplement: 100,
              parameter: StringUtils.parameterD,
            ),
            SettingParameterCard(
                title: "X",
                supplement: 1,
                parameter: StringUtils.parameterX
            ),
            ServerSetting(title: 'IP Address', subTitle: '192.168.1.5',),
          ],
        ),
      ),
    );
  }
}
