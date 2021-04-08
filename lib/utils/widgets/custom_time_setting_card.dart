import 'package:flutter/material.dart';

import 'custom_round_button.dart';

class SettingTimeCard extends StatefulWidget {
  @override
  _SettingTimeCardState createState() => _SettingTimeCardState();
}

class _SettingTimeCardState extends State<SettingTimeCard> {
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height / 8,
      child: Card(
        elevation: 2,
        margin: new EdgeInsets.symmetric(vertical: 6.0),
        color: Color(0xff242c42),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(
            'Total Scan Time',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),
          ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                RoundButton(icon: Icon(Icons.remove_rounded, color: Color(0xfffdfeff),), onPressed: () {print('minus');}, width: width, height: height),
                Text('100',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                RoundButton(icon: Icon(Icons.add, color: Color(0xfffdfeff),), onPressed: () {print('Plus');}, width: width, height: height),
              ],
            ),
            ]
          ),
        ),
      ),
    );
  }

}
