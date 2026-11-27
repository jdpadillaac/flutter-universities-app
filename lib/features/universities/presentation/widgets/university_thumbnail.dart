import 'dart:io';

import 'package:flutter/material.dart';

class UniversityThumbnail extends StatelessWidget {
  const UniversityThumbnail({this.imagePath, super.key});

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final path = imagePath;
    if (path == null || path.isEmpty) {
      return const Icon(Icons.school_outlined);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        File(path),
        width: 48,
        height: 48,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image_outlined);
        },
      ),
    );
  }
}
