import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:universities_app/features/universities/domain/entities/university_extras.dart';
import 'package:universities_app/features/universities/domain/usecases/watch_university_extras.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_thumbnails_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_thumbnails_event.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_thumbnails_state.dart';

class MockWatchUniversityExtras extends Mock implements WatchUniversityExtras {}

void main() {
  late MockWatchUniversityExtras watchUniversityExtras;

  setUp(() {
    watchUniversityExtras = MockWatchUniversityExtras();
  });

  blocTest<UniversityThumbnailsBloc, UniversityThumbnailsState>(
    'emits image paths from extras updates',
    build: () {
      when(watchUniversityExtras.call).thenAnswer(
        (_) => Stream.fromIterable([
          const {
            'a': UniversityExtras(imagePath: '/a.jpg'),
            'b': UniversityExtras(),
          },
        ]),
      );
      return UniversityThumbnailsBloc(watchUniversityExtras);
    },
    act: (bloc) => bloc.add(const UniversityThumbnailsSubscriptionRequested()),
    expect: () => [
      const UniversityThumbnailsLoaded(imagePaths: {'a': '/a.jpg'}),
    ],
  );
}
