import 'package:injectable/injectable.dart';
import 'package:universities_app/features/universities/domain/entities/university_extras.dart';
import 'package:universities_app/features/universities/domain/repositories/university_extras_repository.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';

@LazySingleton(as: UniversityExtrasRepository)
class UniversityExtrasRepositoryImpl implements UniversityExtrasRepository {
  UniversityExtrasRepositoryImpl() : _extras = {};

  final Map<String, UniversityExtras> _extras;

  @override
  Map<String, UniversityExtras> get all => Map.unmodifiable(_extras);

  @override
  UniversityExtras extrasFor(String universityId) {
    return _extras[universityId] ?? const UniversityExtras();
  }

  @override
  void saveImagePath({
    required String universityId,
    required String imagePath,
  }) {
    final current = _extras[universityId] ?? const UniversityExtras();
    _extras[universityId] = current.copyWith(imagePath: imagePath);
  }

  @override
  void saveStudentCount({
    required String universityId,
    required StudentCount studentCount,
  }) {
    final current = _extras[universityId] ?? const UniversityExtras();
    _extras[universityId] = current.copyWith(studentCount: studentCount);
  }
}
