import 'package:flutter/material.dart';
import 'package:navalistview/src/domain/models/photo.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({super.key, required this.photo});

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      child: Card(
        elevation: 2,
        shadowColor: Colors.grey.shade600,
        child: Center(
          child: Text(
            'P${photo.photoId}',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
