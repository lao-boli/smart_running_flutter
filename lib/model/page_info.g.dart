import 'package:race_flutter/generated/json/base/json_convert_content.dart';
import 'package:race_flutter/model/page_info.dart';
import 'package:race_flutter/model/role.dart';
import 'package:race_flutter/model/train_record.dart';
import 'package:race_flutter/model/unit.dart';
import 'package:race_flutter/model/user.dart';

PageInfo<T> $PageInfoFromJson<T>(Map<String, dynamic> json) {
  final PageInfo<T> pageInfo = PageInfo<T>();
  final int? endRow = jsonConvert.convert<int>(json['endRow']);
  if (endRow != null) {
    pageInfo.endRow = endRow;
  }
  final bool? hasNextPage = jsonConvert.convert<bool>(json['hasNextPage']);
  if (hasNextPage != null) {
    pageInfo.hasNextPage = hasNextPage;
  }
  final bool? hasPreviousPage =
      jsonConvert.convert<bool>(json['hasPreviousPage']);
  if (hasPreviousPage != null) {
    pageInfo.hasPreviousPage = hasPreviousPage;
  }
  final bool? isFirstPage = jsonConvert.convert<bool>(json['isFirstPage']);
  if (isFirstPage != null) {
    pageInfo.isFirstPage = isFirstPage;
  }
  final bool? isLastPage = jsonConvert.convert<bool>(json['isLastPage']);
  if (isLastPage != null) {
    pageInfo.isLastPage = isLastPage;
  }
  // final List<T>? list = (json['list'] as List<T>?)?.map((e) => e).toList();
  final List<T>? list = JsonConvert().convertList<T>(json['list'])?.cast<T>();
  if (list != null) {
    pageInfo.list = list;
  }
  final int? navigateFirstPage =
      jsonConvert.convert<int>(json['navigateFirstPage']);
  if (navigateFirstPage != null) {
    pageInfo.navigateFirstPage = navigateFirstPage;
  }
  final int? navigateLastPage =
      jsonConvert.convert<int>(json['navigateLastPage']);
  if (navigateLastPage != null) {
    pageInfo.navigateLastPage = navigateLastPage;
  }
  final int? navigatePages = jsonConvert.convert<int>(json['navigatePages']);
  if (navigatePages != null) {
    pageInfo.navigatePages = navigatePages;
  }
  final List<int>? navigatepageNums =
      (json['navigatepageNums'] as List<dynamic>?)
          ?.map((e) => jsonConvert.convert<int>(e) as int)
          .toList();
  if (navigatepageNums != null) {
    pageInfo.navigatepageNums = navigatepageNums;
  }
  final int? nextPage = jsonConvert.convert<int>(json['nextPage']);
  if (nextPage != null) {
    pageInfo.nextPage = nextPage;
  }
  final int? pageNum = jsonConvert.convert<int>(json['pageNum']);
  if (pageNum != null) {
    pageInfo.pageNum = pageNum;
  }
  final int? pageSize = jsonConvert.convert<int>(json['pageSize']);
  if (pageSize != null) {
    pageInfo.pageSize = pageSize;
  }
  final int? pages = jsonConvert.convert<int>(json['pages']);
  if (pages != null) {
    pageInfo.pages = pages;
  }
  final int? prePage = jsonConvert.convert<int>(json['prePage']);
  if (prePage != null) {
    pageInfo.prePage = prePage;
  }
  final int? size = jsonConvert.convert<int>(json['size']);
  if (size != null) {
    pageInfo.size = size;
  }
  final int? startRow = jsonConvert.convert<int>(json['startRow']);
  if (startRow != null) {
    pageInfo.startRow = startRow;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    pageInfo.total = total;
  }
  return pageInfo;
}

Map<String, dynamic> $PageInfoToJson(PageInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['endRow'] = entity.endRow;
  data['hasNextPage'] = entity.hasNextPage;
  data['hasPreviousPage'] = entity.hasPreviousPage;
  data['isFirstPage'] = entity.isFirstPage;
  data['isLastPage'] = entity.isLastPage;
  data['list'] = entity.list;
  data['navigateFirstPage'] = entity.navigateFirstPage;
  data['navigateLastPage'] = entity.navigateLastPage;
  data['navigatePages'] = entity.navigatePages;
  data['navigatepageNums'] = entity.navigatepageNums;
  data['nextPage'] = entity.nextPage;
  data['pageNum'] = entity.pageNum;
  data['pageSize'] = entity.pageSize;
  data['pages'] = entity.pages;
  data['prePage'] = entity.prePage;
  data['size'] = entity.size;
  data['startRow'] = entity.startRow;
  data['total'] = entity.total;
  return data;
}

extension PageInfoExtension on PageInfo {
  PageInfo copyWith({
    int? endRow,
    bool? hasNextPage,
    bool? hasPreviousPage,
    bool? isFirstPage,
    bool? isLastPage,
    List<dynamic>? list,
    int? navigateFirstPage,
    int? navigateLastPage,
    int? navigatePages,
    List<int>? navigatepageNums,
    int? nextPage,
    int? pageNum,
    int? pageSize,
    int? pages,
    int? prePage,
    int? size,
    int? startRow,
    int? total,
  }) {
    return PageInfo()
      ..endRow = endRow ?? this.endRow
      ..hasNextPage = hasNextPage ?? this.hasNextPage
      ..hasPreviousPage = hasPreviousPage ?? this.hasPreviousPage
      ..isFirstPage = isFirstPage ?? this.isFirstPage
      ..isLastPage = isLastPage ?? this.isLastPage
      ..list = list ?? this.list
      ..navigateFirstPage = navigateFirstPage ?? this.navigateFirstPage
      ..navigateLastPage = navigateLastPage ?? this.navigateLastPage
      ..navigatePages = navigatePages ?? this.navigatePages
      ..navigatepageNums = navigatepageNums ?? this.navigatepageNums
      ..nextPage = nextPage ?? this.nextPage
      ..pageNum = pageNum ?? this.pageNum
      ..pageSize = pageSize ?? this.pageSize
      ..pages = pages ?? this.pages
      ..prePage = prePage ?? this.prePage
      ..size = size ?? this.size
      ..startRow = startRow ?? this.startRow
      ..total = total ?? this.total;
  }
}

M? pageInfoFromJsonSingle<M>(Map<String, dynamic> json) {
  String type = M.toString();
  String genericType = type.substring(type.indexOf("<") + 1, type.length - 1);
  print("genericType :$genericType");
  if ((User).toString() == genericType) {
    PageInfo<User> pagingData = PageInfo<User>.fromJson(json);
    return pagingData as M;
  }
  if ((Role).toString() == genericType) {
    PageInfo<Role> pagingData = PageInfo<Role>.fromJson(json);
    return pagingData as M;
  }
  if ((Unit).toString() == genericType) {
    PageInfo<Unit> pagingData = PageInfo<Unit>.fromJson(json);
    return pagingData as M;
  }
  if ((TrainRecord).toString() == genericType) {
    PageInfo<TrainRecord> pagingData = PageInfo<TrainRecord>.fromJson(json);
    return pagingData as M;
  }
  return PageInfo.fromJson(json) as M;
}
