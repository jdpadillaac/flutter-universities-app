import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/data/models/university_model.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';

import '../../../../helpers/fixture_reader.dart';

void main() {
  test('fromJson and toEntity decode the fixture', () {
    final json = jsonDecode(fixture('universities.json')) as List<dynamic>;
    final models = [
      for (final item in json)
        UniversityModel.fromJson(item as Map<String, dynamic>),
    ];

    expect(models, hasLength(3));
    expect(models[0].stateProvince, isNull);
    expect(models[1].stateProvince, 'Ontario');
    expect(models[2].domains, ['multi.edu', 'multi.ac.uk']);

    final first = models[0].toEntity();
    expect(first.name, 'Arts & Science College');
    expect(first.id, University.buildId('Arts & Science College', 'arts.edu'));
    expect(first.countryCode, 'US');
    expect(first.webPages, ['http://arts.edu']);

    final third = models[2].toEntity();
    expect(third.id, 'multi-domain-university--multi-edu');
    expect(third.domains, hasLength(2));
  });

  test('toEntity uses an empty domain when the list is empty', () {
    const model = UniversityModel(
      name: 'Empty Domains',
      country: 'Nowhere',
      countryCode: 'NW',
      domains: [],
      webPages: [],
    );

    expect(model.toEntity().id, 'empty-domains--');
  });
}
