import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/data/datasources/remote/dtos/university_dto.dart';

import '../../../../../../helpers/fixture_reader.dart';

void main() {
  const fixtures = FixtureReader();

  test('fromJson reads the catalog fields', () {
    final json =
        jsonDecode(fixtures.read('universities.json')) as List<dynamic>;
    final dtos = [
      for (final item in json)
        UniversityDto.fromJson(item as Map<String, dynamic>),
    ];

    expect(dtos, hasLength(3));
    expect(dtos[0].name, 'Arts &amp; Science College');
    expect(dtos[0].countryCode, 'US');
    expect(dtos[0].stateProvince, isNull);
    expect(dtos[0].webPages, ['http://arts.edu']);
    expect(dtos[1].stateProvince, 'Ontario');
    expect(dtos[2].domains, ['multi.edu', 'multi.ac.uk']);
  });
}
