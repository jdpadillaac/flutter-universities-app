/// HTTP client configuration for remote APIs.
abstract final class ApiConfig {
  static const String baseUrl = 'http://universities.hipolabs.com';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);
}
