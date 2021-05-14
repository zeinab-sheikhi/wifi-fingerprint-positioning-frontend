import 'dart:async';

import 'package:access_point/utils/custom_widgets/introduction_alert_dialog.dart';
import 'package:access_point/utils/preferences_util.dart';
import 'package:access_point/views/dashboard/home_item_card.dart';
import 'package:access_point/utils/custom_widgets/shapes/hexagon_shape.dart';
import 'package:access_point/views/screens/setting.dart';
import 'package:access_point/views/screens/online_phase.dart';
import 'package:access_point/views/settings/settings_screen.dart';
import 'package:access_point/views/wifi_scanner/wifi_screen.dart';
import 'package:access_point/views/offline_phase/offline_phase_screen.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    Timer.run(() => _showAlert(context));
    PreferenceUtils.init();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(appBar: _buildAppbar(), body: _buildBody(width, height));
  }

  AppBar _buildAppbar() {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Settings()),
            );
          },
        )
      ],
    );
  }

  Widget _buildBody(double width, double height) {
    return Center(
      child: Container(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _headerContainer(width, height),
            _firstRow(),
            _secondRow()
          ],
        ),
      ),
      // child: _options.elementAt(_selectedIndex),
    );
  }

  Widget _headerContainer(double width, double height) {
    return SizedBox(
      width: width * 3 / 4 + width / 10,
      height: height / 5 ,
      child: CustomPaint(
        painter: HexagonShape(shapeColor: Colors.white),
        child: Center(
          child: AutoSizeText(
            'WiFi Fing',
            style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        HomeCard(
          goToRoute: OfflinePhase(),
          titleText: 'Offline Phase',
          borderColor: Color(0xff27e8b9),
          icon: Icons.place_outlined,
        ),
        HomeCard(
          goToRoute: OnLinePhase(),
          titleText: 'Online Phase',
          borderColor: Color(0xffe17ecb),
          // icon: Icons.person_search,
          icon: Icons.online_prediction

        )
      ],
    );
  }

  Widget _secondRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        HomeCard(
          goToRoute: WiFiScanner(),
          titleText: 'WiFi Scanner',
          borderColor: Color(0xff946dae),
          icon: Icons.wifi,
        ),
        HomeCard(
          goToRoute: SettingScreen(),
          titleText: 'Read More',
          borderColor: Color(0xff3fd5dc),
          icon: Icons.read_more,
        )
      ],
    );
  }

  _showAlert(BuildContext context)  {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntroductionDialog(
            title: 'WiFi Fingerprint App',
            descriptions: 'For building Radio Map in Offline Phase and calculate location in Online phase\n'
                'Access to device Location must be granted',
            text: 'OK',
            img: 'assets/images/wifi.gif',
          );
        }
    );
  }

}
