import 'package:flutter/material.dart';
import 'package:navalistview/src/domain/models/photo.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({super.key, required this.photo});

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Image.network(photo.url),
    );
  }
}
