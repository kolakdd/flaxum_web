// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'robot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Robot _$RobotFromJson(Map<String, dynamic> json) => Robot(
      json['id'] as String,
      json['name'] as String,
      json['token'] as String,
    );

Map<String, dynamic> _$RobotToJson(Robot instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'token': instance.token,
    };

GetRobotsResponse _$GetRobotsResponseFromJson(Map<String, dynamic> json) =>
    GetRobotsResponse(
      (json['items'] as List<dynamic>)
          .map((e) => Robot.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['limit'] as num).toInt(),
      (json['offset'] as num).toInt(),
      (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$GetRobotsResponseToJson(GetRobotsResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
    };
