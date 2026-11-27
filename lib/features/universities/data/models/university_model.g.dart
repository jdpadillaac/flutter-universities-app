// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UniversityModel _$UniversityModelFromJson(Map<String, dynamic> json) =>
    _UniversityModel(
      name: json['name'] as String,
      country: json['country'] as String,
      countryCode: json['alpha_two_code'] as String,
      domains: (json['domains'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      webPages: (json['web_pages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      stateProvince: json['state-province'] as String?,
    );

Map<String, dynamic> _$UniversityModelToJson(_UniversityModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'country': instance.country,
      'alpha_two_code': instance.countryCode,
      'domains': instance.domains,
      'web_pages': instance.webPages,
      'state-province': instance.stateProvince,
    };
