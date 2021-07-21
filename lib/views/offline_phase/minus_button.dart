import 'package:flutter/material.dart';
import 'package:access_point/utils/color_utils.dart' as colors;

typedef void MinusCallBack(int val);

class MinusButton extends StatelessWidget {

  MinusCallBack callBack;
  IconData icon;
  MinusButton({required this.icon, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          onPressed: ()=> callBack(-40),
          child: Icon(icon, color: colors.accentDarkColor),
          style: ElevatedButton.styleFrom(
              primary: colors.backgroundColor,
              shape: CircleBorder(),
              side: BorderSide(width: 2.0, color: colors.accentDarkColor)
          )
      ),
    );
  }
}
