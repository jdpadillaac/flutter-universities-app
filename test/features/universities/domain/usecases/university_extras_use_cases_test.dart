import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:universities_app/features/universities/domain/entities/university_extras.dart';
import 'package:universities_app/features/universities/domain/repositories/university_extras_repository.dart';
import 'package:universities_app/features/universities/domain/usecases/get_university_extras.dart';
import 'package:universities_app/features/universities/domain/usecases/save_university_image.dart';
import 'package:universities_app/features/universities/domain/usecases/save_university_student_count.dart';
import 'package:universities_app/features/universities/domain/usecases/watch_university_extras.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';

class MockUniversityExtrasRepository extends Mock
    implements UniversityExtrasRepository {}

void main() {
  late MockUniversityExtrasRepository repository;

  setUp(() {
    repository = MockUniversityExtrasRepository();
  });

  test('WatchUniversityExtras returns the repository stream', () {
    when(repository.watch).thenAnswer((_) => const Stream.empty());
    final useCase = WatchUniversityExtras(repository);

    expect(useCase(), isA<Stream<Map<String, UniversityExtras>>>());
    verify(repository.watch).called(1);
  });

  test('GetUniversityExtras delegates to the repository', () {
    when(
      () => repository.extrasFor('id'),
    ).thenReturn(const UniversityExtras(imagePath: '/tmp/a.jpg'));
    final useCase = GetUniversityExtras(repository);

    final result = useCase('id');

    expect(result.imagePath, '/tmp/a.jpg');
    verify(() => repository.extrasFor('id')).called(1);
  });

  test('SaveUniversityImage delegates to the repository', () {
    final useCase = SaveUniversityImage(repository);

    useCase(universityId: 'id', imagePath: '/tmp/a.jpg');

    verify(
      () =>
          repository.saveImagePath(universityId: 'id', imagePath: '/tmp/a.jpg'),
    ).called(1);
  });

  test('SaveUniversityStudentCount delegates to the repository', () {
    final count = StudentCount.parse('15').unwrap();
    final useCase = SaveUniversityStudentCount(repository);

    useCase(universityId: 'id', studentCount: count);

    verify(
      () =>
          repository.saveStudentCount(universityId: 'id', studentCount: count),
    ).called(1);
  });
}
