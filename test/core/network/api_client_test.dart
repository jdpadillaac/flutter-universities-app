import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/core/network/api_client.dart';

class MockDio extends Mock implements Dio {}

class DioGetStub {
  const DioGetStub(this._dio);

  final MockDio _dio;

  void body(String path, String? data) {
    when(
      () => _dio.get<String>(path, options: any(named: 'options')),
    ).thenAnswer(
      (_) async =>
          Response<String>(requestOptions: RequestOptions(), data: data),
    );
  }

  void dioException(String path, {String? message, int? statusCode}) {
    when(
      () => _dio.get<String>(path, options: any(named: 'options')),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(),
        message: message,
        type: statusCode == null
            ? DioExceptionType.connectionError
            : DioExceptionType.badResponse,
        response: statusCode == null
            ? null
            : Response<dynamic>(
                requestOptions: RequestOptions(),
                statusCode: statusCode,
              ),
      ),
    );
  }
}

void main() {
  late MockDio dio;
  late DioGetStub stub;
  late ApiClient client;

  setUpAll(() {
    registerFallbackValue(Options());
  });

  setUp(() {
    dio = MockDio();
    stub = DioGetStub(dio);
    client = ApiClient(dio);
  });

  test('returns the plain response body', () async {
    stub.body('/universities.json', '[]');

    final result = await client.get('/universities.json');

    expect(result, const Ok<String, Failure>('[]'));
    final options =
        verify(
              () => dio.get<String>(
                '/universities.json',
                options: captureAny(named: 'options'),
              ),
            ).captured.single
            as Options;
    expect(options.responseType, ResponseType.plain);
  });

  test('returns ParsingFailure when the body is null', () async {
    stub.body('/universities.json', null);

    final result = await client.get('/universities.json');

    expect(result, const Err<String, Failure>(ParsingFailure()));
  });

  test('maps DioException status and message', () async {
    stub.dioException(
      '/universities.json',
      message: 'unavailable',
      statusCode: 503,
    );

    final result = await client.get('/universities.json');

    expect(
      result,
      const Err<String, Failure>(
        NetworkFailure(message: 'unavailable', statusCode: 503),
      ),
    );
  });

  test('uses the default network message when Dio has none', () async {
    stub.dioException('/universities.json');

    final result = await client.get('/universities.json');

    expect(result, const Err<String, Failure>(NetworkFailure()));
  });

  test('lets non-Dio errors escape', () {
    when(
      () =>
          dio.get<String>('/universities.json', options: any(named: 'options')),
    ).thenThrow(StateError('nope'));

    expect(client.get('/universities.json'), throwsA(isA<StateError>()));
  });
}
