import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/core/media/image_picker_service.dart';
import 'package:universities_app/core/theme/app_colors.dart';
import 'package:universities_app/core/theme/app_radius.dart';
import 'package:universities_app/core/theme/app_sizes.dart';
import 'package:universities_app/core/theme/app_spacing.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_event.dart';
import 'package:universities_app/features/universities/presentation/widgets/dashed_border_painter.dart';
import 'package:universities_app/features/universities/presentation/widgets/image_source_sheet.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class UniversityImagePicker extends StatelessWidget {
  const UniversityImagePicker({required this.imagePath, super.key});

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final path = imagePath;
    if (path != null && path.isNotEmpty) {
      return UniversityImagePreview(
        imagePath: path,
        onChange: () => ImageSourceSheet.show(context),
      );
    }
    return const UniversityImagePickerPlaceholder();
  }
}

class UniversityImagePickerPlaceholder extends StatelessWidget {
  const UniversityImagePickerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CustomPaint(
      painter: DashedBorderPainter(radius: AppRadius.card),
      child: Container(
        height: AppSizes.imagePickerHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.image_outlined,
              size: AppSizes.imagePickerIcon,
              color: AppColors.primaryStrong,
            ),
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => context.read<UniversityDetailBloc>().add(
                        const UniversityImagePickRequested(
                          ImagePickSource.camera,
                        ),
                      ),
                      icon: const Icon(Icons.photo_camera_outlined, size: 18),
                      label: Text(l10n.camera),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => context.read<UniversityDetailBloc>().add(
                        const UniversityImagePickRequested(
                          ImagePickSource.gallery,
                        ),
                      ),
                      icon: const Icon(Icons.photo_library_outlined, size: 18),
                      label: Text(l10n.gallery),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UniversityImagePreview extends StatelessWidget {
  const UniversityImagePreview({
    required this.imagePath,
    required this.onChange,
    super.key,
  });

  final String imagePath;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: SizedBox(
        height: AppSizes.imagePickerHeight,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(File(imagePath), fit: BoxFit.cover),
            Positioned(
              right: AppSpacing.md,
              bottom: AppSpacing.md,
              child: FilledButton(
                onPressed: onChange,
                child: Text(l10n.changeImage),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
