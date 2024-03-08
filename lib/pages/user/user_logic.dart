import 'package:get/get.dart';
import 'package:race_flutter/api/user_api.dart';
import 'package:race_flutter/model/page_info.dart';
import 'package:race_flutter/model/role.dart';
import 'package:race_flutter/model/unit.dart';
import 'package:race_flutter/model/user.dart';
import 'package:race_flutter/request/request_client.dart';

import 'user_state.dart';

class UserLogic extends GetxController {
  final UserState state = UserState();

  void pageUser(int pageNum, int pageSize) async {
    var params = {'pageNum': pageNum, 'pageSize': pageSize};
    // var data = await requestClient.get('http://localhost:8081/api/user/page',
    //     queryParameters: params);
    var data = await requestClient.get<PageInfo<User>>('user/page',
        queryParameters: params);
    state.dataSource.updateData(data.data.list);
    state.dataSource.total = data.data.total;
    state.dataSource.size = data.data.pageSize;
  }

  void listUnit() async {
    // var data = await requestClient.get('http://localhost:8081/api/user/page',
    //     queryParameters: params);
    var data = await requestClient.get<List<Unit>>('unit/list',);
    state.unitList = data.data;
  }
  void listRole() async {
    // var data = await requestClient.get('http://localhost:8081/api/user/page',
    //     queryParameters: params);
    var data = await requestClient.get<List<Role>>('role/list',);
    state.roleList = data.data;
  }
}
