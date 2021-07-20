import 'package:access_point/utils/helper.dart' as helper;

const Map<String, String> headers = {"Content-type": "application/json"};
String apiBaseUlr = helper.getUrl('/api/v1/fingerprint');
const int timeOutDuration = 45;