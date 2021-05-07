import 'dart:async';

import 'package:access_point/utils/preferences_util.dart';
import 'package:access_point/utils/widgets/custom_home_item_card.dart';
import 'package:access_point/utils/widgets/hexagon_shape.dart';
import 'package:access_point/utils/widgets/introduction_alert_dialog.dart';
import 'package:access_point/views/tabs/setting.dart';
import 'package:access_point/views/tabs/offline_phase.dart';
import 'package:access_point/views/tabs/online_phase.dart';
import 'package:access_point/views/tabs/wifi_scanner.dart';
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
    Timer.run(() => showAlert(context));
    PreferenceUtils.init();

  }

  showAlert(BuildContext context)  {
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
      appBar: AppBar(
        backgroundColor: Color(0xff3e3f44),
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
                MaterialPageRoute(builder: (context) => SettingScreen()),
              );
              },
          )
        ],
      ),
      body: Center(
        child: Container(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
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
              ),
              Row(
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
                      icon: Icons.person_search,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeCard(
                    goToRoute: WiFiScanner(),
                    titleText: 'WiFi Scanner',
                    borderColor: Color(0xff946dae),
                    icon: Icons.wifi,
                  ),
                  HomeCard(
                      goToRoute: OnLinePhase(),
                      titleText: 'Read More',
                      borderColor: Color(0xff3fd5dc),
                      icon: Icons.read_more,
                  )
                ],
              ),
            ],
          ),
        ),
        // child: _options.elementAt(_selectedIndex),
      ),
    );
  }

}
