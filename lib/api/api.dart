import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:access_point/api/api_offline_phase.dart';
import 'package:access_point/api/api_online_phase.dart';
import 'package:access_point/utils/api_utils.dart' as api;
import 'package:access_point/api/api_result.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/io_client.dart';

class API {
  static final String baseUrl = api.apiBaseUlr;
  static final int timeOutDuration = api.timeOutDuration;
  static final OfflinePhaseAPI offlinePhaseAPI = OfflinePhaseAPI();
  static final OnlinePhaseAPI onlinePhaseAPI = OnlinePhaseAPI();

  static Future<APIResult> get(String partUrl) async {
    var res = await apiRequest(partUrl, 'GET');
    return res;
  }

  static Future<APIResult> post(String partUrl, dynamic body) async {
    var res = await apiRequest(partUrl, 'POST', postBody: body);
    return res;
  }

  static Future<APIResult> apiRequest(String partUrl, String method,
      {dynamic postBody, dynamic headers}) async {
    print(baseUrl + partUrl);
    Uri url = Uri.parse(baseUrl + partUrl);
    final encodedBody = jsonEncode(postBody);
    late http.Response response;
    try {
      if (method == 'GET') {
        response =
        await http.get(url).timeout(Duration(seconds: timeOutDuration));
      } else if (method == 'POST') {
        response = await http
            .post(url, headers: api.headers, body: encodedBody)
            .timeout(Duration(seconds: timeOutDuration));
      }
      Map<String, dynamic> body = jsonDecode(response.body);
      var result = APIResult();
      result.code = body['code'];
      result.error = body['error'];

      if (result.code != 200 || result.error != '') {
        _log('error in getting response from server');
        _log(result.error);
        result.succeed = false;
        result.data = null;
      } else {
        result.succeed = true;
        result.data = body['data'];
      }
      return result;
    } catch (err, msg) {
      var e = "Unable to get response " + msg.toString();
      var code = 500;
      if (err is TimeoutException) {
        e = 'TimeOut Error';
      } else if (err is IOClient || err is SocketException) {
        code = -1;
        e = 'Socket Error';
      }
      _log("Error => " + e.toString());
      var result = APIResult(
          code: code, error: e.toString(), succeed: false, data: null);
      return result;
    }
  }

  static void _log(dynamic msg) {
    print("API Class => " + msg);
  }
}