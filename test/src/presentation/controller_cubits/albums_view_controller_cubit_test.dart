import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navalistview/core/network_connectivity_checker.dart';
import 'package:navalistview/src/presentation/controller_cubits/albums_view_controller_cubit.dart';
import 'package:navalistview/src/presentation/controller_cubits/states/albums_view_states.dart';

class MockClient extends Mock implements Client {}

void main() {
  late final MockClient client;

  group('Albums view controller cubit tests', () {
    group('Without internet', () {
      setUpAll(() {
        client = MockClient();
      });

      when(
        () => NetworkConnectivityChecker.hasInternet,
      ).thenAnswer((_) => false);

      blocTest(
        'Refresh',
        build: () {
          return AlbumsViewControllerCubit(client: client);
        },
        act: (bloc) {
          return bloc.refreshAlbums();
        },
        expect: () => [isInstanceOf<AlbumsViewError>()],
      );

      // blocTest(
      //   'Init without local data',
      //   build: () => AlbumsViewControllerCubit(connectivityClient: connectivityClient, client: client),
      //   act: (bloc) => bloc.fetchAlbums(),
      //   expect: () => [isInstanceOf<AlbumsViewError>()],
      // );

      // blocTest('Load more albums with some local data', () {});
    });
  });
}
