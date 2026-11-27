import 'package:injectable/injectable.dart';

@lazySingleton
class UniversityIdGenerator {
  const UniversityIdGenerator();

  String buildId(String name, String firstDomain) =>
      '${_slug(name)}--${_slug(firstDomain)}';

  String _slug(String value) =>
      value.toLowerCase().replaceAll(RegExp('[^a-z0-9]+'), '-');
}
