import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/domain/entities/university_extras.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';

void main() {
  test('copyWith updates and clears fields', () {
    const extras = UniversityExtras(imagePath: '/a.jpg');
    final count = StudentCount.parse('10').unwrap();

    final updated = extras.copyWith(studentCount: count, clearImagePath: true);

    expect(updated.imagePath, isNull);
    expect(updated.studentCount?.value, 10);
  });
}
