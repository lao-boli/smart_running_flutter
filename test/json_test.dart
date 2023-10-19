// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_running_flutter/model/api_response.dart';
import 'package:smart_running_flutter/model/user.dart';

void main() {
  test('ApiResponse json test', () {
    String userData = """
    {
      "code": 200,
      "msg": "success",
      "data": {
        "id": 0,
        "password": "string",
        "roleId": 0,
        "roleName": "string",
        "salt": "string",
        "unit": "string",
        "unitId": 0,
        "username": "string"
      }
    }
    """;

    ApiResponse<User> response = ApiResponse.fromJson(jsonDecode(userData));
    print(response);
  });
}
