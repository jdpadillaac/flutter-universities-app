import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/core/theme/app_colors.dart';
import 'package:universities_app/core/theme/app_radius.dart';
import 'package:universities_app/core/theme/app_sizes.dart';
import 'package:universities_app/core/theme/app_spacing.dart';
import 'package:universities_app/features/universities/domain/entities/image_origin.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_event.dart';
import 'package:universities_app/features/universities/presentation/widgets/dashed_border_painter.dart';
import 'package:universities_app/features/universities/presentation/widgets/image_source_sheet.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class UniversityImagePicker extends StatelessWidget {
  const UniversityImagePicker({required this.imagePath, super.key});

  final String? imagePath;

  Future<void> _pickFromSheet(BuildContext context) async {
    final origin = await ImageSourceSheet.show(context);
    if (origin == null || !context.mounted) {
      return;
    }
    context.read<UniversityDetailBloc>().add(
      UniversityImagePickRequested(origin),
    );
  }

  @override
  Widget build(BuildContext context) {
    final path = imagePath;
    if (path != null && path.isNotEmpty) {
      return UniversityImagePreview(
        imagePath: path,
        onChange: () => _pickFromSheet(context),
      );
    }
    return const UniversityImagePickerPlaceholder();
  }
}

class UniversityImagePickerPlaceholder extends StatelessWidget {
  const UniversityImagePickerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(radius: AppRadius.card),
      child: Container(
        height: AppSizes.imagePickerHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ImagePickerPlaceholderIcon(),
            SizedBox(height: AppSpacing.md),
            _ImagePickerActions(),
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
              child: _ChangeImageButton(onPressed: onChange),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePickerPlaceholderIcon extends StatelessWidget {
  const _ImagePickerPlaceholderIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.image_outlined,
      size: AppSizes.iconLg,
      color: AppColors.primaryStrong,
    );
  }
}

class _ImagePickerActions extends StatelessWidget {
  const _ImagePickerActions();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: [
          Expanded(child: _CameraButton()),
          SizedBox(width: AppSpacing.sm),
          Expanded(child: _GalleryButton()),
        ],
      ),
    );
  }
}

class _CameraButton extends StatelessWidget {
  const _CameraButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () => context.read<UniversityDetailBloc>().add(
        const UniversityImagePickRequested(ImageOrigin.camera),
      ),
      icon: const Icon(Icons.photo_camera_outlined, size: AppSizes.iconSm),
      label: Text(AppLocalizations.of(context).camera),
    );
  }
}

class _GalleryButton extends StatelessWidget {
  const _GalleryButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => context.read<UniversityDetailBloc>().add(
        const UniversityImagePickRequested(ImageOrigin.gallery),
      ),
      icon: const Icon(Icons.photo_library_outlined, size: AppSizes.iconSm),
      label: Text(AppLocalizations.of(context).gallery),
    );
  }
}

class _ChangeImageButton extends StatelessWidget {
  const _ChangeImageButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(AppLocalizations.of(context).changeImage),
    );
  }
}
