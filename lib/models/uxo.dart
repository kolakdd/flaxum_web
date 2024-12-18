import 'package:json_annotation/json_annotation.dart';

part 'uxo.g.dart';

@JsonSerializable()
class OwnerUser {
  final String owner_email;
  final String owner_id;

  OwnerUser(this.owner_email, this.owner_id);

  factory OwnerUser.fromJson(Map<String, dynamic> json) =>
      _$OwnerUserFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerUserToJson(this);
}

@JsonSerializable()
class Uxo {
  final String user_id;
  final String object_id;
  final bool can_delete;
  final bool can_edit;
  final bool can_read;
  final DateTime created_at;
  final DateTime? updated_at;

  Uxo(
    this.user_id,
    this.object_id,
    this.can_delete,
    this.can_edit,
    this.can_read,
    this.created_at,
    this.updated_at,
  );

  factory Uxo.fromJson(Map<String, dynamic> json) => _$UxoFromJson(json);

  Map<String, dynamic> toJson() => _$UxoToJson(this);
}

@JsonSerializable()
class UxoItem {
  OwnerUser owner_user;
  Uxo uxo;

  UxoItem(this.owner_user, this.uxo);

  factory UxoItem.fromJson(Map<String, dynamic> json) =>
      _$UxoItemFromJson(json);

  Map<String, dynamic> toJson() => _$UxoItemToJson(this);
}

@JsonSerializable()
class GetUxoResponse {
  final List<UxoItem> data;
  final String status;

  GetUxoResponse(this.data, this.status);

  factory GetUxoResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUxoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUxoResponseToJson(this);
}
