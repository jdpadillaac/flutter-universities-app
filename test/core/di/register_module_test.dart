import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/core/di/register_module.dart';
import 'package:universities_app/core/network/api_config.dart';

class TestRegisterModule extends RegisterModule {}

void main() {
  test('dio uses the S3 client options', () {
    final dio = TestRegisterModule().dio;

    expect(dio.options.baseUrl, ApiConfig.baseUrl);
    expect(dio.options.connectTimeout, ApiConfig.connectTimeout);
    expect(dio.options.receiveTimeout, ApiConfig.receiveTimeout);
    expect(dio.options.sendTimeout, ApiConfig.sendTimeout);
    expect(dio.options.headers['Accept'], 'application/json');
  });
}
