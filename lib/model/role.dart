import 'package:race_flutter/generated/json/base/json_field.dart';
import 'package:race_flutter/generated/json/role.g.dart';
import 'dart:convert';
export 'package:race_flutter/generated/json/role.g.dart';

@JsonSerializable()
class Role {
	int? id;
	String? name;
	String? roleId;

	Role();

	factory Role.fromJson(Map<String, dynamic> json) => $RoleFromJson(json);

	Map<String, dynamic> toJson() => $RoleToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

	@override
	bool operator ==(Object other) {
		return other is Role && other.roleId == roleId;
	}
}
