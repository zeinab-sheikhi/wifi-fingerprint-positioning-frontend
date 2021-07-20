import 'package:access_point/api/api.dart';
import 'package:access_point/api/api_result.dart';

class OfflinePhaseAPI {
  Future<APIResult> postPoints(dynamic body) async {
    var response;
    print(body);
    try{
      response = API.post('/points', body);
    } catch(err, msg) {
      response = APIResult(code: 500, error: msg.toString());
    }
    return response;
  }
}