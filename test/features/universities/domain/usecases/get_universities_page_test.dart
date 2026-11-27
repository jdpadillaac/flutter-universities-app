import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/universities_page.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/repositories/universities_repository.dart';
import 'package:universities_app/features/universities/domain/services/university_id_generator.dart';
import 'package:universities_app/features/universities/domain/usecases/get_universities_page.dart';

class MockUniversitiesRepository extends Mock
    implements UniversitiesRepository {}

class UniversityCatalog {
  const UniversityCatalog(this._ids);

  final UniversityIdGenerator _ids;

  List<University> take(int count) {
    return List.generate(count, (index) {
      final domain = 'u$index.edu';
      final name = 'University $index';
      return University(
        id: _ids.buildId(name, domain),
        name: name,
        country: 'Country',
        countryCode: 'CO',
        domains: [domain],
        webPages: ['https://$domain'],
      );
    });
  }
}

void main() {
  late MockUniversitiesRepository repository;
  late GetUniversitiesPage useCase;
  const catalog = UniversityCatalog(UniversityIdGenerator());

  setUp(() {
    repository = MockUniversitiesRepository();
    useCase = GetUniversitiesPage(repository);
  });

  test('returns the first page and keeps the default page size', () async {
    final universities = catalog.take(3);
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
    final universities = catalog.take(5);
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
    final universities = catalog.take(5);
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
    final universities = catalog.take(5);
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

  test('returns UnexpectedFailure when page is below 1', () async {
    final result = await useCase(page: 0);

    expect(
      result.unwrapErr(),
      const UnexpectedFailure(message: 'page must be >= 1'),
    );
    verifyNever(repository.getUniversities);
  });

  test('returns UnexpectedFailure when pageSize is below 1', () async {
    final result = await useCase(page: 1, pageSize: 0);

    expect(
      result.unwrapErr(),
      const UnexpectedFailure(message: 'pageSize must be > 0'),
    );
    verifyNever(repository.getUniversities);
  });
}
