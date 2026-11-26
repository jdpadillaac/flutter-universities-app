/// Named route paths and labels for go_router.
abstract final class AppRoutes {
  static const String list = '/';
  static const String universityDetail = 'university-detail';

  static String universityDetailPath(String id) => '/universities/$id';
}
