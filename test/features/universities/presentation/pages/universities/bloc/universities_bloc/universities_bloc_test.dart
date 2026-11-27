import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/universities_slice_entity.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/services/university_id_generator.dart';
import 'package:universities_app/features/universities/domain/usecases/get_universities_page.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_bloc.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_event.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_state.dart';

class MockGetUniversitiesPage extends Mock implements GetUniversitiesPage {}

class UniversityCatalog {
  const UniversityCatalog(this._ids);

  final UniversityIdGenerator _ids;

  University at(int index) {
    final domain = 'u$index.edu';
    final name = 'University $index';
    return University(
      id: _ids.buildId(name, domain),
      name: name,
      country: 'Country',
      countryCode: 'CO',
      domains: [domain],
      webPages: ['https://$domain'],
    );
  }

  List<University> take(int count) {
    return List.generate(count, at);
  }
}

void main() {
  late MockGetUniversitiesPage getUniversitiesPage;
  const catalog = UniversityCatalog(UniversityIdGenerator());

  setUp(() {
    getUniversitiesPage = MockGetUniversitiesPage();
  });

  UniversitiesBloc buildBloc() => UniversitiesBloc(getUniversitiesPage);

  blocTest<UniversitiesBloc, UniversitiesState>(
    'loads the first page on request',
    build: buildBloc,
    setUp: () {
      when(() => getUniversitiesPage(page: 0)).thenAnswer(
        (_) async => Ok<UniversitiesSliceEntity, Failure>(
          UniversitiesSliceEntity(items: catalog.take(2), hasReachedMax: false),
        ),
      );
    },
    act: (bloc) => bloc.add(const UniversitiesRequested()),
    expect: () => [
      const UniversitiesLoading(),
      UniversitiesLoaded(items: catalog.take(2), hasReachedMax: false),
    ],
  );

  blocTest<UniversitiesBloc, UniversitiesState>(
    'emits failure when the first page fails',
    build: buildBloc,
    setUp: () {
      when(() => getUniversitiesPage(page: 0)).thenAnswer(
        (_) async => const Err<UniversitiesSliceEntity, Failure>(
          NetworkFailure(message: 'down', statusCode: 503),
        ),
      );
    },
    act: (bloc) => bloc.add(const UniversitiesRequested()),
    expect: () => [
      const UniversitiesLoading(),
      const UniversitiesFailure(
        failure: NetworkFailure(message: 'down', statusCode: 503),
        items: [],
        hasReachedMax: false,
      ),
    ],
  );

  blocTest<UniversitiesBloc, UniversitiesState>(
    'appends the next page',
    build: buildBloc,
    setUp: () {
      when(() => getUniversitiesPage(page: 0)).thenAnswer(
        (_) async => Ok<UniversitiesSliceEntity, Failure>(
          UniversitiesSliceEntity(items: catalog.take(1), hasReachedMax: false),
        ),
      );
      when(() => getUniversitiesPage(page: 1)).thenAnswer(
        (_) async => Ok<UniversitiesSliceEntity, Failure>(
          UniversitiesSliceEntity(items: [catalog.at(1)], hasReachedMax: true),
        ),
      );
    },
    act: (bloc) async {
      bloc.add(const UniversitiesRequested());
      await Future<void>.delayed(Duration.zero);
      bloc.add(const UniversitiesNextPageRequested());
    },
    expect: () => [
      const UniversitiesLoading(),
      UniversitiesLoaded(items: catalog.take(1), hasReachedMax: false),
      UniversitiesLoaded(
        items: catalog.take(1),
        hasReachedMax: false,
        isLoadingMore: true,
      ),
      UniversitiesLoaded(items: catalog.take(2), hasReachedMax: true),
    ],
  );

  blocTest<UniversitiesBloc, UniversitiesState>(
    'keeps items when an additional page fails',
    build: buildBloc,
    setUp: () {
      when(() => getUniversitiesPage(page: 0)).thenAnswer(
        (_) async => Ok<UniversitiesSliceEntity, Failure>(
          UniversitiesSliceEntity(items: catalog.take(1), hasReachedMax: false),
        ),
      );
      when(() => getUniversitiesPage(page: 1)).thenAnswer(
        (_) async => const Err<UniversitiesSliceEntity, Failure>(
          NetworkFailure(message: 'append failed'),
        ),
      );
    },
    act: (bloc) async {
      bloc.add(const UniversitiesRequested());
      await Future<void>.delayed(Duration.zero);
      bloc.add(const UniversitiesNextPageRequested());
    },
    expect: () => [
      const UniversitiesLoading(),
      UniversitiesLoaded(items: catalog.take(1), hasReachedMax: false),
      UniversitiesLoaded(
        items: catalog.take(1),
        hasReachedMax: false,
        isLoadingMore: true,
      ),
      UniversitiesFailure(
        failure: const NetworkFailure(message: 'append failed'),
        items: catalog.take(1),
        hasReachedMax: false,
      ),
    ],
  );

  blocTest<UniversitiesBloc, UniversitiesState>(
    'ignores next page while loading more',
    build: buildBloc,
    seed: () => UniversitiesLoaded(
      items: List<University>.of(catalog.take(1)),
      hasReachedMax: false,
      isLoadingMore: true,
    ),
    act: (bloc) => bloc.add(const UniversitiesNextPageRequested()),
    expect: () => <UniversitiesState>[],
  );

  blocTest<UniversitiesBloc, UniversitiesState>(
    'ignores next page when max is reached',
    build: buildBloc,
    seed: () => UniversitiesLoaded(
      items: List<University>.of(catalog.take(1)),
      hasReachedMax: true,
    ),
    act: (bloc) => bloc.add(const UniversitiesNextPageRequested()),
    expect: () => <UniversitiesState>[],
  );

  blocTest<UniversitiesBloc, UniversitiesState>(
    'retries the first page from an empty failure',
    build: buildBloc,
    setUp: () {
      when(() => getUniversitiesPage(page: 0)).thenAnswer(
        (_) async => Ok<UniversitiesSliceEntity, Failure>(
          UniversitiesSliceEntity(items: catalog.take(1), hasReachedMax: true),
        ),
      );
    },
    seed: () => const UniversitiesFailure(
      failure: NetworkFailure(message: 'down'),
      items: [],
      hasReachedMax: false,
    ),
    act: (bloc) => bloc.add(const UniversitiesRetryRequested()),
    expect: () => [
      const UniversitiesLoading(),
      UniversitiesLoaded(items: catalog.take(1), hasReachedMax: true),
    ],
  );

  blocTest<UniversitiesBloc, UniversitiesState>(
    'retries the pending page after an append failure',
    build: buildBloc,
    setUp: () {
      when(() => getUniversitiesPage(page: 0)).thenAnswer(
        (_) async => Ok<UniversitiesSliceEntity, Failure>(
          UniversitiesSliceEntity(items: catalog.take(1), hasReachedMax: false),
        ),
      );
      when(() => getUniversitiesPage(page: 1)).thenAnswer(
        (_) async => const Err<UniversitiesSliceEntity, Failure>(
          NetworkFailure(message: 'append failed'),
        ),
      );
    },
    act: (bloc) async {
      bloc.add(const UniversitiesRequested());
      await Future<void>.delayed(Duration.zero);
      bloc.add(const UniversitiesNextPageRequested());
      await Future<void>.delayed(Duration.zero);
      when(() => getUniversitiesPage(page: 1)).thenAnswer(
        (_) async => Ok<UniversitiesSliceEntity, Failure>(
          UniversitiesSliceEntity(items: [catalog.at(1)], hasReachedMax: true),
        ),
      );
      bloc.add(const UniversitiesRetryRequested());
    },
    expect: () => [
      const UniversitiesLoading(),
      UniversitiesLoaded(items: catalog.take(1), hasReachedMax: false),
      UniversitiesLoaded(
        items: catalog.take(1),
        hasReachedMax: false,
        isLoadingMore: true,
      ),
      UniversitiesFailure(
        failure: const NetworkFailure(message: 'append failed'),
        items: catalog.take(1),
        hasReachedMax: false,
      ),
      UniversitiesLoaded(
        items: catalog.take(1),
        hasReachedMax: false,
        isLoadingMore: true,
      ),
      UniversitiesLoaded(items: catalog.take(2), hasReachedMax: true),
    ],
  );
}
