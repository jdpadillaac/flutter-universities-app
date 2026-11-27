import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';
import 'package:universities_app/features/universities/presentation/pages/university_detail/student_count_error_message.dart';
import 'package:universities_app/l10n/generated/app_localizations_es.dart';

void main() {
  const message = StudentCountErrorMessage();

  test('maps student count errors to localized text', () {
    final l10n = AppLocalizationsEs();
    expect(
      message.resolve(StudentCountError.empty, l10n),
      l10n.studentCountEmpty,
    );
    expect(
      message.resolve(StudentCountError.notANumber, l10n),
      l10n.studentCountNotANumber,
    );
    expect(
      message.resolve(StudentCountError.mustBePositive, l10n),
      l10n.studentCountMustBePositive,
    );
    expect(
      message.resolve(StudentCountError.tooLarge, l10n),
      l10n.studentCountTooLarge,
    );
  });
}
