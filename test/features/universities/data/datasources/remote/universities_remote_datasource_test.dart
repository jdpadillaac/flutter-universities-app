import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/core/network/api_client.dart';
import 'package:universities_app/core/network/api_config.dart';
import 'package:universities_app/features/universities/data/datasources/remote/universities_json_parser.dart';
import 'package:universities_app/features/universities/data/datasources/remote/universities_remote_datasource.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockUniversitiesJsonParser extends Mock
    implements UniversitiesJsonParser {}

void main() {
  late MockApiClient apiClient;
  late MockUniversitiesJsonParser parser;
  late UniversitiesRemoteDataSourceImpl dataSource;

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
    apiClient = MockApiClient();
    parser = MockUniversitiesJsonParser();
    dataSource = UniversitiesRemoteDataSourceImpl(apiClient, parser);
  });

  test('parses the body returned by the client', () async {
    when(
      () => apiClient.get(ApiConfig.universitiesPath),
    ).thenAnswer((_) async => const Ok('[]'));
    when(
      () => parser.parse('[]'),
    ).thenAnswer((_) async => const Ok(universities));

    final result = await dataSource.getUniversities();

    expect(result.unwrap(), universities);
    verify(() => apiClient.get(ApiConfig.universitiesPath)).called(1);
    verify(() => parser.parse('[]')).called(1);
  });

  test('returns the client failure without parsing', () async {
    const failure = NetworkFailure(message: 'down', statusCode: 503);
    when(
      () => apiClient.get(ApiConfig.universitiesPath),
    ).thenAnswer((_) async => const Err(failure));

    final result = await dataSource.getUniversities();

    expect(result.unwrapErr(), failure);
    verifyNever(() => parser.parse(any()));
  });

  test('returns the parser failure', () async {
    const failure = ParsingFailure(message: 'bad json');
    when(
      () => apiClient.get(ApiConfig.universitiesPath),
    ).thenAnswer((_) async => const Ok('{'));
    when(() => parser.parse('{')).thenAnswer((_) async => const Err(failure));

    final result = await dataSource.getUniversities();

    expect(result.unwrapErr(), failure);
  });
}
