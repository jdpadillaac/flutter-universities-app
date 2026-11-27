import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:universities_app/features/universities/domain/entities/university_extras.dart';
import 'package:universities_app/features/universities/domain/usecases/get_all_university_extras.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/university_thumbnails_bloc/university_thumbnails_bloc.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/university_thumbnails_bloc/university_thumbnails_event.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/university_thumbnails_bloc/university_thumbnails_state.dart';

class MockGetAllUniversityExtras extends Mock
    implements GetAllUniversityExtras {}

void main() {
  late MockGetAllUniversityExtras getAllUniversityExtras;

  setUp(() {
    getAllUniversityExtras = MockGetAllUniversityExtras();
  });

  blocTest<UniversityThumbnailsBloc, UniversityThumbnailsState>(
    'emits image paths from stored extras',
    build: () {
      when(getAllUniversityExtras.call).thenReturn(const {
        'a': UniversityExtras(imagePath: '/a.jpg'),
        'b': UniversityExtras(),
      });
      return UniversityThumbnailsBloc(getAllUniversityExtras);
    },
    act: (bloc) => bloc.add(const UniversityThumbnailsRequested()),
    expect: () => [
      const UniversityThumbnailsLoaded(imagePaths: {'a': '/a.jpg'}),
    ],
  );

  blocTest<UniversityThumbnailsBloc, UniversityThumbnailsState>(
    're-reads extras on subsequent request',
    build: () => UniversityThumbnailsBloc(getAllUniversityExtras),
    act: (bloc) async {
      when(getAllUniversityExtras.call).thenReturn(const {});
      bloc.add(const UniversityThumbnailsRequested());
      await Future<void>.delayed(Duration.zero);
      when(
        getAllUniversityExtras.call,
      ).thenReturn(const {'a': UniversityExtras(imagePath: '/new.jpg')});
      bloc.add(const UniversityThumbnailsRequested());
    },
    expect: () => [
      const UniversityThumbnailsLoaded(imagePaths: {}),
      const UniversityThumbnailsLoaded(imagePaths: {'a': '/new.jpg'}),
    ],
  );
}
