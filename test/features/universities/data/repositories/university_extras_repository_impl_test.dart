import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/data/repositories/university_extras_repository_impl.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';

void main() {
  test('stores image and student count in memory and emits on watch', () async {
    final repository = UniversityExtrasRepositoryImpl();
    addTearDown(() async {
      await repository.close();
    });

    final values = <Map<String, dynamic>>[];
    final subscription = repository.watch().listen(values.add);

    repository
      ..saveImagePath(universityId: 'id-1', imagePath: '/tmp/a.jpg')
      ..saveStudentCount(
        universityId: 'id-1',
        studentCount: StudentCount.parse('42').unwrap(),
      );

    await Future<void>.delayed(Duration.zero);

    expect(repository.extrasFor('id-1').imagePath, '/tmp/a.jpg');
    expect(repository.extrasFor('id-1').studentCount?.value, 42);
    expect(values.length, greaterThanOrEqualTo(2));

    await subscription.cancel();
  });
}
