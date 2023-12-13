import 'package:race_flutter/generated/json/base/json_convert_content.dart';
import 'package:race_flutter/model/user.dart';

User $UserFromJson(Map<String, dynamic> json) {
  final User user = User();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    user.id = id;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    user.password = password;
  }
  final int? roleId = jsonConvert.convert<int>(json['roleId']);
  if (roleId != null) {
    user.roleId = roleId;
  }
  final String? roleName = jsonConvert.convert<String>(json['roleName']);
  if (roleName != null) {
    user.roleName = roleName;
  }
  final String? salt = jsonConvert.convert<String>(json['salt']);
  if (salt != null) {
    user.salt = salt;
  }
  final String? unit = jsonConvert.convert<String>(json['unit']);
  if (unit != null) {
    user.unit = unit;
  }
  final int? unitId = jsonConvert.convert<int>(json['unitId']);
  if (unitId != null) {
    user.unitId = unitId;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    user.username = username;
  }
  return user;
}

Map<String, dynamic> $UserToJson(User entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['password'] = entity.password;
  data['roleId'] = entity.roleId;
  data['roleName'] = entity.roleName;
  data['salt'] = entity.salt;
  data['unit'] = entity.unit;
  data['unitId'] = entity.unitId;
  data['username'] = entity.username;
  return data;
}

extension UserExtension on User {
  User copyWith({
    int? id,
    String? password,
    int? roleId,
    String? roleName,
    String? salt,
    String? unit,
    int? unitId,
    String? username,
  }) {
    return User()
      ..id = id ?? this.id
      ..password = password ?? this.password
      ..roleId = roleId ?? this.roleId
      ..roleName = roleName ?? this.roleName
      ..salt = salt ?? this.salt
      ..unit = unit ?? this.unit
      ..unitId = unitId ?? this.unitId
      ..username = username ?? this.username;
  }
}
