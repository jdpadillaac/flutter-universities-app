import 'package:go_router/go_router.dart';
import 'package:universities_app/core/router/app_routes.dart';
import 'package:universities_app/features/universities/presentation/pages/universities_list_page.dart';
import 'package:universities_app/features/universities/presentation/pages/university_detail_page.dart';

/// Builds the application [GoRouter] configuration.
GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRoutes.list,
    routes: [
      GoRoute(
        path: AppRoutes.list,
        name: AppRoutes.list,
        builder: (context, state) => const UniversitiesListPage(),
        routes: [
          GoRoute(
            path: 'universities/:id',
            name: AppRoutes.universityDetail,
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return UniversityDetailPage(universityId: id);
            },
          ),
        ],
      ),
    ],
  );
}
