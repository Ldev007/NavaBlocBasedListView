import 'package:navalistview/src/domain/models/photo.dart';

class AlbumState {}

class AlbumInit extends AlbumState {}

class AlbumInitFetching extends AlbumState {}

class AlbumError extends AlbumState {
  final String message;

  AlbumError({required this.message});
}

class AlbumPreFetchedFromRemoteFetchingMore extends AlbumState {
  final List<Photo> photos;

  AlbumPreFetchedFromRemoteFetchingMore({required this.photos});
}

class AlbumFetched extends AlbumState {
  final List<Photo> photos;

  AlbumFetched({required this.photos});
}

// states wrt remote
class AlbumFetchedFromRemote extends AlbumFetched {
  AlbumFetchedFromRemote({required super.photos});
}

// states wrt local
class AlbumFetchedFromLocalWithoutInternet extends AlbumFetched {
  AlbumFetchedFromLocalWithoutInternet({required super.photos});
}

class AlbumFetchedFromLocalInit extends AlbumFetched {
  AlbumFetchedFromLocalInit({required super.photos});
}

class AlbumFetchedFromLocalOnRefresh extends AlbumFetched {
  AlbumFetchedFromLocalOnRefresh({required super.photos});
}
