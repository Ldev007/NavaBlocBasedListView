import 'package:isar/isar.dart';
import 'package:navalistview/core/persistence/isar_db.dart';
import 'package:navalistview/src/data/respositories/local/base/base_photo_local_repository.dart';
import 'package:navalistview/src/domain/models/album.dart';
import 'package:navalistview/src/domain/models/photo.dart';

class IsarPhotoLocalRepository implements BasePhotoLocalRepository {
  @override
  Future<List<Photo>> fetchPhotosInAlbum({required int albumId}) async {
    final photos = await IsarDb.isarDb.txn(
      () async => IsarDb.isarDb.albums.where().idEqualTo(albumId).findFirst(),
    );
    return photos?.photos.toList() ?? [];
  }

  @override
  Future<void> addPhotos({required List<Photo> newPhotos, required int albumId}) async {
    Album? currentAlbum = await IsarDb.isarDb.albums.where().idEqualTo(albumId).findFirst();

    await IsarDb.isarDb.writeTxn(() async {
      await IsarDb.isarDb.photos.putAll(newPhotos);
    });

    currentAlbum!.photos.addAll(newPhotos);

    await IsarDb.isarDb.writeTxn(() async {
      await currentAlbum.photos.save();
    });
  }
}
