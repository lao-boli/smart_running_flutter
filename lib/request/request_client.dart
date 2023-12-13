import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:race_flutter/request/api_exception.dart';
import 'package:race_flutter/model/api_response.dart';

import 'request_config.dart';

RequestClient requestClient = RequestClient();

class RequestClient {
  late Dio _dio;

  RequestClient() {
    _dio = Dio(BaseOptions(
        baseUrl: RequestConfig.baseUrl,
        connectTimeout: RequestConfig.connectTimeout));
  }

  Future<dynamic> request(
    String url, {
    String method = "GET",
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    bool Function(ApiException)? onError,
  }) async {
    try {
      data = _convertRequestData(data);
      Options options = Options()
        ..method = method
        ..headers = headers;

      Response response = await _dio.request(url,
          queryParameters: queryParameters, data: data, options: options);
      return _handleResponse(response);
    } catch (e) {
      var exception = ApiException.from(e);
      if (onError?.call(exception) != true) {
        print(exception.message);
        throw exception;
      }
    }
  }

  Future<T?> requestData<T>(
    String url, {
    String method = "GET",
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    bool Function(ApiException)? onError,
  }) async {
    try {
      data = _convertRequestData(data);
      Options options = Options()
        ..method = method
        ..headers = headers;

      Response response = await _dio.request(url,
          queryParameters: queryParameters, data: data, options: options);
      return _responseData(response);
    } catch (e) {
      var exception = ApiException.from(e);
      if (onError?.call(exception) != true) {
        print(e.toString());
        throw exception;
      }
    }
    return null;
  }

  _convertRequestData(data) {
    if (data != null) {
      data = jsonDecode(jsonEncode(data));
    }
    return data;
  }

  Future get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool showLoading = true,
    bool Function(ApiException)? onError,
  }) {
    return request(url,
        queryParameters: queryParameters, headers: headers, onError: onError);
  }

  Future post<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    bool showLoading = true,
    bool Function(ApiException)? onError,
  }) {
    return request(url,
        method: "POST",
        queryParameters: queryParameters,
        data: data,
        headers: headers,
        onError: onError);
  }

  ///请求响应内容处理
  ApiResponse<T>? _handleResponse<T>(Response response) {
    if (response.statusCode == 200) {
     return ApiResponse<T>.fromJson(response.data);
    } else {
      return null;
    }
  }


  T? _responseData<T>(Response response) {
    if (response.statusCode == 200) {
      ApiResponse<T> apiResponse = ApiResponse<T>.fromJson(response.data);
      if (apiResponse.code == RequestConfig.successCode) {
        return apiResponse.data;
      } else {
        throw BusinessException(apiResponse.code,apiResponse.msg);
      }
    }
    return null;
  }
}
