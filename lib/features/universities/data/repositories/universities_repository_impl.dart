import 'package:injectable/injectable.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/exceptions.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/data/datasources/universities_remote_data_source.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/repositories/universities_repository.dart';

/// In-memory cached implementation of [UniversitiesRepository].
@LazySingleton(as: UniversitiesRepository)
class UniversitiesRepositoryImpl implements UniversitiesRepository {
  /// Creates a repository backed by the remote data source.
  UniversitiesRepositoryImpl(this._remoteDataSource);

  final UniversitiesRemoteDataSource _remoteDataSource;
  List<University>? _cache;

  @override
  Future<Result<List<University>, Failure>> getUniversities() async {
    final cached = _cache;
    if (cached != null) {
      return Ok(cached);
    }

    try {
      final universities = await _remoteDataSource.getUniversities();
      _cache = universities;
      return Ok(universities);
    } on NetworkException catch (error) {
      return Err(
        NetworkFailure(message: error.message, statusCode: error.statusCode),
      );
    } on ParsingException catch (error) {
      return Err(ParsingFailure(message: error.message));
    } on Object catch (error) {
      return Err(UnexpectedFailure(message: error.toString()));
    }
  }
}
