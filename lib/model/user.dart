import 'package:race_flutter/generated/json/base/json_field.dart';
import 'package:race_flutter/generated/json/user.g.dart';
import 'dart:convert';
export 'package:race_flutter/generated/json/user.g.dart';

@JsonSerializable()
class User {
	int? id;
	String? password;
	int? roleId;
	String? roleName;
	String? salt;
	String? username;
	String? name;
	String? gender;
	int? age;
	double? height;
	double? weight;
	bool? athlete;
	String? bracelet;

	User();

	factory User.fromJson(Map<String, dynamic> json) => $UserFromJson(json);

	Map<String, dynamic> toJson() => $UserToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
