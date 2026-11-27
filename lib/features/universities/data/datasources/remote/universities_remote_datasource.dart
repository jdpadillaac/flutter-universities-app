import 'package:injectable/injectable.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/core/network/api_client.dart';
import 'package:universities_app/core/network/api_config.dart';
import 'package:universities_app/features/universities/data/datasources/remote/universities_json_parser.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';

abstract interface class UniversitiesRemoteDataSource {
  Future<Result<List<University>, Failure>> getUniversities();
}

@Injectable(as: UniversitiesRemoteDataSource)
class UniversitiesRemoteDataSourceImpl implements UniversitiesRemoteDataSource {
  UniversitiesRemoteDataSourceImpl(this._apiClient, this._parser);

  final ApiClient _apiClient;
  final UniversitiesJsonParser _parser;

  @override
  Future<Result<List<University>, Failure>> getUniversities() {
    return _apiClient
        .get(ApiConfig.universitiesPath)
        .then((body) => body.andThenAsync(_parser.parse));
  }
}
