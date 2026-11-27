import 'package:injectable/injectable.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/image_origin.dart';
import 'package:universities_app/features/universities/domain/repositories/image_picker_repository.dart';

@injectable
class PickUniversityImage {
  const PickUniversityImage(this._repository);

  final ImagePickerRepository _repository;

  Future<Result<String?, Failure>> call(ImageOrigin origin) {
    return _repository.pick(origin);
  }
}
