import 'package:race_flutter/generated/json/base/json_convert_content.dart';
import 'package:race_flutter/model/train_record.dart';

TrainRecord $TrainRecordFromJson(Map<String, dynamic> json) {
  final TrainRecord trainRecord = TrainRecord();
  final int? age = jsonConvert.convert<int>(json['age']);
  if (age != null) {
    trainRecord.age = age;
  }
  final String? gender = jsonConvert.convert<String>(json['gender']);
  if (gender != null) {
    trainRecord.gender = gender;
  }
  final double? height = jsonConvert.convert<double>(json['height']);
  if (height != null) {
    trainRecord.height = height;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    trainRecord.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    trainRecord.name = name;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    trainRecord.time = time;
  }
  final String? trainId = jsonConvert.convert<String>(json['trainId']);
  if (trainId != null) {
    trainRecord.trainId = trainId;
  }
  final String? trainerId = jsonConvert.convert<String>(json['trainerId']);
  if (trainerId != null) {
    trainRecord.trainerId = trainerId;
  }
  final double? vo2max = jsonConvert.convert<double>(json['vo2max']);
  if (vo2max != null) {
    trainRecord.vo2max = vo2max;
  }
  final double? weight = jsonConvert.convert<double>(json['weight']);
  if (weight != null) {
    trainRecord.weight = weight;
  }
  final bool? athlete = jsonConvert.convert<bool>(json['athlete']);
  if (athlete != null) {
    trainRecord.athlete = athlete;
  }
  return trainRecord;
}

Map<String, dynamic> $TrainRecordToJson(TrainRecord entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['age'] = entity.age;
  data['gender'] = entity.gender;
  data['height'] = entity.height;
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['time'] = entity.time;
  data['trainId'] = entity.trainId;
  data['trainerId'] = entity.trainerId;
  data['vo2max'] = entity.vo2max;
  data['weight'] = entity.weight;
  data['athlete'] = entity.athlete;
  return data;
}

extension TrainRecordExtension on TrainRecord {
  TrainRecord copyWith({
    int? age,
    String? gender,
    double? height,
    int? id,
    String? name,
    String? time,
    String? trainId,
    String? trainerId,
    double? vo2max,
    double? weight,
    bool? athlete,
  }) {
    return TrainRecord()
      ..age = age ?? this.age
      ..gender = gender ?? this.gender
      ..height = height ?? this.height
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..time = time ?? this.time
      ..trainId = trainId ?? this.trainId
      ..trainerId = trainerId ?? this.trainerId
      ..vo2max = vo2max ?? this.vo2max
      ..weight = weight ?? this.weight
      ..athlete = athlete ?? this.athlete;
  }
}
