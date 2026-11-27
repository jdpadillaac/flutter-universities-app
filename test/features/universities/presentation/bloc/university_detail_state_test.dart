import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_state.dart';

void main() {
  const university = University(
    id: 'u-id',
    name: 'Sample',
    country: 'Country',
    countryCode: 'CO',
    domains: ['sample.edu'],
    webPages: ['https://sample.edu'],
  );

  test('loaded state validates student count input', () {
    const valid = UniversityDetailLoaded(
      university: university,
      studentsInput: '10',
    );
    const invalid = UniversityDetailLoaded(university: university);

    expect(valid.isValid, isTrue);
    expect(invalid.isValid, isFalse);
  });

  test('not found is distinct from loading', () {
    expect(
      UniversityDetailLoading(),
      isNot(equals(UniversityDetailNotFound())),
    );
  });
}
