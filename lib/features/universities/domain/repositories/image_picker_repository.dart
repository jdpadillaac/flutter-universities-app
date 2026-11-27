import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/image_origin.dart';

abstract interface class ImagePickerRepository {
  Future<Result<String?, Failure>> pick(ImageOrigin origin);
}
