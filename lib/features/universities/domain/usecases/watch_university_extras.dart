import 'package:injectable/injectable.dart';
import 'package:universities_app/features/universities/domain/entities/university_extras.dart';
import 'package:universities_app/features/universities/domain/repositories/university_extras_repository.dart';

@injectable
class WatchUniversityExtras {
  const WatchUniversityExtras(this._repository);

  final UniversityExtrasRepository _repository;

  Stream<Map<String, UniversityExtras>> call() => _repository.watch();
}
