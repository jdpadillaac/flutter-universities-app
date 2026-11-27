import 'package:universities_app/features/universities/domain/entities/university_extras.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';

abstract interface class UniversityExtrasRepository {
  Map<String, UniversityExtras> get all;

  UniversityExtras extrasFor(String universityId);

  void saveImagePath({required String universityId, required String imagePath});

  void saveStudentCount({
    required String universityId,
    required StudentCount studentCount,
  });

  Stream<Map<String, UniversityExtras>> watch();
}
