// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flaxum_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlaxumObject _$FlaxumObjectFromJson(Map<String, dynamic> json) => FlaxumObject(
      json['id'] as String,
      json['parentId'] as String?,
      json['ownerId'] as String,
      json['creatorId'] as String,
      json['name'] as String,
      (json['size'] as num?)?.toInt(),
      json['type'] as String,
      json['mimetype'] as String?,
      DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      json['inTrash'] as bool,
      json['eliminated'] as bool,
    );

Map<String, dynamic> _$FlaxumObjectToJson(FlaxumObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'ownerId': instance.ownerId,
      'creatorId': instance.creatorId,
      'name': instance.name,
      'size': instance.size,
      'type': instance.type,
      'mimetype': instance.mimetype,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'inTrash': instance.inTrash,
      'eliminated': instance.eliminated,
    };

GetOwnObjectsResponse _$GetOwnObjectsResponseFromJson(
        Map<String, dynamic> json) =>
    GetOwnObjectsResponse(
      (json['items'] as List<dynamic>)
          .map((e) => FlaxumObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['limit'] as num).toInt(),
      (json['offset'] as num).toInt(),
      (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$GetOwnObjectsResponseToJson(
        GetOwnObjectsResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
    };

CreateFolderResponse _$CreateFolderResponseFromJson(
        Map<String, dynamic> json) =>
    CreateFolderResponse(
      FlaxumObject.fromJson(json['data'] as Map<String, dynamic>),
      json['status'] as String,
    );

Map<String, dynamic> _$CreateFolderResponseToJson(
        CreateFolderResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
