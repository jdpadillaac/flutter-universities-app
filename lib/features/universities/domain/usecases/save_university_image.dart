import 'package:injectable/injectable.dart';
import 'package:universities_app/features/universities/domain/repositories/university_extras_repository.dart';

@injectable
class SaveUniversityImage {
  const SaveUniversityImage(this._repository);

  final UniversityExtrasRepository _repository;

  void call({required String universityId, required String imagePath}) {
    _repository.saveImagePath(universityId: universityId, imagePath: imagePath);
  }
}
