import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:navalistview/src/data/respositories/remote/base/base_album_remote_repository.dart';
import 'package:navalistview/src/data/respositories/remote/variants/jsonpholder_album_remote_repository.dart';
import 'package:navalistview/src/domain/models/album.dart';
import 'package:navalistview/src/presentation/controller_cubits/states/albums_view_states.dart';

class AlbumsViewControllerCubit extends Cubit<AlbumsViewState> {
  AlbumsViewControllerCubit() : super(AlbumsViewInit());

  final BaseAlbumRemoteRepository _remoteRepository = JsonpholderAlbumRemoteRepository(client: Client());

  Future<void> fetchAlbums() async {
    try {
      if (state is AlbumsViewInit) {
        emit(AlbumsViewInitLoading());
      } else if (state is AlbumsViewLoaded) {
        emit(AlbumsViewLoadedLoading(albums: (state as AlbumsViewLoaded).albums));
      }
      final List<Album> albums = await _remoteRepository.fetchAllAlbums();

      if (state is AlbumsViewLoadedLoading) {
        final currentState = (state as AlbumsViewLoadedLoading);
        currentState.albums.addAll(albums);
        emit(AlbumsViewLoaded(albums: List.from(currentState.albums)));
      } else {
        emit(AlbumsViewLoaded(albums: albums));
      }
    } catch (e, s) {
      log('Exception while fetching albums', error: e, stackTrace: s);
      Fluttertoast.showToast(msg: 'Please refresh the page or try again later');
      emit(AlbumsViewError(message: 'Failed to fetch albums'));
    }
  }

  Future<void> refreshAlbums() async {
    try {
      emit(AlbumsViewInitLoading());
      final albums = await _remoteRepository.fetchAllAlbums();

      emit(AlbumsViewLoaded(albums: albums));
    } catch (e, s) {
      log('Exception while fetching albums', error: e, stackTrace: s);
      Fluttertoast.showToast(msg: 'Please refresh the page or try again later');
      emit(AlbumsViewError(message: 'Failed to refresh albums'));
    }
  }
}
