import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String name_1;
  final String? name_2;
  final String? name_3;
  final String email;
  final String role_type;
  final bool is_deleted;
  final DateTime? deleted_at;
  final bool is_blocked;
  final DateTime? blocked_at;
  final int storage_size;
  final DateTime createdAt;
  final DateTime? updatedAt;

  User(
      this.id,
      this.name_1,
      this.name_2,
      this.name_3,
      this.email,
      this.role_type,
      this.is_deleted,
      this.deleted_at,
      this.is_blocked,
      this.blocked_at,
      this.storage_size,
      this.createdAt,
      this.updatedAt);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

class RegisterUser {
  final String email;
  final DateTime createdAt;

  RegisterUser(
    this.email,
    this.createdAt,
  );
}

@JsonSerializable()
class RegisterUserRequest {
  final dynamic data;
  final String status;

  RegisterUserRequest(this.data, this.status);

  factory RegisterUserRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserRequestToJson(this);
}
