import 'package:access_point/utils/data/helper.dart';
import 'package:flutter/material.dart';

import 'offline_phase_screen.dart';

// ignore: must_be_immutable
class MyAlertDialog extends StatelessWidget {

  Color color;
  MyAlertDialog({required this.color});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xff030712),
      insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: color, width: 2),
          borderRadius: BorderRadius.circular(10)
      ),
      title: _titleText(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OfflinePhase(),
        ],
      ),
      actions: <Widget>[
        _okActionButton(context)
      ],
    );
  }

  Widget _titleText() {
    return Text(
      'Add Location Coordinates',
      style: TextStyle(
          color: color,
          fontSize: 20
      ),
    );
  }

  Widget _okActionButton(BuildContext context) {
    return TextButton(
      child: Text(
        'OK',
        style: TextStyle(
            color: color
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        Helper.changeScreenToLandscape();
      },
    );
  }
}
