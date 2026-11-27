import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/university_initials_resolver.dart';

class _UniversityInitialsProbe with UniversityInitialsResolver {
  const _UniversityInitialsProbe();
}

void main() {
  const resolver = _UniversityInitialsProbe();

  test('uses first letters of first two words', () {
    expect(resolver.initialsFrom('Marywood University'), 'MU');
  });

  test('uses first word when it starts with a digit', () {
    expect(resolver.initialsFrom('42 US'), '42');
  });

  test('uses first letter for a single word', () {
    expect(resolver.initialsFrom('Stanford'), 'S');
  });

  test('returns empty for blank name', () {
    expect(resolver.initialsFrom('   '), '');
  });
}
