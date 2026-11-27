import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:universities_app/core/router/app_routes.dart';
import 'package:universities_app/features/universities/data/repositories/university_extras_repository_impl.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/services/university_id_generator.dart';
import 'package:universities_app/features/universities/domain/usecases/get_all_university_extras.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/layout_cubit/layout_cubit.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/university_thumbnails_bloc/university_thumbnails_bloc.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/university_thumbnails_bloc/university_thumbnails_event.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/university_thumbnails_bloc/university_thumbnails_state.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/university_initials_resolver.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/widgets/universities_scroll_view.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/widgets/university_list_tile.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('requests thumbnails again after returning from detail', (
    tester,
  ) async {
    const ids = UniversityIdGenerator();
    final university = University(
      id: ids.buildId('Test U', 'test.edu'),
      name: 'Test U',
      country: 'Country',
      countryCode: 'CO',
      domains: ['test.edu'],
      webPages: ['https://test.edu'],
    );

    final repository = UniversityExtrasRepositoryImpl();
    final thumbnailsBloc = UniversityThumbnailsBloc(
      GetAllUniversityExtras(repository),
    );
    final emissions = <UniversityThumbnailsState>[];
    final subscription = thumbnailsBloc.stream.listen(emissions.add);
    addTearDown(subscription.cancel);
    thumbnailsBloc.add(const UniversityThumbnailsRequested());

    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final shellNavigatorKey = GlobalKey<NavigatorState>();

    final router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: AppRoutes.list,
      routes: [
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: thumbnailsBloc),
              BlocProvider(create: (_) => LayoutCubit()),
            ],
            child: child,
          ),
          routes: [
            GoRoute(
              path: AppRoutes.list,
              pageBuilder: (context, state) => NoTransitionPage(
                child: UniversitiesScrollView(
                  items: [university],
                  imagePaths: const {},
                  initialsResolver: const UniversityInitialsResolver(),
                ),
              ),
              routes: [
                GoRoute(
                  path: 'universities/:id',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) {
                    return Scaffold(
                      appBar: AppBar(title: const Text('detail')),
                      body: ElevatedButton(
                        onPressed: () {
                          repository.saveImagePath(
                            universityId: university.id,
                            imagePath: '/tmp/thumb.jpg',
                          );
                          context.pop();
                        },
                        child: const Text('save and close'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        locale: const Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
    await tester.pump();

    expect(emissions, [const UniversityThumbnailsLoaded()]);

    await tester.tap(find.byType(UniversityListTile));
    await tester.pumpAndSettle();

    await tester.tap(find.text('save and close'));
    await tester.pumpAndSettle();

    expect(find.byType(UniversitiesScrollView), findsOneWidget);
    expect(
      emissions.last,
      UniversityThumbnailsLoaded(imagePaths: {university.id: '/tmp/thumb.jpg'}),
    );
    expect(emissions.length, 2);
  });
}
