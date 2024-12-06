import 'package:navalistview/src/domain/models/photo.dart';

abstract class BasePhotoRemoteRepository {
  Future<List<Photo>> fetchPhotosInAlbum({required int albumId});
}
