import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:universities_app/core/error/exceptions.dart';
import 'package:universities_app/core/network/api_config.dart';
import 'package:universities_app/features/universities/data/models/university_model.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';

/// Fetches universities from the remote JSON catalog.
abstract interface class UniversitiesRemoteDataSource {
  /// Downloads and parses every university.
  Future<List<University>> getUniversities();
}

/// Dio implementation of [UniversitiesRemoteDataSource].
@Injectable(as: UniversitiesRemoteDataSource)
class UniversitiesRemoteDataSourceImpl implements UniversitiesRemoteDataSource {
  /// Creates a data source that reads [Dio].
  UniversitiesRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<University>> getUniversities() async {
    final String body;
    try {
      final response = await _dio.get<String>(
        ApiConfig.universitiesPath,
        options: Options(responseType: ResponseType.plain),
      );
      final data = response.data;
      if (data == null) {
        throw const ParsingException();
      }
      body = data;
    } on DioException catch (error) {
      throw NetworkException(
        message: error.message ?? 'A network error occurred.',
        statusCode: error.response?.statusCode,
      );
    }

    try {
      return await compute(parseUniversities, body);
    } on Object catch (error) {
      throw ParsingException(message: error.toString());
    }
  }
}

/// Decodes [body] into universities.
///
/// Top-level so [compute] can run it on a background isolate. On web, compute
/// falls back to the current isolate.
List<University> parseUniversities(String body) {
  final decoded = jsonDecode(body);
  if (decoded is! List<dynamic>) {
    throw const FormatException('Expected a JSON list.');
  }

  return decoded
      .map(
        (item) =>
            UniversityModel.fromJson(item as Map<String, dynamic>).toEntity(),
      )
      .toList(growable: false);
}
