import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.textColor = Colors.white,
    this.fillColor = const Color(0xff0242c42),
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
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold
        ),
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.white
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.orange),
            ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: Color(0xff43adb7)
            ),
          ),
            prefixIcon: prefixIcon,
            contentPadding: EdgeInsets.only(),
            fillColor: fillColor,
            filled: true,
            hintText: hintText,
            // hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
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