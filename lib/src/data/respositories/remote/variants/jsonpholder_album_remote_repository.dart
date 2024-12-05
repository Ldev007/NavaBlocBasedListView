import 'package:http/http.dart' as http;
import 'package:navalistview/src/data/respositories/remote/base/base_album_remote_repository.dart';
import 'package:navalistview/src/domain/models/album.dart';

class JsonpholderAlbumRemoteRepository implements BaseAlbumRemoteRepository {
  final http.Client client;
  JsonpholderAlbumRemoteRepository({required this.client});
  @override
  Future<List<Album>> fetchAllAlbums() async {
    // TODO: implement fetchAllAlbums
    throw UnimplementedError();
  }
}
