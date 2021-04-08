import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final Icon icon;
  final Function onPressed;
  final double width;
  final double height;

  RoundButton({
    required this.icon,
    required this.onPressed,
    required this.width,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: icon,
      onPressed: () {onPressed();},
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ),
      fillColor: Color(0xFF1d347b),
      constraints: BoxConstraints.tightFor(
        width: height / 25,
        height: height / 25,
      ),
    );
  }
}
