import 'package:access_point/api/api.dart';
import 'package:access_point/api/api_result.dart';

class OnlinePhaseAPI {
  Future<APIResult> getLocation(dynamic body) async {
    var response;
    try {
      response = await API.post('/position', body);
    }catch(err, msg) {
      response = APIResult(code: 500, error: msg.toString());
    }
    return response;
  }
}