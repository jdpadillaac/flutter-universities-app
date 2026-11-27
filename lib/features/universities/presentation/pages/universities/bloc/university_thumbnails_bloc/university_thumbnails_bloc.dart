import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:universities_app/features/universities/domain/usecases/get_all_university_extras.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/university_thumbnails_bloc/university_thumbnails_event.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/university_thumbnails_bloc/university_thumbnails_state.dart';

@injectable
class UniversityThumbnailsBloc
    extends Bloc<UniversityThumbnailsEvent, UniversityThumbnailsState> {
  UniversityThumbnailsBloc(this._getAllUniversityExtras)
    : super(UniversityThumbnailsInitial()) {
    on<UniversityThumbnailsRequested>(_onThumbnailsRequested);
  }

  final GetAllUniversityExtras _getAllUniversityExtras;

  void _onThumbnailsRequested(
    UniversityThumbnailsRequested event,
    Emitter<UniversityThumbnailsState> emit,
  ) {
    final extras = _getAllUniversityExtras();
    final imagePaths = <String, String>{};
    for (final entry in extras.entries) {
      final path = entry.value.imagePath;
      if (path != null) {
        imagePaths[entry.key] = path;
      }
    }
    emit(UniversityThumbnailsLoaded(imagePaths: imagePaths));
  }
}
