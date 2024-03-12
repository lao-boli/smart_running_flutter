import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:race_flutter/api/user_api.dart';
import 'package:race_flutter/model/api_response.dart';
import 'package:race_flutter/model/page_info.dart';
import 'package:race_flutter/model/role.dart';
import 'package:race_flutter/model/unit.dart';
import 'package:race_flutter/model/user.dart';
import 'package:race_flutter/request/request_client.dart';

import 'user_state.dart';

class UserLogic extends GetxController {
  final UserState state = UserState();

  void pageUser(int pageNum, int pageSize,
      {Map<String, dynamic>? queryParams}) async {

    Map<String, dynamic> params = {'pageNum': pageNum, 'pageSize': pageSize};
    params.addAll(queryParams ?? {});

    var data = await requestClient.get<PageInfo<User>>('user/page',
        queryParameters: params);
    state.dataSource.updateData(data.data.list);
    state.dataSource.total = data.data.total;
    state.dataSource.size = data.data.pageSize;
    state.dataSource.pageNum = data.data.pageNum;
  }

  void refreshUser() async {
    return pageUser(state.dataSource.pageNum, state.dataSource.size);
  }

  Future<ApiResponse> addUser(User user) async {
    var data = await requestClient.post('user/add', data: user);
    print(data);
    return data;
  }

  Future<ApiResponse> updateUser(User user) async {
    ApiResponse data = await requestClient.post('user/update', data: user);
    return data;
  }

  void listUnit() async {
    // var data = await requestClient.get('http://localhost:8081/api/user/page',
    //     queryParameters: params);
    var data = await requestClient.get<List<Unit>>(
      'unit/list',
    );
    log("${data.data}");
    state.unitList = data.data;
  }

  void listRole() async {
    // var data = await requestClient.get('http://localhost:8081/api/user/page',
    //     queryParameters: params);
    var data = await requestClient.get<List<Role>>(
      'role/list',
    );
    log("${data.data}");
    state.roleList = data.data;
  }

  Unit? getUserUnit(User user) {
    if (user.unitId == null) {
      return null;
    }
    var unit = Unit();
    unit.name = user.unitName;
    unit.unitId = user.unitId;
    return unit;
  }

  Role? getUserRole(User user) {
    if (user.roleId == null) {
      return null;
    }
    var role = Role();
    role.name = user.roleName;
    role.roleId = user.roleId;
    return role;
  }
}
