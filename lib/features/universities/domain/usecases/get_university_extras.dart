import 'package:injectable/injectable.dart';
import 'package:universities_app/features/universities/domain/entities/university_extras.dart';
import 'package:universities_app/features/universities/domain/repositories/university_extras_repository.dart';

@injectable
class GetUniversityExtras {
  const GetUniversityExtras(this._repository);

  final UniversityExtrasRepository _repository;

  UniversityExtras call(String universityId) =>
      _repository.extrasFor(universityId);
}
