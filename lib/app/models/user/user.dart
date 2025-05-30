import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

// --------=== User public ===---------

@JsonSerializable()
class UserPublic {
  final String id;
  final String name1;
  final String? name2;
  final String? name3;
  final String email;
  final String roleType;
  final int storageSize;

  UserPublic(
    this.id,
    this.name1,
    this.name2,
    this.name3,
    this.email,
    this.roleType,
    this.storageSize,
  );

  factory UserPublic.fromJson(Map<String, dynamic> json) =>
      _$UserPublicFromJson(json);

  Map<String, dynamic> toJson() => _$UserPublicToJson(this);
}

// --------=== User ===---------
@JsonSerializable()
class User {
  final String id;
  final String name1;
  final String? name2;
  final String? name3;
  final String email;
  final String roleType;
  final bool isDeleted;
  final DateTime? deletedAt;
  final bool isBlocked;
  final DateTime? blockedAt;
  final int storageSize;
  final DateTime createdAt;
  final DateTime? updatedAt;

  User(
      this.id,
      this.name1,
      this.name2,
      this.name3,
      this.email,
      this.roleType,
      this.isDeleted,
      this.deletedAt,
      this.isBlocked,
      this.blockedAt,
      this.storageSize,
      this.createdAt,
      this.updatedAt);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

// --------=== User Admin ===---------

class RegisterUser {
  final String email;
  final DateTime createdAt;

  RegisterUser(
    this.email,
    this.createdAt,
  );
}

// --------------------------------------- admin create user
@JsonSerializable()
class AdminCreateUser {
  final String email;
  final String roleType;

  AdminCreateUser(this.email, this.roleType);

  factory AdminCreateUser.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateUserFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateUserToJson(this);
}

@JsonSerializable()
class AdminCreateUserResponse {
  final String email;
  final String password;
  final String createdAt;

  AdminCreateUserResponse(this.email, this.password, this.createdAt);

  factory AdminCreateUserResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateUserResponseToJson(this);
}
// |||||||||||||||||||||||||||||||||||||||

@JsonSerializable()
class GetUsersResponse {
  final List<User> items;
  final int limit;
  final int offset;
  final int total;

  GetUsersResponse(this.items, this.limit, this.offset, this.total);

  factory GetUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUsersResponseToJson(this);
}
