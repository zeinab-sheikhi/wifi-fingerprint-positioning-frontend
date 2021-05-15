import 'package:access_point/utils/data/location_service.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:location/location.dart';


class OnLinePhase extends StatefulWidget {
  @override
  _OnLinePhaseState createState() => _OnLinePhaseState();
}

class _OnLinePhaseState extends State<OnLinePhase> {

  @override
  void initState() {
    super.initState();
  }

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

    return Scaffold(
      backgroundColor: Color(0xff030712),
      body: Center(
        child: Container(
          height: height / 2,
          width: width,
          margin: EdgeInsets.symmetric(horizontal: width / 10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff242c42),
          ),
          child: SingleChildScrollView(
            child: Container(

              padding: EdgeInsets.symmetric(vertical: width / 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  <Widget>[
                  // PermissionStatusWidget(),
                  // Divider(color: Colors.white,),
                  // ServiceEnabledWidget(),
                  // Divider(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
