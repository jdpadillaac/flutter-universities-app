import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/core/utils/html_entity_decoder.dart';
import 'package:universities_app/features/universities/data/datasources/remote/dtos/university_dto.dart';
import 'package:universities_app/features/universities/data/datasources/remote/universities_json_parser.dart';
import 'package:universities_app/features/universities/data/datasources/remote/university_dto_mapper.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/services/university_id_generator.dart';

import '../../../../../helpers/fixture_reader.dart';

class FixedIdMapper extends UniversityDtoMapper {
  FixedIdMapper() : super(HtmlEntityDecoder(), const UniversityIdGenerator());

  @override
  University map(UniversityDto dto) {
    return University(
      id: 'fixed',
      name: dto.name,
      country: dto.country,
      countryCode: dto.countryCode,
      domains: dto.domains,
      webPages: dto.webPages,
      stateProvince: dto.stateProvince,
    );
  }
}

void main() {
  const fixtures = FixtureReader();
  final parser = UniversitiesJsonParser(
    UniversityDtoMapper(HtmlEntityDecoder(), const UniversityIdGenerator()),
  );

  test('parses the fixture inside an isolate', () async {
    final result = await parser.parse(fixtures.read('universities.json'));
    final universities = result.unwrap();

    expect(universities, hasLength(3));
    expect(universities.first.name, 'Arts & Science College');
    expect(universities.first.id, 'arts-science-college--arts-edu');
    expect(universities.first.countryCode, 'US');
    expect(universities.first.stateProvince, isNull);
    expect(universities[1].stateProvince, 'Ontario');
    expect(universities[2].id, 'multi-domain-university--multi-edu');
    expect(universities[2].domains, hasLength(2));
  });

  test('uses the injected mapper', () async {
    final parser = UniversitiesJsonParser(FixedIdMapper());

    final result = await parser.parse(fixtures.read('universities.json'));

    expect(result.unwrap().first.id, 'fixed');
  });

  test('returns ParsingFailure when the JSON is invalid', () async {
    final result = await parser.parse('{');

    expect(result.unwrapErr(), isA<ParsingFailure>());
    expect(result.unwrapErr().message, contains('FormatException'));
  });

  test('returns ParsingFailure when the JSON is not a list', () async {
    final result = await parser.parse('{}');

    expect(
      result.unwrapErr(),
      const ParsingFailure(message: 'Expected a JSON list.'),
    );
  });

  test('returns ParsingFailure when an item is not an object', () async {
    final result = await parser.parse('[1]');

    expect(
      result.unwrapErr(),
      const ParsingFailure(message: 'Expected a JSON object.'),
    );
  });

  test('returns ParsingFailure when an object cannot be read', () async {
    final result = await parser.parse('[{"name":1}]');

    expect(result.unwrapErr(), isA<ParsingFailure>());
  });

  test('returns an empty list for an empty catalog', () async {
    final result = await parser.parse('[]');

    expect(result.unwrap(), isEmpty);
  });
}
