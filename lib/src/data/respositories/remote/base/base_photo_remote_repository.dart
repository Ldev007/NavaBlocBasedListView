abstract class BasePhotoRemoteRepository {
  Future<void> fetchPhotosInAlbum({required String albumId});
}
