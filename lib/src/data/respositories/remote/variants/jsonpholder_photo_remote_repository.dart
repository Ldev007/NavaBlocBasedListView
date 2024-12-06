import 'dart:convert';

import 'package:http/http.dart';
import 'package:navalistview/core/constants/network_constants.dart';
import 'package:navalistview/core/constants/rest_endpoints.dart';
import 'package:navalistview/src/data/respositories/remote/base/base_photo_remote_repository.dart';
import 'package:navalistview/src/domain/models/photo.dart';

class JsonpholderPhotoRemoteRepository implements BasePhotoRemoteRepository {
  final Client client;
  JsonpholderPhotoRemoteRepository({required this.client});

  @override
  Future<List<Photo>> fetchPhotosInAlbum({required int albumId}) async {
    final response = await client.get(Uri.parse('$baseUrl${RestEndpoints.photos}/?_limit=$limit'));
    final List<Photo> photos = [];

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (var rawPhoto in data) {
        photos.add(Photo.fromJson(rawPhoto));
      }

      return photos;
    } else {
      throw Exception('Failed to fetch photos');
    }
  }
}
