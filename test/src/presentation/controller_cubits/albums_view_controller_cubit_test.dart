import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navalistview/src/presentation/controller_cubits/albums_view_controller_cubit.dart';
import 'package:navalistview/src/presentation/controller_cubits/states/albums_view_states.dart';

class MockClient extends Mock implements Client {}

class MockConnectivityClient extends Mock implements Connectivity {}

void main() {
  late final MockClient client;
  late final MockConnectivityClient connectivityClient;

  group('Albums view controller cubit tests', () {
    group('Without internet', () {
      setUpAll(() {
        client = MockClient();
        connectivityClient = MockConnectivityClient();
      });

      when(
        () => connectivityClient.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.none]);

      blocTest(
        'Refresh',
        build: () {
          return AlbumsViewControllerCubit(connectivityClient: connectivityClient, client: client);
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
