import 'package:navalistview/src/domain/models/album.dart';

abstract class BaseAlbumLocalRepository {
  Future<List<Album>> fetchAllAlbums();
  Future<void> addAlbums({required List<Album> albums});
  Future<void> refreshAlbums({required List<Album> freshAlbums});
}
