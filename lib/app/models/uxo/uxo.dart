import 'package:json_annotation/json_annotation.dart';

part 'uxo.g.dart';

@JsonSerializable()
class OwnerUser {
  final String ownerEmail;
  final String ownerId;

  OwnerUser(this.ownerEmail, this.ownerId);

  factory OwnerUser.fromJson(Map<String, dynamic> json) =>
      _$OwnerUserFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerUserToJson(this);
}

@JsonSerializable()
class Uxo {
  final String userId;
  final String objectId;
  final bool canDelete;
  final bool canEdit;
  final bool canRead;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Uxo(
    this.userId,
    this.objectId,
    this.canDelete,
    this.canEdit,
    this.canRead,
    this.createdAt,
    this.updatedAt,
  );

  factory Uxo.fromJson(Map<String, dynamic> json) => _$UxoFromJson(json);

  Map<String, dynamic> toJson() => _$UxoToJson(this);
}

@JsonSerializable()
class UxoItem {
  OwnerUser ownerUser;
  Uxo uxo;

  UxoItem(this.ownerUser, this.uxo);

  factory UxoItem.fromJson(Map<String, dynamic> json) =>
      _$UxoItemFromJson(json);

  Map<String, dynamic> toJson() => _$UxoItemToJson(this);
}

@JsonSerializable()
class GetUxoResponse {
  final List<UxoItem> items;

  GetUxoResponse(this.items);

  factory GetUxoResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUxoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUxoResponseToJson(this);
}

@JsonSerializable()
class CreateUxoResponse {
  final UxoItem data;
  final String status;

  CreateUxoResponse(this.data, this.status);

  factory CreateUxoResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateUxoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUxoResponseToJson(this);
}

class CreateUxoDto {
  final bool canRead;
  final bool canEdit;
  final bool canDelete;
  final String recipientEmail;

  CreateUxoDto(this.canRead, this.canEdit, this.canDelete, this.recipientEmail);
}
