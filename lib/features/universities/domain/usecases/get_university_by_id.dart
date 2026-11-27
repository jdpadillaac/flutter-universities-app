import 'package:injectable/injectable.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/repositories/universities_repository.dart';

@injectable
class GetUniversityById {
  const GetUniversityById(this._repository);

  final UniversitiesRepository _repository;

  Future<Result<University, Failure>> call(String id) async {
    final result = await _repository.getUniversities();
    return result.andThen((universities) {
      for (final university in universities) {
        if (university.id == id) {
          return Ok(university);
        }
      }
      return const Err(NotFoundFailure());
    });
  }
}
