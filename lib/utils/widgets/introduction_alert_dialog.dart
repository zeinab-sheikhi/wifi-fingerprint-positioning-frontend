import 'package:access_point/permission_service.dart';
import 'package:flutter/material.dart';
import 'package:wifi_plugin/wifi_plugin.dart';

class IntroductionDialog extends StatefulWidget {
  final String title, descriptions, text;
  final String img;

  IntroductionDialog(
      {
        required this.title,
        required this.descriptions,
        required this.text,
        required this.img
      });

  @override
  _IntroductionDialogState createState() => _IntroductionDialogState();
}

class _IntroductionDialogState extends State<IntroductionDialog> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(10),
      child: contentBox(context, width, height),
    );
  }

  contentBox(context, width, height){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: 20,top: 45
              + 20, right: 20,bottom: 20
          ),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Text(widget.descriptions,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: (){
                      Wifi.enableWiFi();
                      Navigator.of(context).pop();
                      PermissionsService().requestLocationPermission();
                    },
                    child: Text(widget.text,style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(45)),
                child: Image.asset(widget.img)
            ),
          ),
        ),
      ],
    );
  }


}
