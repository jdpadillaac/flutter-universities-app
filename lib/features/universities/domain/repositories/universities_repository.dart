import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';

abstract interface class UniversitiesRepository {
  Future<Result<List<University>, Failure>> getUniversities();
}
