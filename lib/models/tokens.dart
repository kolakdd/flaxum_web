import 'package:json_annotation/json_annotation.dart';

part 'tokens.g.dart';

@JsonSerializable()
class AuthUser {
  final String token;
  final DateTime expired;

  AuthUser(this.token, this.expired);

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);
}
