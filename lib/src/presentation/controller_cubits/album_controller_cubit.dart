import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:navalistview/src/data/respositories/remote/base/base_photo_remote_repository.dart';
import 'package:navalistview/src/data/respositories/remote/variants/jsonpholder_photo_remote_repository.dart';
import 'package:navalistview/src/domain/models/photo.dart';
import 'package:navalistview/src/presentation/controller_cubits/states/album_states.dart';

class AlbumControllerCubit extends Cubit<AlbumState> {
  AlbumControllerCubit() : super(AlbumInit());

  final BasePhotoRemoteRepository _remoteRepository = JsonpholderPhotoRemoteRepository(client: Client());

  Future<void> fetchPhotosForAlbum({required int albumId}) async {
    try {
      if (state is AlbumInit) {
        emit(AlbumInitLoading());
      } else if (state is AlbumLoaded) {
        emit(AlbumLoadedLoading(photos: (state as AlbumLoaded).photos));
      }
      final List<Photo> album = await _remoteRepository.fetchPhotosInAlbum(albumId: albumId);

      if (state is AlbumLoadedLoading) {
        final currentState = (state as AlbumLoadedLoading);
        currentState.photos.addAll(album);
        emit(AlbumLoaded(photos: List.from(currentState.photos)));
      } else {
        emit(AlbumLoaded(photos: album));
      }
    } catch (e, s) {
      log('Exception while fetching album', error: e, stackTrace: s);
      Fluttertoast.showToast(msg: 'Please refresh the page or try again later');
      emit(AlbumError(message: 'Failed to fetch album'));
    }
  }
}
