// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uxo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerUser _$OwnerUserFromJson(Map<String, dynamic> json) => OwnerUser(
      json['ownerEmail'] as String,
      json['ownerId'] as String,
    );

Map<String, dynamic> _$OwnerUserToJson(OwnerUser instance) => <String, dynamic>{
      'ownerEmail': instance.ownerEmail,
      'ownerId': instance.ownerId,
    };

Uxo _$UxoFromJson(Map<String, dynamic> json) => Uxo(
      json['userId'] as String,
      json['objectId'] as String,
      json['canDelete'] as bool,
      json['canEdit'] as bool,
      json['canRead'] as bool,
      DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UxoToJson(Uxo instance) => <String, dynamic>{
      'userId': instance.userId,
      'objectId': instance.objectId,
      'canDelete': instance.canDelete,
      'canEdit': instance.canEdit,
      'canRead': instance.canRead,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

UxoItem _$UxoItemFromJson(Map<String, dynamic> json) => UxoItem(
      OwnerUser.fromJson(json['ownerUser'] as Map<String, dynamic>),
      Uxo.fromJson(json['uxo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UxoItemToJson(UxoItem instance) => <String, dynamic>{
      'ownerUser': instance.ownerUser,
      'uxo': instance.uxo,
    };

GetUxoResponse _$GetUxoResponseFromJson(Map<String, dynamic> json) =>
    GetUxoResponse(
      (json['items'] as List<dynamic>)
          .map((e) => UxoItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetUxoResponseToJson(GetUxoResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

CreateUxoResponse _$CreateUxoResponseFromJson(Map<String, dynamic> json) =>
    CreateUxoResponse(
      UxoItem.fromJson(json['data'] as Map<String, dynamic>),
      json['status'] as String,
    );

Map<String, dynamic> _$CreateUxoResponseToJson(CreateUxoResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
