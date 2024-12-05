import 'package:flutter/material.dart';
import 'package:navalistview/src/presentation/common_components/loading_shimmer.dart';

class PhotoCardShimmer extends StatelessWidget {
  const PhotoCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingShimmer(
        child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      child: const Card(),
    ));
  }
}
