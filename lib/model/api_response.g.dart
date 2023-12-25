import 'package:race_flutter/generated/json/base/json_convert_content.dart';
import 'package:race_flutter/model/api_response.dart';

ApiResponse<T> $ApiResponseFromJson<T>(Map<String, dynamic> json) {
  final ApiResponse<T> apiResponse = ApiResponse<T>();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    apiResponse.code = code;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    apiResponse.msg = msg;
  }
  final T? data = JsonConvert.fromJsonAsT<T>(json['data']);
  if (data != null) {
    apiResponse.data = data;
  }
  return apiResponse;
}

Map<String, dynamic> $ApiResponseToJson(ApiResponse entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['msg'] = entity.msg;
  data['data'] = entity.data;
  return data;
}

extension ApiResponseExtension on ApiResponse {
  ApiResponse copyWith({
    int? code,
    String? msg,
    dynamic data,
  }) {
    return ApiResponse()
      ..code = code ?? this.code
      ..msg = msg ?? this.msg
      ..data = data ?? this.data;
  }
}
