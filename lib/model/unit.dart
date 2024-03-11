import 'package:race_flutter/generated/json/base/json_field.dart';
import 'package:race_flutter/generated/json/unit.g.dart';
import 'dart:convert';
export 'package:race_flutter/generated/json/unit.g.dart';

@JsonSerializable()
class Unit {
	int? id;
	String? unitId;
	String? name;

	Unit();

	factory Unit.fromJson(Map<String, dynamic> json) => $UnitFromJson(json);

	Map<String, dynamic> toJson() => $UnitToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

	@override
  bool operator ==(Object other) {
    return other is Unit && other.unitId == unitId;
  }
}
