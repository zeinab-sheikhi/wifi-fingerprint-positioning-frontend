// ignore: import_of_legacy_library_into_null_safe
import 'package:access_point/utils/data/helper.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WifiInfoDialog extends StatelessWidget {

  Color iconColor;
  String ssid;
  String bssid;
  String band;
  String signal;
  String channel;

  WifiInfoDialog({
    required this.iconColor,
    required this.ssid,
    required this.bssid,
    required this.band,
    required this.signal,
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _infoDialog(width, height, context);
  }

  Widget _infoDialog(double width, double height, BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        height: height * 2 / 4,
        padding: EdgeInsets.symmetric(horizontal: width / 100),
        decoration: BoxDecoration(
          color: Color(0xff242c42),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
        ),
        child: _infoContainer(width, height, context),
      ),
    );
  }

  Widget _infoContainer(double width, double height, BuildContext context) {

    const List<String> _titles = ['SSID', 'BSSID', 'Band', 'Signal', 'Channel'];
    List<String> _values = [ssid, bssid, '${Helper.getChannel(band)} GHz', '${signal} dBm', 'Ch #${channel}(${band} MHz)'];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _wifiIconContainer(width, height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _customColumn(_titles, iconColor, true, height),
              _customColumn(_values, Colors.grey, false, height),
            ],
          ),
          _closeButtonContainer(context)
        ],
      ),
    );
  }

  Widget _wifiIconContainer(double width, double height) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: height / 100),
      child: ColorFiltered(
        child: Image.asset(
          'assets/images/wifi-signal.png',
          width: width / 5,
          height: width / 5,
          fit: BoxFit.cover,
        ),
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
    );
  }

  Widget _customColumn(List<String> itemText, Color textColor, bool isLeading, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: isLeading? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        _titleText(itemText[0], textColor),
        SizedBox(height: height / 50),
        _titleText(itemText[1], textColor),
        SizedBox(height: height / 50),
        _titleText(itemText[2], textColor),
        SizedBox(height: height / 50),
        _titleText(itemText[3], textColor),
        SizedBox(height: height / 50),
        _titleText(itemText[4], textColor),
      ],
    );
  }

  Widget _titleText(String title, Color textColor) {
    return AutoSizeText(
        title,
      maxLines: 1,
      style: TextStyle(
        color: textColor,
        fontSize: 18
      ),
    );
  }
  
  Widget _closeButtonContainer(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: Text('close',style: TextStyle(fontSize: 18, color: iconColor),)),
    );
  }

}
