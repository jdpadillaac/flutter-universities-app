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
        _ImageSourceOption(
          icon: Icons.photo_camera_outlined,
          label: l10n.camera,
          origin: ImageOrigin.camera,
        ),
        _ImageSourceOption(
          icon: Icons.photo_library_outlined,
          label: l10n.gallery,
          origin: ImageOrigin.gallery,
        ),
      ],
    );
  }
}

class _ImageSourceOption extends StatelessWidget {
  const _ImageSourceOption({
    required this.icon,
    required this.label,
    required this.origin,
  });

  final IconData icon;
  final String label;
  final ImageOrigin origin;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () => Navigator.of(context).pop(origin),
    );
  }
}
