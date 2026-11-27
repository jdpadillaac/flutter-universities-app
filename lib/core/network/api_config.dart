/// HTTP client configuration for remote APIs.
abstract final class ApiConfig {
  static const String baseUrl = 'https://tyba-assets.s3.amazonaws.com';

  static const String universitiesPath = '/FE-Engineer-test/universities.json';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);
}
