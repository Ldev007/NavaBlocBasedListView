import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navalistview/src/presentation/controller_cubits/album_controller_cubit.dart';
import 'package:navalistview/src/presentation/controller_cubits/states/album_states.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumControllerCubit, AlbumState>(builder: (ctx, state) {
      if (state is AlbumLoading) {
        return const Placeholder();
      }
      if (state is AlbumLoaded) {
        return const Placeholder();
      } else {
        return const Placeholder();
      }
    });
  }
}
