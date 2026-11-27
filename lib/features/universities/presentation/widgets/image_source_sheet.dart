import 'package:flutter/material.dart';
import 'package:universities_app/features/universities/domain/entities/image_origin.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet({super.key});

  static Future<ImageOrigin?> show(BuildContext context) {
    return showModalBottomSheet<ImageOrigin?>(
      context: context,
      builder: (sheetContext) => const SafeArea(child: ImageSourceSheet()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.photo_camera_outlined),
          title: Text(l10n.camera),
          onTap: () => Navigator.of(context).pop(ImageOrigin.camera),
        ),
        ListTile(
          leading: const Icon(Icons.photo_library_outlined),
          title: Text(l10n.gallery),
          onTap: () => Navigator.of(context).pop(ImageOrigin.gallery),
        ),
      ],
    );
  }
}
