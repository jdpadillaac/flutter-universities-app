import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/core/media/image_picker_service.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_event.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet({required this.blocContext, super.key});

  final BuildContext blocContext;

  static Future<void> show(BuildContext blocContext) {
    return showModalBottomSheet<void>(
      context: blocContext,
      builder: (sheetContext) {
        return SafeArea(child: ImageSourceSheet(blocContext: blocContext));
      },
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
          onTap: () {
            Navigator.of(context).pop();
            blocContext.read<UniversityDetailBloc>().add(
              const UniversityImagePickRequested(ImagePickSource.camera),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo_library_outlined),
          title: Text(l10n.gallery),
          onTap: () {
            Navigator.of(context).pop();
            blocContext.read<UniversityDetailBloc>().add(
              const UniversityImagePickRequested(ImagePickSource.gallery),
            );
          },
        ),
      ],
    );
  }
}
