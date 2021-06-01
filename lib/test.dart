import 'package:access_point/views/home/home_item_card.dart';
import 'package:access_point/views/offline_phase/offline_phase_map_viewer.dart';
import 'package:access_point/views/online_phase/online_phase_map_viewer.dart';
import 'package:access_point/views/settings/settings_screen.dart';
import 'package:access_point/views/wifi_scanner/wifi_screen.dart';
import 'package:flutter/material.dart';

class HomeTest extends StatefulWidget {
  @override
  _HomeTestState createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _buildBody(width, height),
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
                Color(0xff181d21),
                Color(0xff222931),
                Color(0xff2f3841),
                Color(0xff363e44)
              ]
            )
          ),
          child: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.scaleDown,
            height: height * 1 / 3,
            width: width,

          )
        ));
  }

  Widget _appTitleContainer(double width, double height) {
    return Container(
      alignment: Alignment.center,
      height: height * 1 / 5,
      child: Text(
        'WHERE AM I',
        style: TextStyle(
            color: Colors.white,
            fontSize: 40)
      ),
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
              goToRoute: OnlinePhaseMap(),
              titleText: 'READ MORE',
              icon: Icons.read_more,
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
