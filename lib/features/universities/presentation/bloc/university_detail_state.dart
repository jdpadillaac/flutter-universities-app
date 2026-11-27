import 'package:equatable/equatable.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';

enum UniversityDetailStatus { loading, ready, notFound }

enum UniversityDetailNotice { none, saved, permissionDenied, imageFailed }

class UniversityDetailState extends Equatable {
  const UniversityDetailState({
    this.status = UniversityDetailStatus.loading,
    this.university,
    this.imagePath,
    this.studentsInput = '',
    this.validationError,
    this.studentsTouched = false,
    this.notice = UniversityDetailNotice.none,
    this.imageFailedMessage,
  });

  final UniversityDetailStatus status;
  final University? university;
  final String? imagePath;
  final String studentsInput;
  final StudentCountError? validationError;
  final bool studentsTouched;
  final UniversityDetailNotice notice;
  final String? imageFailedMessage;

  bool get isFormValid =>
      StudentCount.parse(studentsInput).isOk() && studentsInput.isNotEmpty;

  StudentCountError? get visibleError =>
      studentsTouched ? validationError : null;

  UniversityDetailState copyWith({
    UniversityDetailStatus? status,
    University? university,
    String? imagePath,
    String? studentsInput,
    StudentCountError? validationError,
    bool? studentsTouched,
    UniversityDetailNotice? notice,
    String? imageFailedMessage,
    bool clearValidationError = false,
    bool clearImageFailedMessage = false,
  }) {
    return UniversityDetailState(
      status: status ?? this.status,
      university: university ?? this.university,
      imagePath: imagePath ?? this.imagePath,
      studentsInput: studentsInput ?? this.studentsInput,
      validationError: clearValidationError
          ? null
          : validationError ?? this.validationError,
      studentsTouched: studentsTouched ?? this.studentsTouched,
      notice: notice ?? this.notice,
      imageFailedMessage: clearImageFailedMessage
          ? null
          : imageFailedMessage ?? this.imageFailedMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    university,
    imagePath,
    studentsInput,
    validationError,
    studentsTouched,
    notice,
    imageFailedMessage,
  ];
}
