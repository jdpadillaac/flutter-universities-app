import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/presentation/services/university_initials_resolver.dart';

void main() {
  const resolver = UniversityInitialsResolver();

  test('uses first letters of first two words', () {
    expect(resolver.resolve('Marywood University'), 'MU');
  });

  test('uses first word when it starts with a digit', () {
    expect(resolver.resolve('42 US'), '42');
  });

  test('uses first letter for a single word', () {
    expect(resolver.resolve('Stanford'), 'S');
  });

  test('returns empty for blank name', () {
    expect(resolver.resolve('   '), '');
  });
}
