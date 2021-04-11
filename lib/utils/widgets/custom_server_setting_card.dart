
import 'package:access_point/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  String _ipAddress = "";
  String _port = "";

  @override
  void initState() {
    super.initState();
    _loadServerSettings();
  }


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
          backgroundColor: Color(0xff111628),
          contentPadding: const EdgeInsets.all(16.0),
          content:  Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: MyTextField(
                    hintText: _ipAddress,
                    labelText: 'IP Address',
                    prefixIcon: Icon(Icons.edit_outlined, color: Color(0xff43adb7),),
                    controller: ipAddressTextFieldController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false
                    )
                ),
              ),
              MyTextField(
                  hintText: _port,
                  labelText: 'Port',
                  prefixIcon: Icon(Icons.edit_outlined, color: Color(0xff43adb7),),
                  controller: portTextFieldController,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false
                  )
              )
            ],
          ),
          actions: <Widget>[
             ElevatedButton(
                child: const Text('CANCEL', style: TextStyle(color: Color(0xff43adb7),),),
                onPressed: () {
                  Navigator.pop(context);
                }),
            ElevatedButton(
                child: const Text('OK', style: TextStyle(color: Color(0xff43adb7),)),
                onPressed: () {
                  setServerSetting();
                  Navigator.pop(context);
                })
          ],
        );
      }
    );
  }
  _loadServerSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _ipAddress = (prefs.getString('ipAddress') ?? '192.168.1.3');
      _port = (prefs.getString('port') ?? '3005');
    });
  }
  setServerSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _ipAddress = ipAddressTextFieldController.text;
      prefs.setString('ipAddress', _ipAddress);
      _port = portTextFieldController.text;
      prefs.setString('port', _port);
    });
    print(_ipAddress + ":" + _port);

  }

}


