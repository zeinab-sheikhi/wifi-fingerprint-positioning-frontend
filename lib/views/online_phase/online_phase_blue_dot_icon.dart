import 'package:flutter/material.dart';


class BlueDotIcon extends StatefulWidget {


  @override
  _BlueDotIconState createState() => _BlueDotIconState();
}

class _BlueDotIconState extends State<BlueDotIcon> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _glowingContainer(width, height);
  }

  Widget _glowingContainer(double width, double height) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff073980),
          boxShadow: [
            BoxShadow(
              color: Color(0xff1e81b0),
              blurRadius: 3,
              spreadRadius: 4
          )]
      ),
    );
  }
}



