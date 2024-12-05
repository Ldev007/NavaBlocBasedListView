import 'package:flutter/material.dart';
import 'package:navalistview/src/presentation/views/home_view.dart';

class NavaBlocBasedListView extends StatelessWidget {
  const NavaBlocBasedListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
