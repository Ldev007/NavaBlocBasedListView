import 'package:flutter/material.dart';
import 'package:navalistview/src/presentation/common_components/loading_shimmer.dart';

class AlbumCardShimmer extends StatelessWidget {
  const AlbumCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingShimmer(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.2,
        child: const Card(),
      ),
    );
  }
}
