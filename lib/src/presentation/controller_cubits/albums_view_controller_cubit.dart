import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navalistview/src/presentation/controller_cubits/states/home_states.dart';

class AlbumsViewControllerCubit extends Cubit<HomeState> {
  AlbumsViewControllerCubit() : super(HomeInitial());

  Future<void> fetchAlbums() async {
    try {
      if (state is HomeInitial) {}
    } catch (e) {
      emit(HomeError(message: 'Oops, something went wrong. Please refresh the page'));
    }
  }
}
