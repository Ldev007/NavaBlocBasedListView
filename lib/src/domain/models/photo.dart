import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
@collection
@Name('Photos')
class Photo {
  final int albumId;
  @JsonKey(includeFromJson: false, includeToJson: false, includeIfNull: false)
  Id id = Isar.autoIncrement;

  @JsonKey(name: 'id')
  final int photoId;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({
    required this.albumId,
    required this.photoId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
