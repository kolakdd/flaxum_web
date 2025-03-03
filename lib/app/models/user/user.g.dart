// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPublic _$UserPublicFromJson(Map<String, dynamic> json) => UserPublic(
      json['id'] as String,
      json['name1'] as String,
      json['name2'] as String?,
      json['name3'] as String?,
      json['email'] as String,
      json['roleType'] as String,
      (json['storageSize'] as num).toInt(),
    );

Map<String, dynamic> _$UserPublicToJson(UserPublic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name1': instance.name1,
      'name2': instance.name2,
      'name3': instance.name3,
      'email': instance.email,
      'roleType': instance.roleType,
      'storageSize': instance.storageSize,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as String,
      json['name1'] as String,
      json['name2'] as String?,
      json['name3'] as String?,
      json['email'] as String,
      json['roleType'] as String,
      json['isDeleted'] as bool,
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      json['isBlocked'] as bool,
      json['blockedAt'] == null
          ? null
          : DateTime.parse(json['blockedAt'] as String),
      (json['storageSize'] as num).toInt(),
      DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name1': instance.name1,
      'name2': instance.name2,
      'name3': instance.name3,
      'email': instance.email,
      'roleType': instance.roleType,
      'isDeleted': instance.isDeleted,
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'isBlocked': instance.isBlocked,
      'blockedAt': instance.blockedAt?.toIso8601String(),
      'storageSize': instance.storageSize,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

RegisterUserRequest _$RegisterUserRequestFromJson(Map<String, dynamic> json) =>
    RegisterUserRequest(
      json['data'],
      json['status'] as String,
    );

Map<String, dynamic> _$RegisterUserRequestToJson(
        RegisterUserRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
