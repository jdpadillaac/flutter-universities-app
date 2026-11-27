import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:universities_app/core/utils/html_entity_decoder.dart';
import 'package:universities_app/features/universities/data/datasources/remote/dtos/university_dto.dart';
import 'package:universities_app/features/universities/data/datasources/remote/university_dto_mapper.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/services/university_id_generator.dart';

class MockHtmlEntityDecoder extends Mock implements HtmlEntityDecoder {}

class MockUniversityIdGenerator extends Mock implements UniversityIdGenerator {}

void main() {
  late MockHtmlEntityDecoder decoder;
  late MockUniversityIdGenerator ids;
  late UniversityDtoMapper mapper;

  setUp(() {
    decoder = MockHtmlEntityDecoder();
    ids = MockUniversityIdGenerator();
    mapper = UniversityDtoMapper(decoder, ids);
  });

  test('decodes the name and builds the id from the first domain', () {
    when(() => decoder.decode('A &amp; B')).thenReturn('A & B');
    when(() => ids.buildId('A & B', 'a.edu')).thenReturn('a-b--a-edu');

    final entity = mapper.map(
      const UniversityDto(
        name: 'A &amp; B',
        country: 'Country',
        countryCode: 'CO',
        domains: ['a.edu', 'b.edu'],
        webPages: ['https://a.edu'],
        stateProvince: 'Lima',
      ),
    );

    expect(
      entity,
      const University(
        id: 'a-b--a-edu',
        name: 'A & B',
        country: 'Country',
        countryCode: 'CO',
        domains: ['a.edu', 'b.edu'],
        webPages: ['https://a.edu'],
        stateProvince: 'Lima',
      ),
    );
    verify(() => decoder.decode('A &amp; B')).called(1);
    verify(() => ids.buildId('A & B', 'a.edu')).called(1);
  });

  test('uses an empty domain when the list is empty', () {
    when(() => decoder.decode('Empty Domains')).thenReturn('Empty Domains');
    when(() => ids.buildId('Empty Domains', '')).thenReturn('empty-domains--');

    final entity = mapper.map(
      const UniversityDto(
        name: 'Empty Domains',
        country: 'Nowhere',
        countryCode: 'NW',
        domains: [],
        webPages: [],
      ),
    );

    expect(entity.id, 'empty-domains--');
    verify(() => ids.buildId('Empty Domains', '')).called(1);
  });
}
