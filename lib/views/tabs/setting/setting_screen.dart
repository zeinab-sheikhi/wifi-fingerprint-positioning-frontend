
import 'package:access_point/constants.dart';
import 'package:access_point/utils/widgets/custom_server_setting_card.dart';
import 'package:access_point/utils/widgets/custom_time_setting_card.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackButton(
            color: Colors.white
        ),
        backgroundColor: Color(0xff111628),
      ),
      backgroundColor: Color(0xff111628),
      body: Center(
        child: Container(
            // margin: MediaQuery.of(context).viewInsets,
          // color: Colors.red,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingTimeCard(
                text: 'Total Scan Time(Second)',
                baseTime: 5,
                chooseTerm: Constants.chooseScanTime,
              ),
              SettingTimeCard(
                text: 'Time Interval(milliSecond)',
                baseTime: 100,
                chooseTerm: Constants.chooseIntervalTime,
              ),
              ServerSetting(title: 'IP Address', subTitle: '192.168.1.5',),
            ],
          ),
        ),
      ),
    );
  }
}
