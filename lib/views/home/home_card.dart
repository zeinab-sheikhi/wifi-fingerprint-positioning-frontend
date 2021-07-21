import 'package:flutter/material.dart';
import 'package:access_point/utils/color_utils.dart' as colors;
// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';

class HomeCard extends StatelessWidget {
  Widget goToRoute;
  String titleText;
  IconData icon;

  HomeCard({
    required this.goToRoute,
    required this.titleText,
    required this.icon});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              color: colors.accentColor,
              size: width / 5
            ),
            AutoSizeText(
              titleText,
              maxLines: 1,
              style: TextStyle(
                  color: colors.homeItemText,
                  fontSize: 14
              ),
            )
          ],
        ),
      ),
    );
  }
}
