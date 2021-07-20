import 'package:access_point/views/home/home_screen.dart';
import 'package:access_point/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:access_point/utils/color_utils.dart' as colors;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
        new MyApp());
  });
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WiFi',
      theme: new ThemeData(
        scaffoldBackgroundColor: colors.backgroundColor,
        appBarTheme: AppBarTheme(backgroundColor: colors.appBar),
        primaryColor: colors.primaryColor,
        primaryColorLight: colors.primaryColorLight,
        primaryColorDark: colors.primaryColorDark,
        accentColor: colors.accentColor,
        backgroundColor: colors.backgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/home': (context) => new Home(),
        '/splash': (context) => new SplashScreen(),
      },
      home: Home()
    );
  }
}
