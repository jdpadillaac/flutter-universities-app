import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/repositories/universities_repository.dart';
import 'package:universities_app/features/universities/domain/usecases/get_university_by_id.dart';

class MockUniversitiesRepository extends Mock
    implements UniversitiesRepository {}

void main() {
  late MockUniversitiesRepository repository;
  late GetUniversityById useCase;

  const university = University(
    id: 'sample--sample-edu',
    name: 'Sample',
    country: 'Country',
    countryCode: 'CO',
    domains: ['sample.edu'],
    webPages: ['https://sample.edu'],
  );

  setUp(() {
    repository = MockUniversitiesRepository();
    useCase = GetUniversityById(repository);
  });

  test('returns the matching university', () async {
    when(() => repository.getUniversities()).thenAnswer(
      (_) async => const Ok<List<University>, Failure>([university]),
    );

    final result = await useCase('sample--sample-edu');

    expect(result, const Ok<University, Failure>(university));
  });

  test('returns NotFoundFailure when the id is missing', () async {
    when(() => repository.getUniversities()).thenAnswer(
      (_) async => const Ok<List<University>, Failure>([university]),
    );

    final result = await useCase('missing');

    expect(result, const Err<University, Failure>(NotFoundFailure()));
  });
}
