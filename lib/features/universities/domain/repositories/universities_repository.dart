import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';

/// Loads the full university catalog.
abstract interface class UniversitiesRepository {
  /// Returns every university, or a [Failure] when the load fails.
  Future<Result<List<University>, Failure>> getUniversities();
}
