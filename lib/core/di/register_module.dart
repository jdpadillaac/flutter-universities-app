import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:universities_app/core/network/api_config.dart';
import 'package:universities_app/core/router/app_navigation_keys.dart';
import 'package:universities_app/core/router/app_routes.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/universities_page.dart';
import 'package:universities_app/features/universities/presentation/pages/university_detail/university_detail_page.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      sendTimeout: ApiConfig.sendTimeout,
      headers: const {'Accept': 'application/json'},
    ),
  );

  @lazySingleton
  GoRouter get goRouter => GoRouter(
    navigatorKey: AppNavigationKeys.rootNavigatorKey,
    initialLocation: AppRoutes.list,
    routes: [
      ShellRoute(
        navigatorKey: AppNavigationKeys.shellNavigatorKey,
        builder: (context, state, child) => child,
        routes: [
          GoRoute(
            path: AppRoutes.list,
            name: AppRoutes.list,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: UniversitiesPage()),
            routes: [
              GoRoute(
                path: 'universities/:id',
                name: AppRoutes.universityDetail,
                parentNavigatorKey: AppNavigationKeys.rootNavigatorKey,
                builder: (context, state) {
                  final id = state.pathParameters['id'];
                  return UniversityDetailPage(universityId: id);
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();
}
