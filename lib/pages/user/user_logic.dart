import 'package:get/get.dart';
import 'package:race_flutter/model/page_info.dart';
import 'package:race_flutter/model/user.dart';
import 'package:race_flutter/request/request_client.dart';

import 'user_state.dart';

class UserLogic extends GetxController {
  final UserState state = UserState();

  void pageUser(int pageNum, int pageSize) async {
    var params = {'pageNum': 1, 'pageSize': 10};
    // var data = await requestClient.get('http://localhost:8081/api/user/page',
    //     queryParameters: params);
    var data = await requestClient.get<PageInfo<User>>('user/page',
        queryParameters: params);
    print(data.data);
    state.dataSource.updateData(data.data.list);
  }
}
