import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/image_origin.dart';
import 'package:universities_app/features/universities/domain/repositories/image_picker_repository.dart';

@LazySingleton(as: ImagePickerRepository)
class ImagePickerRepositoryImpl implements ImagePickerRepository {
  ImagePickerRepositoryImpl(this._picker);

  final ImagePicker _picker;

  static const _permissionDeniedCodes = {
    'camera_access_denied',
    'photo_access_denied',
  };

  @override
  Future<Result<String?, Failure>> pick(ImageOrigin origin) {
    final imageSource = switch (origin) {
      ImageOrigin.camera => ImageSource.camera,
      ImageOrigin.gallery => ImageSource.gallery,
    };

    return Result.asyncOf<XFile?, PlatformException>(
      () => _picker.pickImage(source: imageSource),
    ).then((result) {
      return result.match((file) {
        if (file == null) {
          return const Ok<String?, Failure>(null);
        }
        return Ok<String?, Failure>(file.path);
      }, (error) => Err<String?, Failure>(_mapPlatformException(error)));
    });
  }

  Failure _mapPlatformException(PlatformException error) {
    if (_permissionDeniedCodes.contains(error.code)) {
      return const PermissionDeniedFailure();
    }
    if (error.code == 'no_available_camera') {
      return const CameraUnavailableFailure();
    }
    return UnexpectedFailure(message: error.message ?? 'Failed to pick image.');
  }
}
