abstract final class AppRoutes {
  static const String list = '/';
  static const String universityDetail = 'university-detail';

  static String universityDetailPath(String id) => '/universities/$id';
}
