import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navalistview/src/presentation/views/albums/components/album_card.dart';
import 'package:navalistview/src/presentation/common_components/shimmers/album_card_shimmer.dart';
import 'package:navalistview/src/presentation/controller_cubits/albums_view_controller_cubit.dart';
import 'package:navalistview/src/presentation/controller_cubits/states/home_states.dart';

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
      if (_controller.position.pixels > _controller.position.maxScrollExtent) {
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
        child: BlocBuilder<AlbumsViewControllerCubit, HomeState>(
          builder: (ctx, state) {
            if (state is HomeLoading) {
              return ListView(
                children: List.generate(
                  (MediaQuery.of(context).size.height) ~/ (MediaQuery.of(context).size.height * 0.2),
                  (i) => const AlbumCardShimmer(),
                ),
              );
            }
            if (state is HomeLoaded) {
              return ListView.builder(
                controller: _controller,
                itemCount: state.albums.length,
                itemBuilder: (ctx, i) => const AlbumCard(),
              );
            } else {
              return const Placeholder();
            }
          },
        ),
      ),
    );
  }
}
