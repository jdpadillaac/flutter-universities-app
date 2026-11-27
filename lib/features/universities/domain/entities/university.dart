import 'package:freezed_annotation/freezed_annotation.dart';

part 'university.freezed.dart';

/// A university from the remote catalog.
@freezed
abstract class University with _$University {
  /// Creates a university.
  const factory University({
    required String id,
    required String name,
    required String country,
    required String countryCode,
    required List<String> domains,
    required List<String> webPages,
    String? stateProvince,
  }) = _University;

  /// Stable id from [name] and [firstDomain], safe as a route param.
  ///
  /// Each value is lowercased and every non-alphanumeric run becomes `-`.
  static String buildId(String name, String firstDomain) =>
      '${_slug(name)}--${_slug(firstDomain)}';
}

String _slug(String value) =>
    value.toLowerCase().replaceAll(RegExp('[^a-z0-9]+'), '-');
