import 'package:race_flutter/generated/json/base/json_convert_content.dart';
import 'package:race_flutter/model/unit.dart';

Unit $UnitFromJson(Map<String, dynamic> json) {
  final Unit unit = Unit();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    unit.id = id;
  }
  final String? unitId = jsonConvert.convert<String>(json['unit_id']);
  if (unitId != null) {
    unit.unitId = unitId;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    unit.name = name;
  }
  return unit;
}

Map<String, dynamic> $UnitToJson(Unit entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['unit_id'] = entity.unitId;
  data['name'] = entity.name;
  return data;
}

extension UnitExtension on Unit {
  Unit copyWith({
    int? id,
    String? unitId,
    String? name,
  }) {
    return Unit()
      ..id = id ?? this.id
      ..unitId = unitId ?? this.unitId
      ..name = name ?? this.name;
  }
}
