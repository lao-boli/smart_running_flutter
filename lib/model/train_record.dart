import 'package:race_flutter/generated/json/base/json_field.dart';
import 'package:race_flutter/generated/json/train_record.g.dart';
import 'dart:convert';
export 'package:race_flutter/generated/json/train_record.g.dart';

@JsonSerializable()
class TrainRecord {
	int? age;
	String? gender;
	double? height;
	int? id;
	String? name;
	String? time;
	String? trainId;
	String? trainerId;
	double? vo2max;
	double? weight;
	bool? athlete;

	TrainRecord();

	factory TrainRecord.fromJson(Map<String, dynamic> json) => $TrainRecordFromJson(json);

	Map<String, dynamic> toJson() => $TrainRecordToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
