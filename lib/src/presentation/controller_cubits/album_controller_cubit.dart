import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navalistview/src/presentation/controller_cubits/states/album_states.dart';

class AlbumControllerCubit extends Cubit<AlbumState> {
  AlbumControllerCubit() : super(AlbumInitial());

  Future<void> fetchPhotosForAlbum() async {
    try {} catch (e) {
      emit(AlbumError(message: 'Unable to load photos, please refresh the page'));
    }
  }
}
