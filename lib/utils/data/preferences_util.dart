import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>  await SharedPreferences.getInstance();
  static late SharedPreferences _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String getString(String key, String defaultValue) {
    return _prefsInstance.getString(key) ?? defaultValue;
  }

  static setString(String key, String value) async {
    var prefs = await _instance;
    prefs.setString(key, value);
  }
  static int getInt(String key, int defaultValue) {
    return _prefsInstance.getInt(key) ?? defaultValue;
  }
  static setInt(String key, int value) async{
    var prefs = await _instance;
    prefs.setInt(key, value);
  }
}