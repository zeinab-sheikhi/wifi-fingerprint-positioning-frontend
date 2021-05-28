import 'package:flutter/material.dart';
class CoordinateTextField extends StatelessWidget {

  String text;
  String labelText;
  CoordinateTextField(
      { required this.text,
        required this.labelText
      });

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _coordinateTextField(width, height);
  }

  Widget _coordinateTextField(double width, double height)
  {
    return Container(
      width: width / 3,
      height: height / 10,
      padding: EdgeInsets.all(width / 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2.0, color: Color(0xff43adb7))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              labelText,
              style: TextStyle(
                  color: Colors.grey,
                fontSize: 16
              )),
          Expanded(
              child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                  )
              )
          )
        ],
      ),
    );
  }
}
