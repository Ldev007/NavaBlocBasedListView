import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:navalistview/src/domain/models/photo.dart';

part 'album.g.dart';

@JsonSerializable()
@Collection()
@Name('Albums')
class Album {
  final int userId;
  final Id id;
  final String title;
  final photos = IsarLinks<Photo>();

  Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
