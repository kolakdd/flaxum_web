// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as String,
      json['name_1'] as String,
      json['name_2'] as String?,
      json['name_3'] as String?,
      json['email'] as String,
      json['role_type'] as String,
      json['is_deleted'] as bool,
      json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      json['is_blocked'] as bool,
      json['blocked_at'] == null
          ? null
          : DateTime.parse(json['blocked_at'] as String),
      (json['storage_size'] as num).toInt(),
      DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name_1': instance.name_1,
      'name_2': instance.name_2,
      'name_3': instance.name_3,
      'email': instance.email,
      'role_type': instance.role_type,
      'is_deleted': instance.is_deleted,
      'deleted_at': instance.deleted_at?.toIso8601String(),
      'is_blocked': instance.is_blocked,
      'blocked_at': instance.blocked_at?.toIso8601String(),
      'storage_size': instance.storage_size,
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
