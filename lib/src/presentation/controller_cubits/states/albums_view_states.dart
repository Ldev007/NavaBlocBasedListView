import 'package:navalistview/src/domain/models/album.dart';

class AlbumsViewState {}

class AlbumsViewInit extends AlbumsViewState {}

class AlbumsViewInitLoading extends AlbumsViewState {}

class AlbumsViewPreFetchedFromRemoteFetchingMore extends AlbumsViewState {
  final List<Album> albums;

  AlbumsViewPreFetchedFromRemoteFetchingMore({required this.albums});
}

class AlbumsViewFetched extends AlbumsViewState {
  final List<Album> albums;

  AlbumsViewFetched({required this.albums});
}

// states wrt remote
class AlbumsViewFetchedFromRemote extends AlbumsViewFetched {
  AlbumsViewFetchedFromRemote({required super.albums});
}

// states wrt local
class AlbumsViewFetchedFromLocalWithoutInternet extends AlbumsViewFetched {
  AlbumsViewFetchedFromLocalWithoutInternet({required super.albums});
}

class AlbumsViewFetchedFromLocalInit extends AlbumsViewFetched {
  AlbumsViewFetchedFromLocalInit({required super.albums});
}

class AlbumsViewFetchedFromLocalOnRefresh extends AlbumsViewFetched {
  AlbumsViewFetchedFromLocalOnRefresh({required super.albums});
}

class AlbumsViewError extends AlbumsViewState {
  final String message;

  AlbumsViewError({required this.message});
}
