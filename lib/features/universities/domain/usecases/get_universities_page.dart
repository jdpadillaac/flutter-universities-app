import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/universities_page.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/repositories/universities_repository.dart';

@injectable
class GetUniversitiesPage {
  const GetUniversitiesPage(this._repository);

  final UniversitiesRepository _repository;

  Future<Result<UniversitiesPage, Failure>> call({
    required int page,
    int pageSize = 20,
  }) async {
    if (page < 1) {
      return const Err(UnexpectedFailure(message: 'page must be >= 1'));
    }
    if (pageSize <= 0) {
      return const Err(UnexpectedFailure(message: 'pageSize must be > 0'));
    }

    final result = await _repository.getUniversities();
    return result.map((universities) => _slice(universities, page, pageSize));
  }

  UniversitiesPage _slice(
    List<University> universities,
    int page,
    int pageSize,
  ) {
    final total = universities.length;
    final start = (page - 1) * pageSize;
    if (start >= total) {
      return const UniversitiesPage(items: [], hasReachedMax: true);
    }

    final end = min(page * pageSize, total);
    return UniversitiesPage(
      items: universities.sublist(start, end),
      hasReachedMax: end >= total,
    );
  }
}
