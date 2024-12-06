import 'package:navalistview/src/domain/models/photo.dart';

abstract class BasePhotoLocalRepository {
  Future<List<Photo>> fetchPhotosInAlbum({required int albumId});
  Future<void> addPhotos({required List<Photo> newPhotos, required int albumId});
}
