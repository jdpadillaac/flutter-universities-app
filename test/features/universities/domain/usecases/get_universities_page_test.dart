import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/universities_page.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/repositories/universities_repository.dart';
import 'package:universities_app/features/universities/domain/usecases/get_universities_page.dart';

class MockUniversitiesRepository extends Mock
    implements UniversitiesRepository {}

void main() {
  late MockUniversitiesRepository repository;
  late GetUniversitiesPage useCase;

  setUp(() {
    repository = MockUniversitiesRepository();
    useCase = GetUniversitiesPage(repository);
  });

  test('returns the first page and keeps the default page size', () async {
    final universities = _universities(3);
    when(
      repository.getUniversities,
    ).thenAnswer((_) async => Ok<List<University>, Failure>(universities));

    final result = await useCase(page: 1);

    expect(
      result.unwrap(),
      UniversitiesPage(items: universities, hasReachedMax: true),
    );
  });

  test('returns a partial last page', () async {
    final universities = _universities(5);
    when(
      repository.getUniversities,
    ).thenAnswer((_) async => Ok<List<University>, Failure>(universities));

    final result = await useCase(page: 3, pageSize: 2);

    expect(
      result.unwrap(),
      UniversitiesPage(items: universities.sublist(4), hasReachedMax: true),
    );
  });

  test('returns the first slice when more pages remain', () async {
    final universities = _universities(5);
    when(
      repository.getUniversities,
    ).thenAnswer((_) async => Ok<List<University>, Failure>(universities));

    final result = await useCase(page: 1, pageSize: 2);

    expect(
      result.unwrap(),
      UniversitiesPage(items: universities.sublist(0, 2), hasReachedMax: false),
    );
  });

  test('returns an empty page past the end', () async {
    final universities = _universities(5);
    when(
      repository.getUniversities,
    ).thenAnswer((_) async => Ok<List<University>, Failure>(universities));

    final result = await useCase(page: 4, pageSize: 2);

    expect(
      result.unwrap(),
      const UniversitiesPage(items: [], hasReachedMax: true),
    );
  });

  test('propagates Err from the repository', () async {
    const failure = NetworkFailure(message: 'down', statusCode: 503);
    when(
      repository.getUniversities,
    ).thenAnswer((_) async => const Err<List<University>, Failure>(failure));

    final result = await useCase(page: 1);

    expect(result.unwrapErr(), failure);
  });
}

List<University> _universities(int count) {
  return List.generate(count, (index) {
    final domain = 'u$index.edu';
    final name = 'University $index';
    return University(
      id: University.buildId(name, domain),
      name: name,
      country: 'Country',
      countryCode: 'CO',
      domains: [domain],
      webPages: ['https://$domain'],
    );
  });
}
