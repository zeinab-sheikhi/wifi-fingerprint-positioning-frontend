import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeCard extends StatelessWidget {

  Widget goToRoute;
  String titleText;
  Color borderColor;
  IconData icon;

  HomeCard({
    required this.goToRoute,
    required this.titleText,
    required this.borderColor,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  goToRoute,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: borderColor
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: width / 3,
        height: width / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: width / 4,
            ),
            Text(
              titleText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),
            )
          ],
        ),
      ),
    );
  }
}
