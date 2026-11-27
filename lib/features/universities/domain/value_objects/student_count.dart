import 'package:equatable/equatable.dart';
import 'package:oxidized/oxidized.dart';

enum StudentCountError { empty, notANumber, mustBePositive, tooLarge }

class StudentCount extends Equatable {
  const StudentCount._(this.value);

  static const int max = 1000000;

  final int value;

  static Result<StudentCount, StudentCountError> parse(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return const Err(StudentCountError.empty);
    }
    final pattern = RegExp(r'^-?\d+$');
    if (!pattern.hasMatch(trimmed)) {
      return const Err(StudentCountError.notANumber);
    }
    final bigValue = BigInt.tryParse(trimmed);
    if (bigValue == null) {
      return const Err(StudentCountError.notANumber);
    }
    if (bigValue <= BigInt.zero) {
      return const Err(StudentCountError.mustBePositive);
    }
    if (bigValue > BigInt.from(max)) {
      return const Err(StudentCountError.tooLarge);
    }
    return Ok(StudentCount._(bigValue.toInt()));
  }

  @override
  List<Object?> get props => [value];
}
