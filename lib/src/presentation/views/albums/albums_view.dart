import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navalistview/src/presentation/common_components/shimmers/album_card_shimmer.dart';
import 'package:navalistview/src/presentation/controller_cubits/albums_view_controller_cubit.dart';
import 'package:navalistview/src/presentation/controller_cubits/states/albums_view_states.dart';
import 'package:navalistview/src/presentation/views/albums/components/album_card.dart';
import 'package:navalistview/src/presentation/views/albums/components/more_albums_loading_indicator.dart';

class AlbumsView extends StatefulWidget {
  const AlbumsView({super.key});

  @override
  State<AlbumsView> createState() => _AlbumsViewState();
}

class _AlbumsViewState extends State<AlbumsView> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    context.read<AlbumsViewControllerCubit>().fetchAlbums();
    _controller.addListener(() {
      if (_controller.position.pixels > _controller.position.maxScrollExtent - 200 &&
          context.read<AlbumsViewControllerCubit>().state is! AlbumsViewInitLoading &&
          context.read<AlbumsViewControllerCubit>().state is! AlbumsViewLoadedLoading) {
        context.read<AlbumsViewControllerCubit>().fetchAlbums();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Albums',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<AlbumsViewControllerCubit>().refreshAlbums(),
          child: BlocBuilder<AlbumsViewControllerCubit, AlbumsViewState>(
            builder: (ctx, state) {
              if (state is AlbumsViewInitLoading) {
                return ListView(
                  children: List.generate(
                    (MediaQuery.of(context).size.height) ~/ (MediaQuery.of(context).size.height * 0.2),
                    (i) => const AlbumCardShimmer(),
                  ),
                );
              }
              if (state is AlbumsViewLoadedLoading) {
                return ListView.separated(
                  controller: _controller,
                  itemCount: state.albums.length + 1,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  itemBuilder: (ctx, i) => i == state.albums.length ? const MoreAlbumsLoadingIndicator() : AlbumCard(album: state.albums[i]),
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                );
              }
              if (state is AlbumsViewLoaded) {
                return ListView.separated(
                  controller: _controller,
                  itemCount: state.albums.length,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  itemBuilder: (ctx, i) => AlbumCard(album: state.albums[i]),
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                );
              } else {
                return const Placeholder();
              }
            },
          ),
        ),
      ),
    );
  }
}
