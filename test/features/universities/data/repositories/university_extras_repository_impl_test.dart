import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/data/repositories/university_extras_repository_impl.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';

void main() {
  test('stores image and student count in memory', () {
    final repository = UniversityExtrasRepositoryImpl();

    repository
      ..saveImagePath(universityId: 'id-1', imagePath: '/tmp/a.jpg')
      ..saveStudentCount(
        universityId: 'id-1',
        studentCount: StudentCount.parse('42').unwrap(),
      );

    expect(repository.extrasFor('id-1').imagePath, '/tmp/a.jpg');
    expect(repository.extrasFor('id-1').studentCount?.value, 42);
    expect(repository.all['id-1']?.imagePath, '/tmp/a.jpg');
    expect(repository.all['id-1']?.studentCount?.value, 42);
  });
}
