import 'package:flutter/material.dart';

class CurveShape extends CustomPainter {
  Color shapeColor;
  CurveShape({
    required this.shapeColor
  });
  @override
  void paint(Canvas canvas, Size size) {

    Path p = getPath(size);
    Paint paint = Paint();
    paint.strokeWidth = 3;
    paint.style = PaintingStyle.fill;
    paint.color = shapeColor;
    paint.strokeJoin = StrokeJoin.round;
    canvas.drawPath(p,paint);
  }
  Path getPath(Size size) {

    var width = size.width ;
    var height = size.height;
    final path = Path();
    path.moveTo(0, height * 0.8);
    path.quadraticBezierTo(width * 0.25, height * 0.7,
        width * 0.5, height * 0.8);
    path.quadraticBezierTo(width * 0.75, height * 0.9,
        width * 1.0, height * 0.85);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();
    return path;
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}