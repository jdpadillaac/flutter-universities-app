import 'package:injectable/injectable.dart';
import 'package:universities_app/features/universities/domain/repositories/university_extras_repository.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';

@injectable
class SaveUniversityStudentCount {
  const SaveUniversityStudentCount(this._repository);

  final UniversityExtrasRepository _repository;

  void call({
    required String universityId,
    required StudentCount studentCount,
  }) {
    _repository.saveStudentCount(
      universityId: universityId,
      studentCount: studentCount,
    );
  }
}
