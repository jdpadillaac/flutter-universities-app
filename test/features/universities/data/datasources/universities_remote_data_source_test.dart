import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:universities_app/core/error/exceptions.dart';
import 'package:universities_app/core/network/api_config.dart';
import 'package:universities_app/features/universities/data/datasources/universities_remote_data_source.dart';

import '../../../../helpers/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio dio;
  late UniversitiesRemoteDataSourceImpl dataSource;

  setUpAll(() {
    registerFallbackValue(Options());
  });

  setUp(() {
    dio = MockDio();
    dataSource = UniversitiesRemoteDataSourceImpl(dio);
  });

  test('parses a plain-text body into universities', () async {
    final body = fixture('universities.json');
    when(
      () => dio.get<String>(
        ApiConfig.universitiesPath,
        options: any(named: 'options'),
      ),
    ).thenAnswer(
      (_) async =>
          Response<String>(requestOptions: RequestOptions(), data: body),
    );

    final universities = await dataSource.getUniversities();

    expect(universities, parseUniversities(body));
    final options =
        verify(
              () => dio.get<String>(
                ApiConfig.universitiesPath,
                options: captureAny(named: 'options'),
              ),
            ).captured.single
            as Options;
    expect(options.responseType, ResponseType.plain);
  });

  test('throws NetworkException when Dio fails with a status code', () {
    when(
      () => dio.get<String>(
        ApiConfig.universitiesPath,
        options: any(named: 'options'),
      ),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(),
        message: 'unavailable',
        response: Response<dynamic>(
          requestOptions: RequestOptions(),
          statusCode: 503,
        ),
      ),
    );

    expect(
      dataSource.getUniversities(),
      throwsA(
        isA<NetworkException>()
            .having((error) => error.statusCode, 'statusCode', 503)
            .having((error) => error.message, 'message', 'unavailable'),
      ),
    );
  });

  test('throws NetworkException without a status code', () {
    when(
      () => dio.get<String>(
        ApiConfig.universitiesPath,
        options: any(named: 'options'),
      ),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.connectionError,
      ),
    );

    expect(
      dataSource.getUniversities(),
      throwsA(
        isA<NetworkException>()
            .having((error) => error.statusCode, 'statusCode', isNull)
            .having(
              (error) => error.message,
              'message',
              'A network error occurred.',
            ),
      ),
    );
  });

  test('throws ParsingException when the JSON is invalid', () {
    _stubBody(dio, '{');

    expect(
      dataSource.getUniversities(),
      throwsA(
        isA<ParsingException>().having(
          (error) => error.message,
          'message',
          contains('FormatException'),
        ),
      ),
    );
  });

  test('throws ParsingException when the body is null', () {
    when(
      () => dio.get<String>(
        ApiConfig.universitiesPath,
        options: any(named: 'options'),
      ),
    ).thenAnswer(
      (_) async => Response<String>(requestOptions: RequestOptions()),
    );

    expect(dataSource.getUniversities(), throwsA(isA<ParsingException>()));
  });

  test('parseUniversities maps the fixture and rejects a non-list', () {
    final universities = parseUniversities(fixture('universities.json'));

    expect(universities, hasLength(3));
    expect(universities.first.name, 'Arts & Science College');
    expect(() => parseUniversities('{}'), throwsFormatException);
  });
}

void _stubBody(MockDio dio, String body) {
  when(
    () => dio.get<String>(
      ApiConfig.universitiesPath,
      options: any(named: 'options'),
    ),
  ).thenAnswer(
    (_) async => Response<String>(requestOptions: RequestOptions(), data: body),
  );
}
