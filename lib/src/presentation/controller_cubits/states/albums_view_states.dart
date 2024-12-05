import 'package:navalistview/src/presentation/views/albums/components/album_card.dart';

class AlbumsViewState {}

class AlbumsViewInit extends AlbumsViewState {}

class AlbumsViewLoading extends AlbumsViewState {}

class AlbumsViewLoaded extends AlbumsViewState {
  final List<AlbumCard> albums;

  AlbumsViewLoaded({required this.albums});
}

class AlbumsViewError extends AlbumsViewState {
  final String message;

  AlbumsViewError({required this.message});
}
