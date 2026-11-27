import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';

@lazySingleton
class ApiClient {
  const ApiClient(this._dio);

  final Dio _dio;

  Future<Result<String, Failure>> get(String path) async {
    try {
      final response = await _dio.get<String>(
        path,
        options: Options(responseType: ResponseType.plain),
      );
      final data = response.data;
      if (data == null) {
        return const Err(ParsingFailure());
      }
      return Ok(data);
    } on DioException catch (error) {
      return Err(
        NetworkFailure(
          message: error.message ?? 'A network error occurred.',
          statusCode: error.response?.statusCode,
        ),
      );
    }
  }
}
