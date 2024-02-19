import 'package:race_flutter/generated/json/base/json_field.dart';
import 'dart:convert';

import 'package:race_flutter/model/page_info.g.dart';
export 'package:race_flutter/model/page_info.g.dart';

class PageInfo<T> {
  int? endRow;
  bool? hasNextPage;
  bool? hasPreviousPage;
  bool? isFirstPage;
  bool? isLastPage;
  List<T>? list;
  int? navigateFirstPage;
  int? navigateLastPage;
  int? navigatePages;
  List<int>? navigatepageNums;
  int? nextPage;
  int? pageNum;
  int? pageSize;
  int? pages;
  int? prePage;
  int? size;
  int? startRow;
  int? total;

  PageInfo();

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      $PageInfoFromJson(json);

  Map<String, dynamic> toJson() => $PageInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
