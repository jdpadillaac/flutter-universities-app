import 'package:equatable/equatable.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';

class UniversityExtras extends Equatable {
  const UniversityExtras({this.imagePath, this.studentCount});

  final String? imagePath;
  final StudentCount? studentCount;

  UniversityExtras copyWith({
    String? imagePath,
    StudentCount? studentCount,
    bool clearImagePath = false,
    bool clearStudentCount = false,
  }) {
    return UniversityExtras(
      imagePath: clearImagePath ? null : imagePath ?? this.imagePath,
      studentCount: clearStudentCount
          ? null
          : studentCount ?? this.studentCount,
    );
  }

  @override
  List<Object?> get props => [imagePath, studentCount];
}
