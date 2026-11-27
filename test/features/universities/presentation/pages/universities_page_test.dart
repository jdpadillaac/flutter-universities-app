import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/universities_slice_entity.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/services/university_id_generator.dart';
import 'package:universities_app/features/universities/domain/usecases/get_universities_page.dart';
import 'package:universities_app/features/universities/domain/usecases/watch_university_extras.dart';
import 'package:universities_app/features/universities/presentation/bloc/layout_cubit.dart';
import 'package:universities_app/features/universities/presentation/bloc/universities_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/universities_event.dart';
import 'package:universities_app/features/universities/presentation/bloc/universities_state.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_thumbnails_bloc.dart';
import 'package:universities_app/features/universities/presentation/pages/universities_page.dart';

class MockGetUniversitiesPage extends Mock implements GetUniversitiesPage {}

class MockWatchUniversityExtras extends Mock implements WatchUniversityExtras {}

class PageUniversityCatalog {
  const PageUniversityCatalog(this._ids);

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

Widget buildListHarness({
  required UniversitiesBloc universitiesBloc,
  required UniversityThumbnailsBloc thumbnailsBloc,
  LayoutCubit? layoutCubit,
}) {
  return MaterialApp(
    home: MultiBlocProvider(
      providers: [
        BlocProvider.value(value: universitiesBloc),
        BlocProvider.value(value: thumbnailsBloc),
        BlocProvider(create: (_) => layoutCubit ?? LayoutCubit()),
      ],
      child: const UniversitiesView(),
    ),
  );
}

void main() {
  late MockGetUniversitiesPage getUniversitiesPage;
  late MockWatchUniversityExtras watchUniversityExtras;
  const catalog = PageUniversityCatalog(UniversityIdGenerator());

  setUpAll(registerFallbackValues);

  setUp(() {
    getUniversitiesPage = MockGetUniversitiesPage();
    watchUniversityExtras = MockWatchUniversityExtras();
    when(watchUniversityExtras.call).thenAnswer((_) => const Stream.empty());
  });

  UniversityThumbnailsBloc buildThumbnailsBloc() =>
      UniversityThumbnailsBloc(watchUniversityExtras);

  testWidgets('shows empty state when loaded list is empty', (tester) async {
    final bloc = UniversitiesBloc(getUniversitiesPage)
      ..emit(const UniversitiesLoaded(items: [], hasReachedMax: true));
    await tester.pumpWidget(
      buildListHarness(
        universitiesBloc: bloc,
        thumbnailsBloc: buildThumbnailsBloc(),
      ),
    );

    expect(find.text('No universities available.'), findsOneWidget);
  });

  testWidgets('shows progress for the initial state', (tester) async {
    final bloc = UniversitiesBloc(getUniversitiesPage);
    await tester.pumpWidget(
      buildListHarness(
        universitiesBloc: bloc,
        thumbnailsBloc: buildThumbnailsBloc(),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows loading indicator', (tester) async {
    final bloc = UniversitiesBloc(getUniversitiesPage)
      ..emit(const UniversitiesLoading());
    await tester.pumpWidget(
      buildListHarness(
        universitiesBloc: bloc,
        thumbnailsBloc: buildThumbnailsBloc(),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows initial failure with retry', (tester) async {
    when(() => getUniversitiesPage(page: 0)).thenAnswer(
      (_) async => Ok<UniversitiesSliceEntity, Failure>(
        UniversitiesSliceEntity(items: catalog.take(1), hasReachedMax: true),
      ),
    );

    final bloc = UniversitiesBloc(getUniversitiesPage)
      ..emit(
        const UniversitiesFailure(
          failure: NetworkFailure(message: 'offline'),
          items: [],
          hasReachedMax: false,
        ),
      );
    await tester.pumpWidget(
      buildListHarness(
        universitiesBloc: bloc,
        thumbnailsBloc: buildThumbnailsBloc(),
      ),
    );

    expect(find.text('offline'), findsOneWidget);
    await tester.tap(find.text('Reintentar'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(bloc.state, isA<UniversitiesLoaded>());
  });

  testWidgets('shows failure banner while keeping items', (tester) async {
    final items = catalog.take(2);
    final bloc = UniversitiesBloc(getUniversitiesPage)
      ..emit(
        UniversitiesFailure(
          failure: const NetworkFailure(message: 'append failed'),
          items: items,
          hasReachedMax: false,
        ),
      );
    await tester.pumpWidget(
      buildListHarness(
        universitiesBloc: bloc,
        thumbnailsBloc: buildThumbnailsBloc(),
      ),
    );

    expect(find.text('University 0'), findsOneWidget);
    expect(find.text('append failed'), findsOneWidget);
    expect(find.text('Reintentar'), findsOneWidget);
  });

  testWidgets('shows loading more footer', (tester) async {
    final bloc = UniversitiesBloc(getUniversitiesPage)
      ..emit(
        UniversitiesLoaded(
          items: catalog.take(2),
          hasReachedMax: false,
          isLoadingMore: true,
        ),
      );
    await tester.pumpWidget(
      buildListHarness(
        universitiesBloc: bloc,
        thumbnailsBloc: buildThumbnailsBloc(),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('toggles layout between list and grid', (tester) async {
    final bloc = UniversitiesBloc(getUniversitiesPage)
      ..emit(UniversitiesLoaded(items: catalog.take(2), hasReachedMax: true));
    await tester.pumpWidget(
      buildListHarness(
        universitiesBloc: bloc,
        thumbnailsBloc: buildThumbnailsBloc(),
      ),
    );

    expect(find.byType(ListView), findsOneWidget);
    await tester.tap(find.byIcon(Icons.grid_view));
    await tester.pumpAndSettle();
    expect(find.byType(GridView), findsOneWidget);
  });

  testWidgets('requests the next page near the scroll end', (tester) async {
    when(() => getUniversitiesPage(page: 0)).thenAnswer(
      (_) async => Ok<UniversitiesSliceEntity, Failure>(
        UniversitiesSliceEntity(items: catalog.take(30), hasReachedMax: false),
      ),
    );
    when(() => getUniversitiesPage(page: 1)).thenAnswer(
      (_) async => Ok<UniversitiesSliceEntity, Failure>(
        UniversitiesSliceEntity(items: [catalog.at(30)], hasReachedMax: true),
      ),
    );

    final bloc = UniversitiesBloc(getUniversitiesPage);
    await tester.pumpWidget(
      buildListHarness(
        universitiesBloc: bloc,
        thumbnailsBloc: buildThumbnailsBloc(),
      ),
    );
    bloc.add(const UniversitiesRequested());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    await tester.drag(find.byType(Scrollable), const Offset(0, -4000));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    verify(() => getUniversitiesPage(page: 1)).called(1);
  });
}

void registerFallbackValues() {
  registerFallbackValue(0);
}
