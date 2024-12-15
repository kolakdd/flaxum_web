import 'package:json_annotation/json_annotation.dart';

part 'object_.g.dart';

@JsonSerializable()
class Object_ {
  final String id;
  final String? parent_id;
  final String owner_id;
  final String creator_id;
  final String name;
  final int? size;
  final String type;
  final String? mimetype;
  final DateTime created_at;
  final DateTime? updated_at;
  final bool in_trash;
  final bool eliminated;

  Object_(
      this.id,
      this.parent_id,
      this.owner_id,
      this.creator_id,
      this.name,
      this.size,
      this.type,
      this.mimetype,
      this.created_at,
      this.updated_at,
      this.in_trash,
      this.eliminated);

  factory Object_.fromJson(Map<String, dynamic> json) =>
      _$Object_FromJson(json);

  Map<String, dynamic> toJson() => _$Object_ToJson(this);
}

@JsonSerializable()
class GetOwnObjectsResponse {
  final List<Object_> data;
  final int limit;
  final int offset;
  final String status;

  GetOwnObjectsResponse(this.data, this.limit, this.offset, this.status);

  factory GetOwnObjectsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOwnObjectsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetOwnObjectsResponseToJson(this);
}


@JsonSerializable()
class CreateFolderResponse {
  final Object_ data;
  final String status;

  CreateFolderResponse(this.data, this.status);

  factory CreateFolderResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateFolderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateFolderResponseToJson(this);
}


