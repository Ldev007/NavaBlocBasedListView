import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:navalistview/core/exceptions/no_internet_exception.dart';
import 'package:navalistview/core/network_connectivity_checker.dart';
import 'package:navalistview/src/data/respositories/local/base/base_photo_local_repository.dart';
import 'package:navalistview/src/data/respositories/local/variants/isar_photo_local_repository.dart';
import 'package:navalistview/src/data/respositories/remote/base/base_photo_remote_repository.dart';
import 'package:navalistview/src/data/respositories/remote/variants/jsonpholder_photo_remote_repository.dart';
import 'package:navalistview/src/domain/models/photo.dart';
import 'package:navalistview/src/presentation/controller_cubits/states/album_states.dart';

class AlbumControllerCubit extends Cubit<AlbumState> {
  AlbumControllerCubit({required this.client}) : super(AlbumInit()) {
    _remoteRepository = JsonpholderPhotoRemoteRepository(client: client);
  }

  late final BasePhotoRemoteRepository _remoteRepository;
  final BasePhotoLocalRepository _localRepository = IsarPhotoLocalRepository();
  final Client client;

  Future<void> fetchPhotosForAlbum({required int albumId}) async {
    try {
      if (!(NetworkConnectivityChecker.hasInternet ?? true)) {
        if (state is AlbumInit || state is AlbumError) {
          // check if available in local
          final photosFromLocal = await _localRepository.fetchPhotosInAlbum(albumId: albumId);
          if (photosFromLocal.isNotEmpty) {
            emit(AlbumFetchedFromLocalInit(photos: photosFromLocal));
            return;
          } else {
            emit(AlbumError(message: 'No internet, please check and try again'));
            return;
          }
        }
      }
      if (state is AlbumInit) {
        // check if available in local
        final photosFromLocal = await _localRepository.fetchPhotosInAlbum(albumId: albumId);
        if (photosFromLocal.isNotEmpty) {
          emit(AlbumFetchedFromLocalInit(photos: photosFromLocal));
          return;
        } else {
          emit(AlbumInitFetching());
        }
      } else if (state is AlbumFetchedFromRemote) {
        final currentState = (state as AlbumFetchedFromRemote);
        emit(AlbumPreFetchedFromRemoteFetchingMore(photos: currentState.photos));
      }

      final List<Photo> photosFromRemote = await _remoteRepository.fetchPhotosInAlbum(albumId: albumId);
      await _localRepository.addPhotos(newPhotos: photosFromRemote, albumId: albumId);

      if (state is AlbumPreFetchedFromRemoteFetchingMore) {
        final currentState = (state as AlbumPreFetchedFromRemoteFetchingMore);
        currentState.photos.addAll(photosFromRemote);
        emit(AlbumFetchedFromRemote(photos: List.from(currentState.photos)));
      } else {
        emit(AlbumFetchedFromRemote(photos: photosFromRemote));
      }
    } catch (e, s) {
      log('Exception while fetching photos for album :$albumId', error: e, stackTrace: s);
      if (e is NoInternetException) {
        emit(AlbumError(message: 'No internet'));
      } else if (e is SocketException) {
        emit(AlbumFetchedFromLocalWithoutInternet(photos: (state as AlbumFetchedFromLocalWithoutInternet).photos));
        return;
      }
      emit(AlbumError(message: 'Failed to fetch photos'));
    }
  }
}
