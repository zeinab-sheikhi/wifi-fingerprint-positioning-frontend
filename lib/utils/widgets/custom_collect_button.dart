import 'package:access_point/utils/widgets/pentagon_shape.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CollectButton extends StatelessWidget {

  final Function callBack;
  double widthSize;
  double heightSize;
  double fontSize;
  bool loading;


  CollectButton({

    required this.widthSize,
    required this.heightSize,
    required this.fontSize,
    required this.callBack,
    this.loading = false

  });

  @override
  Widget build(BuildContext context) {

    return
      SizedBox(
        width:  widthSize,
        height: heightSize,
        child: InkWell(
          onTap: () {
            if(loading) callBack();
          },
          child: CustomPaint(
            painter: PentagonShape(lineColor: Color(0xff20ab1c),),
            child: Center(
              child: Icon(
                Icons.check,
                color: Color(0xff105111),
                size: 50,
              ),
    ),
    ),
        ),
      );
  }
}
