import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserPositionCard extends StatelessWidget {

  int xCoordinate;
  int yCoordinate;
  int tileNumber;

  UserPositionCard({
    required this.xCoordinate,
    required this.yCoordinate,
    required this.tileNumber,
});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.bottomLeft,
      child: _customContainer(width, height)
    );
  }

  Widget _customContainer(double width, double height) {
    return Container(
      padding: EdgeInsets.all(5),
      width: width / 8,
      height: height / 5,
      child: _locationContainer(),
    );
  }

  Widget _locationContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _text("X: $xCoordinate"),
        _text("Y: $yCoordinate"),
        _text("Tile: $tileNumber"),
      ],
    );
  }

  Widget _text(String value){
    return Text(
      value,
      style: TextStyle(
        color: Color(0xff073980),
        fontSize: 14,
        fontWeight: FontWeight.bold
      ),
    );
  }
}
