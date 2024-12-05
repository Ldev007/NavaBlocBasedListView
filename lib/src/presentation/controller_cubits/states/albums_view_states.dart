import 'package:navalistview/src/domain/models/album.dart';

class AlbumsViewState {}

class AlbumsViewInit extends AlbumsViewState {}

class AlbumsViewInitLoading extends AlbumsViewState {}

class AlbumsViewLoadedLoading extends AlbumsViewState {
  final List<Album> albums;

  AlbumsViewLoadedLoading({required this.albums});
}

class AlbumsViewLoaded extends AlbumsViewState {
  final List<Album> albums;

  AlbumsViewLoaded({required this.albums});
}

class AlbumsViewError extends AlbumsViewState {
  final String message;

  AlbumsViewError({required this.message});
}
