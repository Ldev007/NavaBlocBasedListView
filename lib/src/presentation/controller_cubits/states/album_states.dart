import 'package:navalistview/src/domain/models/photo.dart';

class AlbumState {}

class AlbumInit extends AlbumState {}

class AlbumInitLoading extends AlbumState {}

class AlbumLoadedLoading extends AlbumState {
  final List<Photo> photos;

  AlbumLoadedLoading({required this.photos});
}

class AlbumLoaded extends AlbumState {
  final List<Photo> photos;

  AlbumLoaded({required this.photos});
}

class AlbumError extends AlbumState {
  final String message;

  AlbumError({required this.message});
}
