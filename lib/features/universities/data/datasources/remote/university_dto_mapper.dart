import 'package:injectable/injectable.dart';
import 'package:universities_app/core/utils/html_entity_decoder.dart';
import 'package:universities_app/features/universities/data/datasources/remote/dtos/university_dto.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/services/university_id_generator.dart';

@lazySingleton
class UniversityDtoMapper {
  const UniversityDtoMapper(this._decoder, this._idGenerator);

  final HtmlEntityDecoder _decoder;
  final UniversityIdGenerator _idGenerator;

  University map(UniversityDto dto) {
    final decodedName = _decoder.decode(dto.name);
    final firstDomain = dto.domains.firstOrNull ?? '';
    return University(
      id: _idGenerator.buildId(decodedName, firstDomain),
      name: decodedName,
      country: dto.country,
      countryCode: dto.countryCode,
      stateProvince: dto.stateProvince,
      domains: dto.domains,
      webPages: dto.webPages,
    );
  }
}
