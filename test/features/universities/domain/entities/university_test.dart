import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';

void main() {
  test('buildId is stable and normalizes text', () {
    const name = 'Marywood University';
    const domain = 'marywood.edu';

    expect(
      University.buildId(name, domain),
      'marywood-university--marywood-edu',
    );
    expect(University.buildId(name, domain), University.buildId(name, domain));
  });

  test('buildId tolerates an empty domain', () {
    expect(
      University.buildId('Marywood University', ''),
      'marywood-university--',
    );
  });
}
