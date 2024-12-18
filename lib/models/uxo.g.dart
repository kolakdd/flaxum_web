// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uxo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerUser _$OwnerUserFromJson(Map<String, dynamic> json) => OwnerUser(
      json['owner_email'] as String,
      json['owner_id'] as String,
    );

Map<String, dynamic> _$OwnerUserToJson(OwnerUser instance) => <String, dynamic>{
      'owner_email': instance.owner_email,
      'owner_id': instance.owner_id,
    };

Uxo _$UxoFromJson(Map<String, dynamic> json) => Uxo(
      json['user_id'] as String,
      json['object_id'] as String,
      json['can_delete'] as bool,
      json['can_edit'] as bool,
      json['can_read'] as bool,
      DateTime.parse(json['created_at'] as String),
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UxoToJson(Uxo instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'object_id': instance.object_id,
      'can_delete': instance.can_delete,
      'can_edit': instance.can_edit,
      'can_read': instance.can_read,
      'created_at': instance.created_at.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };

UxoItem _$UxoItemFromJson(Map<String, dynamic> json) => UxoItem(
      OwnerUser.fromJson(json['owner_user'] as Map<String, dynamic>),
      Uxo.fromJson(json['uxo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UxoItemToJson(UxoItem instance) => <String, dynamic>{
      'owner_user': instance.owner_user,
      'uxo': instance.uxo,
    };

GetUxoResponse _$GetUxoResponseFromJson(Map<String, dynamic> json) =>
    GetUxoResponse(
      (json['data'] as List<dynamic>)
          .map((e) => UxoItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'] as String,
    );

Map<String, dynamic> _$GetUxoResponseToJson(GetUxoResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
