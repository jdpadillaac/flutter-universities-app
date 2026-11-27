import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/domain/services/university_id_generator.dart';

void main() {
  const generator = UniversityIdGenerator();

  test('buildId is stable and normalizes text', () {
    const name = 'Marywood University';
    const domain = 'marywood.edu';

    expect(
      generator.buildId(name, domain),
      'marywood-university--marywood-edu',
    );
    expect(generator.buildId(name, domain), generator.buildId(name, domain));
  });

  test('buildId tolerates an empty domain', () {
    expect(
      generator.buildId('Marywood University', ''),
      'marywood-university--',
    );
  });
}
