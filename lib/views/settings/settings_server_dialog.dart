import 'package:access_point/utils/views/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServerSettingDialog extends StatefulWidget {

  BuildContext buildContext;
  ServerSettingDialog({required this.buildContext});

  @override
  _ServerSettingDialogState createState() => _ServerSettingDialogState();
}

class _ServerSettingDialogState extends State<ServerSettingDialog> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: _serverDialog(widget.buildContext, width, height),
    );
  }

  Widget _serverDialog(BuildContext context, double width, double height) {
    return AlertDialog(
      backgroundColor: Color(0xff111628),
      contentPadding: EdgeInsets.symmetric(horizontal: width / 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      content: _dialogContent(width, height),
      actions: [
        _dialogButton(
            'Cancel',
             () {
              Navigator.pop(context);
            }
            ),
        _dialogButton(
            'OK',
                () {Navigator.pop(context);}
        )
      ],
    );
  }

  Widget _dialogContent(double width, double height) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: width / 100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height / 40,),

          SizedBox(height: height / 50,),

        ],
      ),
    );
  }

  Widget _dialogButton(String text, Function action) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent
        ),
        child: Text(text, style: TextStyle(color: Color(0xff43adb7))),
        onPressed: () => action
    );
  }
}
