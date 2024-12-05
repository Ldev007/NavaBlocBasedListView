import 'package:navalistview/src/domain/models/album.dart';

abstract class BaseAlbumRemoteRepository {
  Future<List<Album>> fetchAllAlbums();
}
