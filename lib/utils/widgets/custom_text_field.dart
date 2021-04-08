import 'package:flutter/material.dart';

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
    this.fontSize = 20,
    this.textColor = Colors.white,
    this.fillColor = const Color(0xff29292e),
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
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: Color(0xff3ed9dc)
            ),
          ),
            prefixIcon: prefixIcon,
            contentPadding: EdgeInsets.only(),
            fillColor: fillColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: Color(0xff3ed9dc)
              ),
            ),
            hintText: hintText
        ),
        keyboardType: keyboardType,
        controller: controller,

      ),
    );
  }
}