import 'package:isar/isar.dart';
import 'package:navalistview/core/persistence/isar_db.dart';
import 'package:navalistview/src/data/respositories/local/base/base_album_local_repository.dart';
import 'package:navalistview/src/domain/models/album.dart';

class IsarAlbumLocalRepository implements BaseAlbumLocalRepository {
  @override
  Future<List<Album>> fetchAllAlbums() async => await IsarDb.isarDb.txn(() => IsarDb.isarDb.albums.where().anyId().findAll());

  @override
  Future<void> addAlbums({required List<Album> albums}) async {
    await IsarDb.isarDb.writeTxn(() async {
      await IsarDb.isarDb.albums.putAll(albums);
    });
  }

  @override
  Future<void> refreshAlbums({required List<Album> freshAlbums}) async => await IsarDb.isarDb.writeTxn(() async {
        IsarDb.isarDb.albums.clear();
        IsarDb.isarDb.albums.putAll(freshAlbums);
      });
}
