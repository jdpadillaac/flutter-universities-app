import 'package:equatable/equatable.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';

enum StudentCountSaveStatus { idle, saved }

sealed class UniversityDetailState extends Equatable {
  const UniversityDetailState();

  @override
  List<Object?> get props => [];
}

final class UniversityDetailLoading extends UniversityDetailState {
  @override
  List<Object?> get props => [];
}

final class UniversityDetailNotFound extends UniversityDetailState {
  @override
  List<Object?> get props => [];
}

final class UniversityDetailLoaded extends UniversityDetailState {
  const UniversityDetailLoaded({
    required this.university,
    this.imagePath,
    this.studentsInput = '',
    this.validationError,
    this.studentsTouched = false,
    this.saveStatus = StudentCountSaveStatus.idle,
    this.imageFailure,
  });

  final University university;
  final String? imagePath;
  final String studentsInput;
  final StudentCountError? validationError;
  final bool studentsTouched;
  final StudentCountSaveStatus saveStatus;
  final Failure? imageFailure;

  bool get isValid =>
      StudentCount.parse(studentsInput).isOk() && studentsInput.isNotEmpty;

  StudentCountError? get visibleError =>
      studentsTouched ? validationError : null;

  UniversityDetailLoaded copyWith({
    University? university,
    String? imagePath,
    String? studentsInput,
    StudentCountError? validationError,
    bool? studentsTouched,
    StudentCountSaveStatus? saveStatus,
    Failure? imageFailure,
    bool clearValidationError = false,
    bool clearImageFailure = false,
  }) {
    return UniversityDetailLoaded(
      university: university ?? this.university,
      imagePath: imagePath ?? this.imagePath,
      studentsInput: studentsInput ?? this.studentsInput,
      validationError: clearValidationError
          ? null
          : validationError ?? this.validationError,
      studentsTouched: studentsTouched ?? this.studentsTouched,
      saveStatus: saveStatus ?? this.saveStatus,
      imageFailure: clearImageFailure
          ? null
          : imageFailure ?? this.imageFailure,
    );
  }

  @override
  List<Object?> get props => [
    university,
    imagePath,
    studentsInput,
    validationError,
    studentsTouched,
    saveStatus,
    imageFailure,
  ];
}
