import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:navalistview/core/connectivity_extension.dart';
import 'package:navalistview/core/exceptions/no_internet_exception.dart';
import 'package:navalistview/src/data/respositories/local/base/base_album_local_repository.dart';
import 'package:navalistview/src/data/respositories/local/variants/isar_album_local_repository.dart';
import 'package:navalistview/src/data/respositories/remote/base/base_album_remote_repository.dart';
import 'package:navalistview/src/data/respositories/remote/variants/jsonpholder_album_remote_repository.dart';
import 'package:navalistview/src/domain/models/album.dart';
import 'package:navalistview/src/presentation/controller_cubits/states/albums_view_states.dart';

class AlbumsViewControllerCubit extends Cubit<AlbumsViewState> {
  AlbumsViewControllerCubit({
    required this.connectivityClient,
    required this.client,
  }) : super(AlbumsViewInit()) {
    _remoteRepository = JsonpholderAlbumRemoteRepository(client: client);
  }

  late final BaseAlbumRemoteRepository _remoteRepository;
  final BaseAlbumLocalRepository _localRepository = IsarAlbumLocalRepository();
  final Connectivity connectivityClient;
  final Client client;

  Future<void> fetchAlbums() async {
    try {
      if (state is AlbumsViewInit) {
        // check if available in local
        final albumsFromLocal = await _localRepository.fetchAllAlbums();
        if (albumsFromLocal.isNotEmpty) {
          emit(AlbumsViewFetchedFromLocalInit(albums: albumsFromLocal));
          return;
        } else {
          final res = await Connectivity().checkConnectivity();
          if (res.hasInternet) {
            emit(AlbumsViewInitLoading());
          } else {
            emit(AlbumsViewError(message: 'No internet, please check and try again'));
            return;
          }
        }
      } else if (state is AlbumsViewFetchedFromRemote) {
        final currentState = (state as AlbumsViewFetchedFromRemote);

        final res = await Connectivity().checkConnectivity();
        if (res.hasInternet) {
          emit(AlbumsViewPreFetchedFromRemoteFetchingMore(albums: currentState.albums));
        } else {
          emit(AlbumsViewFetchedFromLocalWithoutInternet(albums: currentState.albums));
          throw NoInternetException();
        }
      }

      final List<Album> albumsFromRemote = await _remoteRepository.fetchAllAlbums();

      if (state is AlbumsViewPreFetchedFromRemoteFetchingMore) {
        final currentState = (state as AlbumsViewPreFetchedFromRemoteFetchingMore);
        currentState.albums.addAll(albumsFromRemote);
        await _localRepository.addAlbums(albums: albumsFromRemote);
        emit(AlbumsViewFetchedFromRemote(albums: List.from(currentState.albums)));
      } else {
        emit(AlbumsViewFetchedFromRemote(albums: albumsFromRemote));
      }
    } catch (e, s) {
      log('Exception while fetching albums', error: e, stackTrace: s);
      if (e is NoInternetException) {
        Fluttertoast.showToast(msg: 'No internet, please check and try again');
        return;
      }
      emit(AlbumsViewError(message: 'Something went wrong\nPlease refresh or try again later'));
    }
  }

  Future<void> refreshAlbums() async {
    try {
      log('Got in here at least');
      final res = await Connectivity().checkConnectivity();
      if (!res.hasInternet) {
        final albumsFromLocal = await _localRepository.fetchAllAlbums();
        if (albumsFromLocal.isNotEmpty) {
          emit(AlbumsViewFetchedFromLocalOnRefresh(albums: albumsFromLocal));
          throw NoInternetException();
        } else {
          emit(AlbumsViewError(message: 'No internet, please check and try again'));
        }
        return;
      }

      if (state is AlbumsViewFetchedFromRemote) {
        if (res.hasInternet) {
          (state as AlbumsViewFetchedFromRemote).albums.clear();
        } else {
          throw NoInternetException();
        }
      }
      emit(AlbumsViewInitLoading());
      final albums = await _remoteRepository.fetchAllAlbums();
      await _localRepository.refreshAlbums(freshAlbums: albums);

      emit(AlbumsViewFetchedFromRemote(albums: albums));
    } catch (e, s) {
      log('Exception while refreshing albums', error: e, stackTrace: s);
      if (e is NoInternetException) {
        Fluttertoast.showToast(msg: 'No internet, please check and try again');
        return;
      }
      emit(AlbumsViewError(message: 'Something went wrong\nPlease refresh or try again later'));
    }
  }
}
