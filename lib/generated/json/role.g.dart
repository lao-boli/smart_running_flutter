import 'package:race_flutter/generated/json/base/json_convert_content.dart';
import 'package:race_flutter/model/role.dart';

Role $RoleFromJson(Map<String, dynamic> json) {
  final Role role = Role();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    role.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    role.name = name;
  }
  final String? roleId = jsonConvert.convert<String>(json['roleId']);
  if (roleId != null) {
    role.roleId = roleId;
  }
  return role;
}

Map<String, dynamic> $RoleToJson(Role entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['roleId'] = entity.roleId;
  return data;
}

extension RoleExtension on Role {
  Role copyWith({
    int? id,
    String? name,
    String? roleId,
  }) {
    return Role()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..roleId = roleId ?? this.roleId;
  }
}
