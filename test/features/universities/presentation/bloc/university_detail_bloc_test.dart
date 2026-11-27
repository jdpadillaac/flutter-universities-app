import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/image_origin.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/entities/university_extras.dart';
import 'package:universities_app/features/universities/domain/usecases/get_university_by_id.dart';
import 'package:universities_app/features/universities/domain/usecases/get_university_extras.dart';
import 'package:universities_app/features/universities/domain/usecases/pick_university_image.dart';
import 'package:universities_app/features/universities/domain/usecases/save_university_image.dart';
import 'package:universities_app/features/universities/domain/usecases/save_university_student_count.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_event.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_state.dart';

class MockGetUniversityById extends Mock implements GetUniversityById {}

class MockGetUniversityExtras extends Mock implements GetUniversityExtras {}

class MockSaveUniversityImage extends Mock implements SaveUniversityImage {}

class MockSaveUniversityStudentCount extends Mock
    implements SaveUniversityStudentCount {}

class MockPickUniversityImage extends Mock implements PickUniversityImage {}

void main() {
  const university = University(
    id: 'u-id',
    name: 'Sample',
    country: 'Country',
    countryCode: 'CO',
    domains: ['sample.edu'],
    webPages: ['https://sample.edu'],
  );

  late MockGetUniversityById getUniversityById;
  late MockGetUniversityExtras getUniversityExtras;
  late MockSaveUniversityImage saveUniversityImage;
  late MockSaveUniversityStudentCount saveUniversityStudentCount;
  late MockPickUniversityImage pickUniversityImage;

  setUpAll(() {
    registerFallbackValue(ImageOrigin.gallery);
    registerFallbackValue(StudentCount.parse('1').unwrap());
  });

  setUp(() {
    getUniversityById = MockGetUniversityById();
    getUniversityExtras = MockGetUniversityExtras();
    saveUniversityImage = MockSaveUniversityImage();
    saveUniversityStudentCount = MockSaveUniversityStudentCount();
    pickUniversityImage = MockPickUniversityImage();
  });

  UniversityDetailBloc buildBloc() => UniversityDetailBloc(
    getUniversityById,
    getUniversityExtras,
    saveUniversityImage,
    saveUniversityStudentCount,
    pickUniversityImage,
  );

  blocTest<UniversityDetailBloc, UniversityDetailState>(
    'loads university and extras',
    build: buildBloc,
    act: (bloc) => bloc.add(const UniversityDetailRequested('u-id')),
    setUp: () {
      when(
        () => getUniversityById('u-id'),
      ).thenAnswer((_) async => const Ok<University, Failure>(university));
      when(
        () => getUniversityExtras('u-id'),
      ).thenReturn(const UniversityExtras(imagePath: '/img.jpg'));
    },
    expect: () => [
      const UniversityDetailState(),
      isA<UniversityDetailState>()
          .having(
            (state) => state.status,
            'status',
            UniversityDetailStatus.ready,
          )
          .having((state) => state.university?.name, 'name', 'Sample')
          .having((state) => state.imagePath, 'imagePath', '/img.jpg'),
    ],
  );

  blocTest<UniversityDetailBloc, UniversityDetailState>(
    'emits notFound when the route id is missing',
    build: buildBloc,
    act: (bloc) => bloc.add(const UniversityDetailRequested(null)),
    verify: (_) {
      verifyNever(() => getUniversityById(any()));
    },
    expect: () => [
      const UniversityDetailState(),
      const UniversityDetailState(status: UniversityDetailStatus.notFound),
    ],
  );

  blocTest<UniversityDetailBloc, UniversityDetailState>(
    'emits notFound when the university is missing',
    build: buildBloc,
    act: (bloc) => bloc.add(const UniversityDetailRequested('missing')),
    setUp: () {
      when(() => getUniversityById('missing')).thenAnswer(
        (_) async => const Err<University, Failure>(NotFoundFailure()),
      );
    },
    expect: () => [
      const UniversityDetailState(),
      const UniversityDetailState(status: UniversityDetailStatus.notFound),
    ],
  );

  blocTest<UniversityDetailBloc, UniversityDetailState>(
    'shows validation error only after students changed',
    build: buildBloc,
    seed: () => const UniversityDetailState(
      status: UniversityDetailStatus.ready,
      university: university,
    ),
    act: (bloc) => bloc.add(const UniversityStudentsChanged('0')),
    expect: () => [
      isA<UniversityDetailState>()
          .having((state) => state.studentsTouched, 'touched', true)
          .having(
            (state) => state.validationError,
            'error',
            StudentCountError.mustBePositive,
          ),
    ],
  );

  blocTest<UniversityDetailBloc, UniversityDetailState>(
    'saves student count when form is valid',
    build: buildBloc,
    act: (bloc) async {
      when(
        () => getUniversityById('u-id'),
      ).thenAnswer((_) async => const Ok<University, Failure>(university));
      when(
        () => getUniversityExtras('u-id'),
      ).thenReturn(const UniversityExtras());
      bloc
        ..add(const UniversityDetailRequested('u-id'))
        ..add(const UniversityStudentsChanged('120'))
        ..add(const UniversityStudentsSaveRequested());
    },
    verify: (_) {
      verify(
        () => saveUniversityStudentCount(
          universityId: 'u-id',
          studentCount: any(named: 'studentCount'),
        ),
      ).called(1);
    },
    expect: () => [
      const UniversityDetailState(),
      isA<UniversityDetailState>(),
      isA<UniversityDetailState>(),
      isA<UniversityDetailState>().having(
        (state) => state.notice,
        'notice',
        UniversityDetailNotice.saved,
      ),
    ],
  );

  blocTest<UniversityDetailBloc, UniversityDetailState>(
    'ignores duplicate save events when the form is invalid',
    build: buildBloc,
    seed: () => const UniversityDetailState(
      status: UniversityDetailStatus.ready,
      university: university,
      studentsInput: '0',
    ),
    act: (bloc) => bloc.add(const UniversityStudentsSaveRequested()),
    verify: (_) {
      verifyNever(
        () => saveUniversityStudentCount(
          universityId: any(named: 'universityId'),
          studentCount: any(named: 'studentCount'),
        ),
      );
    },
    expect: () => const <UniversityDetailState>[],
  );

  blocTest<UniversityDetailBloc, UniversityDetailState>(
    'persists image immediately after a successful pick',
    build: buildBloc,
    act: (bloc) async {
      when(
        () => getUniversityById('u-id'),
      ).thenAnswer((_) async => const Ok<University, Failure>(university));
      when(
        () => getUniversityExtras('u-id'),
      ).thenReturn(const UniversityExtras());
      when(
        () => pickUniversityImage(ImageOrigin.camera),
      ).thenAnswer((_) async => const Ok<String?, Failure>('/tmp/photo.jpg'));
      bloc
        ..add(const UniversityDetailRequested('u-id'))
        ..add(const UniversityImagePickRequested(ImageOrigin.camera));
    },
    verify: (_) {
      verify(
        () => saveUniversityImage(
          universityId: 'u-id',
          imagePath: '/tmp/photo.jpg',
        ),
      ).called(1);
    },
    expect: () => [
      const UniversityDetailState(),
      isA<UniversityDetailState>(),
      isA<UniversityDetailState>().having(
        (state) => state.imagePath,
        'imagePath',
        '/tmp/photo.jpg',
      ),
    ],
  );

  blocTest<UniversityDetailBloc, UniversityDetailState>(
    'ignores cancelled image picks',
    build: buildBloc,
    act: (bloc) async {
      when(
        () => getUniversityById('u-id'),
      ).thenAnswer((_) async => const Ok<University, Failure>(university));
      when(
        () => getUniversityExtras('u-id'),
      ).thenReturn(const UniversityExtras());
      when(
        () => pickUniversityImage(ImageOrigin.gallery),
      ).thenAnswer((_) async => const Ok<String?, Failure>(null));
      bloc
        ..add(const UniversityDetailRequested('u-id'))
        ..add(const UniversityImagePickRequested(ImageOrigin.gallery));
    },
    expect: () => [const UniversityDetailState(), isA<UniversityDetailState>()],
  );

  blocTest<UniversityDetailBloc, UniversityDetailState>(
    'clears notice after it is shown',
    build: buildBloc,
    seed: () => const UniversityDetailState(
      status: UniversityDetailStatus.ready,
      university: university,
      notice: UniversityDetailNotice.saved,
    ),
    act: (bloc) => bloc.add(const UniversityDetailNoticeShown()),
    expect: () => [
      const UniversityDetailState(
        status: UniversityDetailStatus.ready,
        university: university,
      ),
    ],
  );

  blocTest<UniversityDetailBloc, UniversityDetailState>(
    'emits image failure notice when the picker fails',
    build: buildBloc,
    act: (bloc) async {
      when(
        () => getUniversityById('u-id'),
      ).thenAnswer((_) async => const Ok<University, Failure>(university));
      when(
        () => getUniversityExtras('u-id'),
      ).thenReturn(const UniversityExtras());
      when(() => pickUniversityImage(ImageOrigin.camera)).thenAnswer(
        (_) async => const Err<String?, Failure>(UnexpectedFailure()),
      );
      bloc
        ..add(const UniversityDetailRequested('u-id'))
        ..add(const UniversityImagePickRequested(ImageOrigin.camera));
    },
    expect: () => [
      const UniversityDetailState(),
      isA<UniversityDetailState>(),
      isA<UniversityDetailState>().having(
        (state) => state.notice,
        'notice',
        UniversityDetailNotice.imageFailed,
      ),
    ],
  );

  blocTest<UniversityDetailBloc, UniversityDetailState>(
    'emits permission denied when image pick fails with permissions',
    build: buildBloc,
    act: (bloc) async {
      when(
        () => getUniversityById('u-id'),
      ).thenAnswer((_) async => const Ok<University, Failure>(university));
      when(
        () => getUniversityExtras('u-id'),
      ).thenReturn(const UniversityExtras());
      when(() => pickUniversityImage(ImageOrigin.gallery)).thenAnswer(
        (_) async => const Err<String?, Failure>(PermissionDeniedFailure()),
      );
      bloc
        ..add(const UniversityDetailRequested('u-id'))
        ..add(const UniversityImagePickRequested(ImageOrigin.gallery));
    },
    expect: () => [
      const UniversityDetailState(),
      isA<UniversityDetailState>(),
      isA<UniversityDetailState>().having(
        (state) => state.notice,
        'notice',
        UniversityDetailNotice.permissionDenied,
      ),
    ],
  );
}
