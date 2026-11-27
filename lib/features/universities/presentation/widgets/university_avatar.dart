import 'dart:io';

import 'package:flutter/material.dart';
import 'package:universities_app/core/theme/app_colors.dart';
import 'package:universities_app/core/theme/app_radius.dart';
import 'package:universities_app/core/theme/app_typography.dart';

class UniversityAvatar extends StatelessWidget {
  const UniversityAvatar({
    required this.initials,
    required this.size,
    this.imagePath,
    super.key,
  });

  final String initials;
  final double size;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final path = imagePath;
    if (path != null && path.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.control),
        child: Image.file(
          File(path),
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return UniversityAvatarFallback(initials: initials, size: size);
          },
        ),
      );
    }
    return UniversityAvatarFallback(initials: initials, size: size);
  }
}

class UniversityAvatarFallback extends StatelessWidget {
  const UniversityAvatarFallback({
    required this.initials,
    required this.size,
    super.key,
  });

  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.control),
      ),
      alignment: Alignment.center,
      child: Text(initials, style: AppTypography.avatarInitials),
    );
  }
}
