import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:universities_app/core/utils/html_entities.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';

part 'university_model.freezed.dart';
part 'university_model.g.dart';

/// JSON representation of a university from the remote catalog.
@freezed
abstract class UniversityModel with _$UniversityModel {
  /// Creates a model.
  const factory UniversityModel({
    required String name,
    required String country,
    @JsonKey(name: 'alpha_two_code') required String countryCode,
    required List<String> domains,
    @JsonKey(name: 'web_pages') required List<String> webPages,
    @JsonKey(name: 'state-province') String? stateProvince,
  }) = _UniversityModel;

  const UniversityModel._();

  /// Parses a university object.
  factory UniversityModel.fromJson(Map<String, dynamic> json) =>
      _$UniversityModelFromJson(json);

  /// Maps this model to a domain [University].
  ///
  /// [name] is HTML-decoded. The id uses the first domain, or an empty
  /// string when the list is empty.
  University toEntity() {
    final decodedName = decodeHtmlEntities(name);
    final firstDomain = domains.firstOrNull ?? '';
    return University(
      id: University.buildId(decodedName, firstDomain),
      name: decodedName,
      country: country,
      countryCode: countryCode,
      stateProvince: stateProvince,
      domains: domains,
      webPages: webPages,
    );
  }
}
