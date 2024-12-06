import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:navalistview/core/exceptions/no_internet_exception.dart';
import 'package:navalistview/core/network_connectivity_checker.dart';
import 'package:navalistview/src/data/respositories/local/base/base_album_local_repository.dart';
import 'package:navalistview/src/data/respositories/local/variants/isar_album_local_repository.dart';
import 'package:navalistview/src/data/respositories/remote/base/base_album_remote_repository.dart';
import 'package:navalistview/src/data/respositories/remote/variants/jsonpholder_album_remote_repository.dart';
import 'package:navalistview/src/domain/models/album.dart';
import 'package:navalistview/src/presentation/controller_cubits/states/albums_view_states.dart';

class AlbumsViewControllerCubit extends Cubit<AlbumsViewState> {
  AlbumsViewControllerCubit({
    required this.client,
  }) : super(AlbumsViewInit()) {
    _remoteRepository = JsonpholderAlbumRemoteRepository(client: client);
  }

  late final BaseAlbumRemoteRepository _remoteRepository;
  final BaseAlbumLocalRepository _localRepository = IsarAlbumLocalRepository();
  final Client client;

  Future<void> fetchAlbums() async {
    try {
      if (!(NetworkConnectivityChecker.hasInternet ?? true)) {
        if (state is AlbumsViewInit || state is AlbumsViewError) {
          final albumsFromLocal = await _localRepository.fetchAllAlbums();
          if (albumsFromLocal.isNotEmpty) {
            emit(AlbumsViewFetchedFromLocalInit(albums: albumsFromLocal));
            return;
          } else {
            emit(AlbumsViewError(message: 'No internet, please check and pull down to refresh'));
            return;
          }
        } else if (state is AlbumsViewFetchedFromLocalInit) {
          return;
        }
      }

      if (state is AlbumsViewInit) {
        // check if available in local
        final albumsFromLocal = await _localRepository.fetchAllAlbums();
        if (albumsFromLocal.isNotEmpty) {
          emit(AlbumsViewFetchedFromLocalInit(albums: albumsFromLocal));
          return;
        } else {
          emit(AlbumsViewInitLoading());
        }
      } else if (state is AlbumsViewFetchedFromRemote) {
        final currentState = (state as AlbumsViewFetchedFromRemote);
        emit(AlbumsViewPreFetchedFromRemoteFetchingMore(albums: currentState.albums));
      }

      final List<Album> albumsFromRemote = await _remoteRepository.fetchAllAlbums();
      await _localRepository.addAlbums(albums: albumsFromRemote);

      if (state is AlbumsViewPreFetchedFromRemoteFetchingMore) {
        final currentState = (state as AlbumsViewPreFetchedFromRemoteFetchingMore);
        currentState.albums.addAll(albumsFromRemote);
        emit(AlbumsViewFetchedFromRemote(albums: List.from(currentState.albums)));
      } else {
        emit(AlbumsViewFetchedFromRemote(albums: albumsFromRemote));
      }
    } catch (e, s) {
      log('Exception while fetching albums', error: e, stackTrace: s);
      if (e is NoInternetException) {
        Fluttertoast.showToast(msg: 'No internet, please check and try again');
        return;
      } else if (e is SocketException) {
        emit(AlbumsViewFetchedFromLocalWithoutInternet(albums: (state as AlbumsViewPreFetchedFromRemoteFetchingMore).albums));
        return;
      }
      emit(AlbumsViewError(message: 'Something went wrong\nPlease refresh or try again later'));
    }
  }

  Future<void> refreshAlbums() async {
    if (!(NetworkConnectivityChecker.hasInternet ?? true)) {
      final albumsFromLocal = await _localRepository.fetchAllAlbums();
      if (albumsFromLocal.isNotEmpty) {
        emit(AlbumsViewFetchedFromLocalWithoutInternet(albums: albumsFromLocal));
        return;
      }
    }

    if (state is! AlbumsViewInitLoading) {
      try {
        if (state is AlbumsViewFetchedFromRemote) {
          (state as AlbumsViewFetchedFromRemote).albums.clear();
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
        } else if (e is SocketException) {
          emit(AlbumsViewFetchedFromLocalWithoutInternet(albums: (state as AlbumsViewPreFetchedFromRemoteFetchingMore).albums));
          return;
        }
        emit(AlbumsViewError(message: 'Something went wrong\nPlease refresh or try again later'));
      }
    } else {
      return;
    }
  }
}
