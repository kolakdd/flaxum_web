// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Object_ _$Object_FromJson(Map<String, dynamic> json) => Object_(
      json['id'] as String,
      json['parent_id'] as String?,
      json['owner_id'] as String,
      json['creator_id'] as String,
      json['name'] as String,
      (json['size'] as num?)?.toInt(),
      json['type'] as String,
      json['mimetype'] as String?,
      DateTime.parse(json['created_at'] as String),
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      json['in_trash'] as bool,
      json['eliminated'] as bool,
    );

Map<String, dynamic> _$Object_ToJson(Object_ instance) => <String, dynamic>{
      'id': instance.id,
      'parent_id': instance.parent_id,
      'owner_id': instance.owner_id,
      'creator_id': instance.creator_id,
      'name': instance.name,
      'size': instance.size,
      'type': instance.type,
      'mimetype': instance.mimetype,
      'created_at': instance.created_at.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'in_trash': instance.in_trash,
      'eliminated': instance.eliminated,
    };

GetOwnObjectsResponse _$GetOwnObjectsResponseFromJson(
        Map<String, dynamic> json) =>
    GetOwnObjectsResponse(
      (json['data'] as List<dynamic>)
          .map((e) => Object_.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['limit'] as num).toInt(),
      (json['offset'] as num).toInt(),
      json['status'] as String,
    );

Map<String, dynamic> _$GetOwnObjectsResponseToJson(
        GetOwnObjectsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'limit': instance.limit,
      'offset': instance.offset,
      'status': instance.status,
    };
