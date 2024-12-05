import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navalistview/src/presentation/controller_cubits/album_controller_cubit.dart';
import 'package:navalistview/src/presentation/controller_cubits/albums_view_controller_cubit.dart';
import 'package:navalistview/src/presentation/views/albums/albums_view.dart';

class NavaBlocBasedListView extends StatelessWidget {
  const NavaBlocBasedListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AlbumsViewControllerCubit(),
          ),
          BlocProvider(
            create: (context) => AlbumControllerCubit(),
          )
        ],
        child: const AlbumsView(),
      ),
    );
  }
}
