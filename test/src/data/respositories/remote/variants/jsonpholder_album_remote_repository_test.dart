import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navalistview/core/constants/network_constants.dart';
import 'package:navalistview/core/constants/rest_endpoints.dart';
import 'package:navalistview/src/data/respositories/remote/variants/jsonpholder_album_remote_repository.dart';
import 'package:navalistview/src/domain/models/album.dart';

class MockClient extends Mock implements Client {}

void main() {
  late final MockClient client;
  late final JsonpholderAlbumRemoteRepository remoteRepository;

  setUpAll(() {
    client = MockClient();
    remoteRepository = JsonpholderAlbumRemoteRepository(client: client);
  });

  group('jsonpholder album remote repository ', () {
    group('Fetch all albums tests -', () {
      test(
        'Given everything is fine, fetchAlbums() should return list of albums',
        () async {
          when(
            () => client.get(
              Uri.parse('$baseUrl${RestEndpoints.albums}/?_limit=$limit'),
            ),
          ).thenAnswer((_) async => Response(
                '''
[
          {
          "userId": 1,
          "id": 1,
          "title": "hola! molestiae enim"
          },
          {
          "userId": 1,
          "id": 2,
          "title": "sunt qui excepturi placeat culpa"
          },
          {
          "userId": 1,
          "id": 3,
          "title": "omnis laborum odio"
          },
          {
          "userId": 1,
          "id": 4,
          "title": "non esse culpa molestiae omnis sed optio"
          },
          {
          "userId": 1,
          "id": 5,
          "title": "eaque aut omnis a"
          },
          {
          "userId": 1,
          "id": 6,
          "title": "natus impedit quibusdam illo est"
          },
          {
          "userId": 1,
          "id": 7,
          "title": "quibusdam autem aliquid et et quia"
          },
          {
          "userId": 1,
          "id": 8,
          "title": "qui fuga est a eum"
          },
          {
          "userId": 1,
          "id": 9,
          "title": "saepe unde necessitatibus rem"
          },
          {
          "userId": 1,
          "id": 10,
          "title": "distinctio laborum qui"
          }
]
          ''',
                200,
              ));
          final response = await remoteRepository.fetchAllAlbums();
          expect(response, isA<List<Album>>());
        },
      );

      test(
        'When status code is not 200 exception should be thrown',
        () async {
          when(
            () => client.get(
              Uri.parse('$baseUrl${RestEndpoints.albums}/?_limit=$limit'),
            ),
          ).thenAnswer((_) async => Response('', 400));

          final future = remoteRepository.fetchAllAlbums();

          expect(future, throwsException);
        },
      );
    });
  });
}
