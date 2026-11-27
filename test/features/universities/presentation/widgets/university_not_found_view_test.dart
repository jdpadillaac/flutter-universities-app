import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:universities_app/core/router/app_routes.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_not_found_view.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('goes to list when there is nothing to pop', (tester) async {
    final router = GoRouter(
      initialLocation: AppRoutes.universityDetailPath('missing'),
      routes: [
        GoRoute(
          path: AppRoutes.list,
          builder: (context, state) => const Scaffold(body: Text('home')),
          routes: [
            GoRoute(
              path: 'universities/:id',
              builder: (context, state) =>
                  const Scaffold(body: UniversityNotFoundView()),
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
    await tester.pumpAndSettle();

    await tester.tap(find.text('Volver a la lista'));
    await tester.pumpAndSettle();

    expect(find.text('home'), findsOneWidget);
  });
}
