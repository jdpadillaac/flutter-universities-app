import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:universities_app/core/network/api_config.dart';
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
    initialLocation: AppRoutes.list,
    routes: [
      GoRoute(
        path: AppRoutes.list,
        name: AppRoutes.list,
        builder: (context, state) => const UniversitiesPage(),
        routes: [
          GoRoute(
            path: 'universities/:id',
            name: AppRoutes.universityDetail,
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return UniversityDetailPage(universityId: id);
            },
          ),
        ],
      ),
    ],
  );

  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();
}
