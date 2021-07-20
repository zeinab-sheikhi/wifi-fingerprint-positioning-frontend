import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:access_point/utils/color_utils.dart' as colors;

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {

  String hintText;
  String labelText;
  Icon prefixIcon;
  TextEditingController controller;
  TextInputType keyboardType;
  double fontSize;
  Color textColor;
  Color fillColor;

  MyTextField({
    this.fontSize = 18,
    this.textColor = colors.primaryColor,
    this.fillColor = colors.textFieldFill,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    required this.keyboardType
});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        style: TextStyle(
            color: colors.primaryColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold
        ),
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: colors.primaryColor
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: colors.orange),
            ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: colors.accentDarkColor
            ),
          ),
            prefixIcon: prefixIcon,
            contentPadding: EdgeInsets.only(),
            fillColor: fillColor,
            filled: true,
            hintText: hintText,
            labelText: labelText
        ),
        keyboardType: keyboardType,
        controller: controller,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }

}