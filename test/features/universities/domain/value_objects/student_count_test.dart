import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';

void main() {
  test('parses valid counts', () {
    expect(StudentCount.parse('1').unwrap().value, 1);
    expect(StudentCount.parse('1000000').unwrap().value, 1000000);
  });

  test('rejects invalid counts', () {
    expect(StudentCount.parse('').unwrapErr(), StudentCountError.empty);
    expect(StudentCount.parse('   ').unwrapErr(), StudentCountError.empty);
    expect(StudentCount.parse('abc').unwrapErr(), StudentCountError.notANumber);
    expect(StudentCount.parse('1.5').unwrapErr(), StudentCountError.notANumber);
    expect(
      StudentCount.parse('0').unwrapErr(),
      StudentCountError.mustBePositive,
    );
    expect(
      StudentCount.parse('-3').unwrapErr(),
      StudentCountError.mustBePositive,
    );
    expect(
      StudentCount.parse('1000001').unwrapErr(),
      StudentCountError.tooLarge,
    );
    expect(
      StudentCount.parse('9' * 30).unwrapErr(),
      StudentCountError.tooLarge,
    );
  });
}
