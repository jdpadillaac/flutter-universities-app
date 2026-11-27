import 'package:injectable/injectable.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/data/datasources/remote/universities_remote_datasource.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/repositories/universities_repository.dart';

@LazySingleton(as: UniversitiesRepository)
class UniversitiesRepositoryImpl implements UniversitiesRepository {
  UniversitiesRepositoryImpl(this._remoteDataSource);

  final UniversitiesRemoteDataSource _remoteDataSource;
  List<University>? _cache;

  @override
  Future<Result<List<University>, Failure>> getUniversities() async {
    final cached = _cache;
    if (cached != null) {
      return Ok(cached);
    }

    final result = await _remoteDataSource.getUniversities();
    result.matchOk((universities) => _cache = universities);
    return result;
  }
}
