import 'package:race_flutter/generated/json/base/json_convert_content.dart';
import 'package:race_flutter/model/user.dart';

User $UserFromJson(Map<String, dynamic> json) {
  final User user = User();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    user.id = id;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    user.userId = userId;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    user.password = password;
  }
  final String? roleId = jsonConvert.convert<String>(json['roleId']);
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
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    user.username = username;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    user.name = name;
  }
  final String? gender = jsonConvert.convert<String>(json['gender']);
  if (gender != null) {
    user.gender = gender;
  }
  final int? age = jsonConvert.convert<int>(json['age']);
  if (age != null) {
    user.age = age;
  }
  final double? height = jsonConvert.convert<double>(json['height']);
  if (height != null) {
    user.height = height;
  }
  final double? weight = jsonConvert.convert<double>(json['weight']);
  if (weight != null) {
    user.weight = weight;
  }
  final bool? athlete = jsonConvert.convert<bool>(json['athlete']);
  if (athlete != null) {
    user.athlete = athlete;
  }
  final String? bracelet = jsonConvert.convert<String>(json['bracelet']);
  if (bracelet != null) {
    user.bracelet = bracelet;
  }
  final String? unitName = jsonConvert.convert<String>(json['unitName']);
  if (unitName != null) {
    user.unitName = unitName;
  }
  final String? unitId = jsonConvert.convert<String>(json['unitId']);
  if (unitId != null) {
    user.unitId = unitId;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    user.phone = phone;
  }
  return user;
}

Map<String, dynamic> $UserToJson(User entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['userId'] = entity.userId;
  data['password'] = entity.password;
  data['roleId'] = entity.roleId;
  data['roleName'] = entity.roleName;
  data['salt'] = entity.salt;
  data['username'] = entity.username;
  data['name'] = entity.name;
  data['gender'] = entity.gender;
  data['age'] = entity.age;
  data['height'] = entity.height;
  data['weight'] = entity.weight;
  data['athlete'] = entity.athlete;
  data['bracelet'] = entity.bracelet;
  data['unitName'] = entity.unitName;
  data['unitId'] = entity.unitId;
  data['phone'] = entity.phone;
  return data;
}

extension UserExtension on User {
  User copyWith({
    int? id,
    String? userId,
    String? password,
    String? roleId,
    String? roleName,
    String? salt,
    String? username,
    String? name,
    String? gender,
    int? age,
    double? height,
    double? weight,
    bool? athlete,
    String? bracelet,
    String? unitName,
    String? unitId,
    String? phone,
  }) {
    return User()
      ..id = id ?? this.id
      ..userId = userId ?? this.userId
      ..password = password ?? this.password
      ..roleId = roleId ?? this.roleId
      ..roleName = roleName ?? this.roleName
      ..salt = salt ?? this.salt
      ..username = username ?? this.username
      ..name = name ?? this.name
      ..gender = gender ?? this.gender
      ..age = age ?? this.age
      ..height = height ?? this.height
      ..weight = weight ?? this.weight
      ..athlete = athlete ?? this.athlete
      ..bracelet = bracelet ?? this.bracelet
      ..unitName = unitName ?? this.unitName
      ..unitId = unitId ?? this.unitId
      ..phone = phone ?? this.phone;
  }
}
