import 'package:navalistview/src/domain/models/photo.dart';

class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Photo> photos;

  AlbumLoaded({required this.photos});
}

class AlbumError extends AlbumState {
  final String message;

  AlbumError({required this.message});
}
