
import 'package:access_point/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';


// ignore: must_be_immutable
class ServerSetting extends StatefulWidget {
  String title;
  String subTitle;
  ServerSetting({
    required this.title,
    required this.subTitle
}
      );
  @override
  _ServerSettingState createState() => _ServerSettingState();
}

class _ServerSettingState extends State<ServerSetting> {

  final TextEditingController ipAddressTextFieldController = TextEditingController();
  final TextEditingController portTextFieldController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        _showDialog(context, MediaQuery);
      },
      child: SizedBox(
          height: height / 8,
          width: width,
          child: Card(
              elevation: 2,
              margin: new EdgeInsets.symmetric(vertical: 6.0),
              color: Color(0xff242c42),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),

          ),
      ),
    );
  }
  _showDialog(context, mediaQuery) async {
    await showDialog(
      context: context,
      builder:(context) {
        return AlertDialog(
          // backgroundColor: Color(0xff15317c),
          contentPadding: const EdgeInsets.all(16.0),
          content:  Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: MyTextField(
                    hintText: '192.168.1.3',
                    labelText: 'IP Address',
                    prefixIcon: Icon(Icons.edit_outlined, color: Colors.white,),
                    controller: ipAddressTextFieldController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false
                    )
                ),
              ),
              MyTextField(
                  hintText: '3005',
                  labelText: 'Port',
                  prefixIcon: Icon(Icons.edit_outlined, color: Colors.white,),
                  controller: portTextFieldController,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false
                  )
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      }
    );
  }
}


