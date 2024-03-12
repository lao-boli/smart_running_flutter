import 'package:race_flutter/generated/json/base/json_field.dart';
import 'package:race_flutter/model/api_response.g.dart';
import 'dart:convert';
export 'package:race_flutter/model/api_response.g.dart';

class ApiResponse<T> {
	int? code;
	String? msg;
	T? data;

	ApiResponse();

	factory ApiResponse.fromJson(Map<String, dynamic> json) => $ApiResponseFromJson<T>(json);

	Map<String, dynamic> toJson() => $ApiResponseToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

	bool isSucceed(){
		return code == 20000;
	}
}

