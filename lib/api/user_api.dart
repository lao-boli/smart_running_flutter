import 'package:race_flutter/model/user.dart';
import 'package:race_flutter/request/request_client.dart';

class UserApi {
  static Future<List<User>?> list({
    Map<String, dynamic>? queryParameters,
  }) async {
   var body =   await requestClient.requestData<List<User>>("user/list", queryParameters: queryParameters);
    return body;
  }
}
