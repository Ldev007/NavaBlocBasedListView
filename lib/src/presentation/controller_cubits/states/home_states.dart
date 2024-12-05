import 'package:navalistview/src/presentation/views/albums/components/album_card.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<AlbumCard> albums;

  HomeLoaded({required this.albums});
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
