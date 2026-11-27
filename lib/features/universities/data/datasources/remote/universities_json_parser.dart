import 'dart:convert';
import 'dart:isolate';

import 'package:injectable/injectable.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/data/datasources/remote/dtos/university_dto.dart';
import 'package:universities_app/features/universities/data/datasources/remote/university_dto_mapper.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';

@lazySingleton
class UniversitiesJsonParser {
  const UniversitiesJsonParser(this._mapper);

  final UniversityDtoMapper _mapper;

  Future<Result<List<University>, Failure>> parse(String body) {
    final mapper = _mapper;
    return Isolate.run(() => _parse(body, mapper));
  }

  static Result<List<University>, Failure> _parse(
    String body,
    UniversityDtoMapper mapper,
  ) {
    final decoded = Result<Object?, Object>.of(
      () => jsonDecode(body) as Object?,
    ).mapErr<Failure>(_parsingFailure);

    return decoded.andThen((value) => _universitiesFromDecoded(value, mapper));
  }

  static Result<List<University>, Failure> _universitiesFromDecoded(
    Object? value,
    UniversityDtoMapper mapper,
  ) {
    if (value is! List<dynamic>) {
      return const Err(ParsingFailure(message: 'Expected a JSON list.'));
    }

    final universities = <University>[];
    for (final item in value) {
      if (item is! Map) {
        return const Err(ParsingFailure(message: 'Expected a JSON object.'));
      }

      switch (_universityFromMap(item, mapper)) {
        case Ok(:final value):
          universities.add(value);
        case Err(:final error):
          return Err(error);
      }
    }

    return Ok(universities.toList(growable: false));
  }

  static Result<University, Failure> _universityFromMap(
    Map<dynamic, dynamic> item,
    UniversityDtoMapper mapper,
  ) {
    final dto = Result<UniversityDto, Object>.of(
      () => UniversityDto.fromJson(Map<String, dynamic>.from(item)),
    ).mapErr<Failure>(_parsingFailure);

    return dto.andThen(
      (value) => Result<University, Object>.of(
        () => mapper.map(value),
      ).mapErr<Failure>(_parsingFailure),
    );
  }

  static ParsingFailure _parsingFailure(Object error) =>
      ParsingFailure(message: error.toString());
}
