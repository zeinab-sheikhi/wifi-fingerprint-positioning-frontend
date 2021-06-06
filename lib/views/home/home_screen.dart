import 'package:access_point/test.dart';
import 'package:access_point/utils/data/location_service.dart';
import 'package:access_point/utils/data/preferences_util.dart';
import 'package:access_point/views/help/help_screen.dart';
import 'package:access_point/views/home/home_item_card.dart';
import 'package:access_point/views/offline_phase/offline_phase_map_viewer.dart';
import 'package:access_point/views/online_phase/online_phase_map_viewer.dart';
import 'package:access_point/views/settings/settings_screen.dart';
import 'package:access_point/views/wifi_scanner/wifi_screen.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:location/location.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  void initState() {
    PreferenceUtils.init();
    LocationService().checkPermissions().then((status) {
      if(status != PermissionStatus.granted)
        LocationService().requestPermission();
    });

    LocationService().checkService().then((status) {
      if(!status)
        LocationService().requestService();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(width, height),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: Color(0xff0b0f12),
      actions: [
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Color(0xfff5f5f5),
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Settings()),
            );
          },
        ),
      ],
    );
  }


  Widget _buildBody(double width, double height) {

    return SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff0b0f12),
                    Color(0xff111317),
                    Color(0xff0f1316),
                    Color(0xff181d21),
                    Color(0xff222931),
                    Color(0xff2f3841),
                    Color(0xff363e44)
                  ]
              )
          ),
          child: Column(
            children: [
              _appTitleContainer(width, height),
              _dashboardContainer(width, height),
            ],
          ),
        ));
  }

  Widget _appTitleContainer(double width, double height) {
    return Container(
      alignment: Alignment.center,
      height: height * 1 / 5,
      child: Image.asset(
        "assets/images/logo.png",
        width: width,
        fit: BoxFit.scaleDown,

      )
    );
  }

  Widget _dashboardContainer(double width, double height) {
    return Container(
      height: height * 3 / 5,
      width: width * 4 / 5,
      margin: EdgeInsets.symmetric(horizontal: width / 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _firstRow(width, height),
          _dividerContainer(width, height),
          _secondRow(width, height)
        ],
      ),
    );
  }

  Widget _firstRow(double width, double height) {
    return Container(
      height: width * 2 / 5 - height / 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HomeCard(
              goToRoute: OfflinePhaseMap(),
              titleText: 'OFFLINE PHASE',
              icon: Icons.place_outlined,
              width: width,
              height: height
          ),
          SizedBox(
              width: height / 20,
              height:width * 2 / 5 - height / 40,
              child: _verticalDivider()
          ),
          HomeCard(
              goToRoute: OnlinePhaseMap(),
              titleText: 'ONLINE PHASE',
              icon: Icons.person_search,
              width: width,
              height: height
          )
        ],
      ),
    );
  }

  Widget _dividerContainer(double width, double height) {
    return Container(
      width: width * 4 / 5,
      height: height / 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: width * 2 / 5 - height / 40,
              child:_horizontalDivider()
          ),
          SizedBox(
              width: height / 40,
              height: height / 40
          ),
          SizedBox(
            width: width * 2 / 5 - height / 40,
            child: _horizontalDivider(),
          ),
        ],),
    );
  }

  Widget _secondRow(double width, double height) {
    return Container(
      height: width * 2 / 5 - height / 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HomeCard(
              goToRoute: WiFiScanner(),
              titleText: 'Wi-Fi SCANNER',
              icon: Icons.wifi,
              width: width,
              height: height
          ),
          SizedBox(
              width: height / 20,
              height:width * 2 / 5 - height / 40,
              child: _verticalDivider()
          ),
          HomeCard(
              goToRoute: HelpScreen(),
              titleText: 'HELP',
              icon: Icons.help,
              width: width,
              height: height
          )
        ],
      ),
    );
  }
  Widget _horizontalDivider() {
    return Divider(color: Color(0xff8a8d94), thickness: 1);
  }

  Widget _verticalDivider() {
    return VerticalDivider(color: Color(0xff8a8d94), thickness: 1);
  }
}
