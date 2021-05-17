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
      width: width * 2 / 5,
      height: height / 12,
      padding: EdgeInsets.all(width / 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2.0, color: Color(0xff43adb7))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon(Icons.location_on, color: Colors.white),
          Text(
              labelText,
              style: TextStyle(
                  color: Colors.grey,
                fontSize: 20
              )),
          Expanded(
              child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  )
              )
          )
        ],
      ),
    );
  }
}
