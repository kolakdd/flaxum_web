import 'package:json_annotation/json_annotation.dart';

part 'flaxum_object.g.dart';

@JsonSerializable()
class FlaxumObject {
  final String id;
  final String? parentId;
  final String ownerId;
  final String creatorId;
  final String name;
  final int? size;
  final String type;
  final String? mimetype;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool inTrash;
  final bool eliminated;

  FlaxumObject(
      this.id,
      this.parentId,
      this.ownerId,
      this.creatorId,
      this.name,
      this.size,
      this.type,
      this.mimetype,
      this.createdAt,
      this.updatedAt,
      this.inTrash,
      this.eliminated);

  factory FlaxumObject.fromJson(Map<String, dynamic> json) =>
      _$FlaxumObjectFromJson(json);

  Map<String, dynamic> toJson() => _$FlaxumObjectToJson(this);
}

@JsonSerializable()
class GetOwnObjectsResponse {
  final List<FlaxumObject> items;
  final int limit;
  final int offset;
  final int total;

  GetOwnObjectsResponse(this.items, this.limit, this.offset, this.total);

  factory GetOwnObjectsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOwnObjectsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetOwnObjectsResponseToJson(this);
}

@JsonSerializable()
class CreateFolderResponse {
  final FlaxumObject data;
  final String status;

  CreateFolderResponse(this.data, this.status);

  factory CreateFolderResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateFolderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateFolderResponseToJson(this);
}
