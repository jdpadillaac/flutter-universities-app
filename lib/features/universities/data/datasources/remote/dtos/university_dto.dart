import 'package:freezed_annotation/freezed_annotation.dart';

part 'university_dto.freezed.dart';
part 'university_dto.g.dart';

@freezed
abstract class UniversityDto with _$UniversityDto {
  const factory UniversityDto({
    required String name,
    required String country,
    @JsonKey(name: 'alpha_two_code') required String countryCode,
    required List<String> domains,
    @JsonKey(name: 'web_pages') required List<String> webPages,
    @JsonKey(name: 'state-province') String? stateProvince,
  }) = _UniversityDto;

  factory UniversityDto.fromJson(Map<String, dynamic> json) =>
      _$UniversityDtoFromJson(json);
}
