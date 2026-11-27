import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/data/datasources/remote/universities_remote_datasource.dart';
import 'package:universities_app/features/universities/data/repositories/universities_repository_impl.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';

class MockUniversitiesRemoteDataSource extends Mock
    implements UniversitiesRemoteDataSource {}

void main() {
  late MockUniversitiesRemoteDataSource remote;
  late UniversitiesRepositoryImpl repository;

  const universities = [
    University(
      id: 'alpha--alpha.edu',
      name: 'Alpha',
      country: 'Country',
      countryCode: 'CO',
      domains: ['alpha.edu'],
      webPages: ['https://alpha.edu'],
    ),
  ];

  setUp(() {
    remote = MockUniversitiesRemoteDataSource();
    repository = UniversitiesRepositoryImpl(remote);
  });

  test('returns Ok and calls the data source once', () async {
    when(
      remote.getUniversities,
    ).thenAnswer((_) async => const Ok(universities));

    final first = await repository.getUniversities();
    final second = await repository.getUniversities();

    expect(first.unwrap(), universities);
    expect(second.unwrap(), universities);
    verify(remote.getUniversities).called(1);
  });

  test('does not cache a network failure', () async {
    const failure = NetworkFailure(message: 'down', statusCode: 503);
    when(remote.getUniversities).thenAnswer((_) async => const Err(failure));

    final failed = await repository.getUniversities();

    expect(failed.unwrapErr(), failure);

    when(
      remote.getUniversities,
    ).thenAnswer((_) async => const Ok(universities));
    final recovered = await repository.getUniversities();

    expect(recovered.unwrap(), universities);
    verify(remote.getUniversities).called(2);
  });

  test('propagates ParsingFailure', () async {
    const failure = ParsingFailure(message: 'bad json');
    when(remote.getUniversities).thenAnswer((_) async => const Err(failure));

    final result = await repository.getUniversities();

    expect(result.unwrapErr(), failure);
  });

  test('propagates UnexpectedFailure', () async {
    const failure = UnexpectedFailure(message: 'Bad state: nope');
    when(remote.getUniversities).thenAnswer((_) async => const Err(failure));

    final result = await repository.getUniversities();

    expect(result.unwrapErr(), failure);
  });
}
