import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:universities_app/core/error/exceptions.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/data/datasources/universities_remote_data_source.dart';
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
    when(remote.getUniversities).thenAnswer((_) async => universities);

    final first = await repository.getUniversities();
    final second = await repository.getUniversities();

    expect(first.unwrap(), universities);
    expect(second.unwrap(), universities);
    verify(remote.getUniversities).called(1);
  });

  test('maps NetworkException and does not cache the error', () async {
    when(
      remote.getUniversities,
    ).thenThrow(const NetworkException(message: 'down', statusCode: 503));

    final failed = await repository.getUniversities();

    expect(
      failed.unwrapErr(),
      const NetworkFailure(message: 'down', statusCode: 503),
    );

    when(remote.getUniversities).thenAnswer((_) async => universities);
    final recovered = await repository.getUniversities();

    expect(recovered.unwrap(), universities);
    verify(remote.getUniversities).called(2);
  });

  test('maps ParsingException to ParsingFailure', () async {
    when(
      remote.getUniversities,
    ).thenThrow(const ParsingException(message: 'bad json'));

    final result = await repository.getUniversities();

    expect(result.unwrapErr(), const ParsingFailure(message: 'bad json'));
  });

  test('maps unexpected errors to UnexpectedFailure', () async {
    when(remote.getUniversities).thenThrow(StateError('nope'));

    final result = await repository.getUniversities();

    expect(
      result.unwrapErr(),
      const UnexpectedFailure(message: 'Bad state: nope'),
    );
  });
}
