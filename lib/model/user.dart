import 'package:smart_running_flutter/generated/json/base/json_field.dart';
import 'package:smart_running_flutter/generated/json/user.g.dart';
import 'dart:convert';
export 'package:smart_running_flutter/generated/json/user.g.dart';

@JsonSerializable()
class User {
	int? id;
	String? password;
	int? roleId;
	String? roleName;
	String? salt;
	String? unit;
	int? unitId;
	String? username;

	User();

	factory User.fromJson(Map<String, dynamic> json) => $UserFromJson(json);

	Map<String, dynamic> toJson() => $UserToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
