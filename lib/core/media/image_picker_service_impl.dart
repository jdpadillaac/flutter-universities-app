import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/media/image_picker_service.dart';

@LazySingleton(as: ImagePickerService)
class ImagePickerServiceImpl implements ImagePickerService {
  ImagePickerServiceImpl(this._picker);

  final ImagePicker _picker;

  static const _permissionDeniedCodes = {
    'camera_access_denied',
    'photo_access_denied',
  };

  @override
  Future<ImagePickResult> pick(ImagePickSource source) async {
    final imageSource = switch (source) {
      ImagePickSource.camera => ImageSource.camera,
      ImagePickSource.gallery => ImageSource.gallery,
    };

    final result = await Result.asyncOf<XFile?, PlatformException>(
      () => _picker.pickImage(source: imageSource),
    );
    final mapped = result.match(
      (file) {
        if (file == null) {
          return const ImagePickCancelled();
        }
        return ImagePicked(file.path);
      },
      (error) {
        if (_permissionDeniedCodes.contains(error.code)) {
          return const ImagePickPermissionDenied();
        }
        return ImagePickFailed(error.message ?? 'Failed to pick image.');
      },
    );
    return mapped;
  }
}
