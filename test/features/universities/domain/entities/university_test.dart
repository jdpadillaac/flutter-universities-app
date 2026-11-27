import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';

void main() {
  const university = University(
    id: 'marywood-university--marywood-edu',
    name: 'Marywood University',
    country: 'United States',
    countryCode: 'US',
    domains: ['marywood.edu'],
    webPages: ['http://marywood.edu'],
  );

  test('compares universities by value', () {
    const same = University(
      id: 'marywood-university--marywood-edu',
      name: 'Marywood University',
      country: 'United States',
      countryCode: 'US',
      domains: ['marywood.edu'],
      webPages: ['http://marywood.edu'],
    );
    const renamed = University(
      id: 'marywood-university--marywood-edu',
      name: 'Other',
      country: 'United States',
      countryCode: 'US',
      domains: ['marywood.edu'],
      webPages: ['http://marywood.edu'],
    );

    expect(university, same);
    expect(university, isNot(renamed));
  });
}
