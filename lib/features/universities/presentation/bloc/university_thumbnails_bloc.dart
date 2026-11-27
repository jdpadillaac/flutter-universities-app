import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:universities_app/features/universities/domain/entities/university_extras.dart';
import 'package:universities_app/features/universities/domain/usecases/watch_university_extras.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_thumbnails_event.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_thumbnails_state.dart';

@injectable
class UniversityThumbnailsBloc
    extends Bloc<UniversityThumbnailsEvent, UniversityThumbnailsState> {
  UniversityThumbnailsBloc(this._watchUniversityExtras)
    : super(UniversityThumbnailsInitial()) {
    on<UniversityThumbnailsSubscriptionRequested>(_onSubscriptionRequested);
  }

  final WatchUniversityExtras _watchUniversityExtras;

  Future<void> _onSubscriptionRequested(
    UniversityThumbnailsSubscriptionRequested event,
    Emitter<UniversityThumbnailsState> emit,
  ) async {
    await emit.forEach<Map<String, UniversityExtras>>(
      _watchUniversityExtras(),
      onData: (extras) {
        final imagePaths = <String, String>{};
        for (final entry in extras.entries) {
          final path = entry.value.imagePath;
          if (path != null) {
            imagePaths[entry.key] = path;
          }
        }
        return UniversityThumbnailsLoaded(imagePaths: imagePaths);
      },
    );
  }
}
