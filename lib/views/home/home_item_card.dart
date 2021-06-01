import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeCard extends StatelessWidget {

  Widget goToRoute;
  String titleText;
  IconData icon;
  double width;
  double height;

  HomeCard({
    required this.goToRoute,
    required this.titleText,
    required this.icon,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  goToRoute,
          ),
        );
      },
      child: Container(
        width: width * 2 / 5 - height / 40,
        height: height * 11 / 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon,
              color: Color(0xff5dfdcd),
              size: width / 5
            ),
            AutoSizeText(
              titleText,
              maxLines: 1,
              style: TextStyle(
                  color: Color(0xfff4fbfe),
                  fontSize: 14
              ),
            )
          ],
        ),
      ),
    );
  }
}
