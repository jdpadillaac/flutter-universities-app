import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class StudentCountErrorMessage {
  const StudentCountErrorMessage();

  String resolve(StudentCountError error, AppLocalizations l10n) {
    return switch (error) {
      StudentCountError.empty => l10n.studentCountEmpty,
      StudentCountError.notANumber => l10n.studentCountNotANumber,
      StudentCountError.mustBePositive => l10n.studentCountMustBePositive,
      StudentCountError.tooLarge => l10n.studentCountTooLarge,
    };
  }
}
