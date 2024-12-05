import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:navalistview/core/constants/network_constants.dart';
import 'package:navalistview/core/constants/rest_endpoints.dart';
import 'package:navalistview/src/data/respositories/remote/base/base_album_remote_repository.dart';
import 'package:navalistview/src/domain/models/album.dart';

class JsonpholderAlbumRemoteRepository implements BaseAlbumRemoteRepository {
  final http.Client client;
  JsonpholderAlbumRemoteRepository({required this.client});
  @override
  Future<List<Album>> fetchAllAlbums() async {
    final response = await client.get(Uri.parse('$baseUrl${RestEndpoints.albums}/?_limit=$limit'));
    final List<Album> albums = [];

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (var rawAlbum in data) {
        albums.add(Album.fromJson(rawAlbum));
      }

      return albums;
    } else {
      throw Exception('Failed to fetch albums');
    }
  }
}
