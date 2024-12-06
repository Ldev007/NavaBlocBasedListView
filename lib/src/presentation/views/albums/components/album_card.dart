import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navalistview/src/domain/models/album.dart';
import 'package:navalistview/src/presentation/common_components/shimmers/photo_card_shimmer.dart';
import 'package:navalistview/src/presentation/controller_cubits/album_controller_cubit.dart';
import 'package:navalistview/src/presentation/controller_cubits/states/album_states.dart';
import 'package:navalistview/src/presentation/views/albums/components/more_photos_loading_indicator.dart';
import 'package:navalistview/src/presentation/views/albums/components/photo_card.dart';

class AlbumCard extends StatefulWidget {
  const AlbumCard({super.key, required this.album});

  final Album album;

  @override
  State<AlbumCard> createState() => _AlbumCardState();
}

class _AlbumCardState extends State<AlbumCard> {
  final ScrollController _listController = ScrollController();
  @override
  void initState() {
    context.read<AlbumControllerCubit>().fetchPhotosForAlbum(albumId: widget.album.id);
    _listController.addListener(() {
      if (_listController.position.pixels > _listController.position.maxScrollExtent - 200 &&
          context.read<AlbumControllerCubit>().state is! AlbumInitLoading &&
          context.read<AlbumControllerCubit>().state is! AlbumLoadedLoading) {
        context.read<AlbumControllerCubit>().fetchPhotosForAlbum(albumId: widget.album.id);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                widget.album.title,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(
                child: BlocBuilder<AlbumControllerCubit, AlbumState>(
                  builder: (ctx, state) {
                    if (state is AlbumInit) {
                      return const Center(child: Text('No photos added'));
                    }
                    if (state is AlbumInitLoading) {
                      return ListView(
                        children: List.generate(
                          (MediaQuery.of(context).size.width) ~/ (MediaQuery.of(context).size.width * 0.25),
                          (i) => const PhotoCardShimmer(),
                        ),
                      );
                    }
                    if (state is AlbumLoadedLoading) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _listController,
                        itemCount: state.photos.length + 1,
                        itemBuilder: (ctx, i) => i == state.photos.length ? const MorePhotosLoadingIndicator() : PhotoCard(photo: state.photos[i]),
                      );
                    }
                    if (state is AlbumLoaded) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _listController,
                        itemCount: state.photos.length,
                        itemBuilder: (ctx, i) => PhotoCard(photo: state.photos[i]),
                      );
                    }

                    return const Center(
                      child: Text('Something went wrong, please refresh the page or try again later'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
