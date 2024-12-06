import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:navalistview/src/domain/models/photo.dart';

part 'album.g.dart';

@JsonSerializable()
@Collection()
@Name('Albums')
class Album {
  @JsonKey(includeFromJson: false, includeToJson: false, includeIfNull: false)
  final Id id = Isar.autoIncrement;

  final int userId;
  @JsonKey(name: 'id')
  final int albumId;
  final String title;
  final photos = IsarLinks<Photo>();

  Album({required this.userId, required this.albumId, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
