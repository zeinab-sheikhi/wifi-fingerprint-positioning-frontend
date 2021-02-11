import 'dart:async';

import 'package:access_point/home.dart';
import 'package:access_point/model/point.dart';
import 'package:flutter/material.dart';
import 'package:wifi/wifi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wifi',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColorDark:Colors.black ,
        primaryColor:Colors.white ,
        primaryColorLight: Color.fromRGBO(130, 130, 130, 1),
        accentColor: Color.fromRGBO(0, 167, 157, 1),
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        textSelectionColor: Color.fromRGBO(224, 224, 224, 1).withOpacity(0.5),
        textSelectionHandleColor: Color.fromRGBO(160, 160, 160, 1),
        cardColor: Color.fromRGBO(54, 54, 54, 1),
        disabledColor:  Color.fromRGBO(108, 108, 108, 1),
        unselectedWidgetColor: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: Home(),
    );
  }
  static double HEIGHT(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double WIDTH(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double TITLE_FONT() {
    return 15;
  }
  static double LARGE_TITLE_FONT() {
    return 18;
  }
  static double EXTRA_LARGE_TITLE_FONT() {
    return 25;
  }
  static double MAIN_FONT() {
    return 13;
  }
  static double SMALL_FONT() {
    return 11;
  }
  static double VERY_SMALL_FONT() {
    return 9;
  }
}

// class _MyHomePageState extends State<MyHomePage> {
//
//   int rssi = 0;
//   List<WifiResult> ssidList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Wifi'),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                   border: InputBorder.none, hintText: 'Enter X Coordinate'),
//             ),
//             TextField(
//               decoration: InputDecoration(
//                   border: InputBorder.none, hintText: 'Enter Y Coordinate'),
//             ),
//             FlatButton(onPressed: () => {}, child: Container(child: Text('Scan', style: TextStyle(color: Colors.amber),),)),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Future<Point> createAccessPoint(String SSID, int RSSI) async {
//     final response = await http.post(
//       url,
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{'ssid': SSID, 'rssi': RSSI.toString()}),
//     );
//     if (response.statusCode == 201) {
//       // If the server did return a 201 CREATED response,
//       // then parse the JSON.
//       //return AccessPoint(SSID, RSSI).fromJson(jsonDecode(response.body));
//       print('Successfully Send the Request');
//     } else {
//       // If the server did not return a 201 CREATED response,
//       // then throw an exception.
//       throw Exception('Failed to load album');
//     }
//   }
//
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }
