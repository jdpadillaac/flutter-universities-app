import 'package:equatable/equatable.dart';
import 'package:universities_app/features/universities/domain/entities/image_origin.dart';

sealed class UniversityDetailEvent extends Equatable {
  const UniversityDetailEvent();

  @override
  List<Object?> get props => [];
}

final class UniversityDetailRequested extends UniversityDetailEvent {
  const UniversityDetailRequested(this.universityId);

  final String? universityId;

  @override
  List<Object?> get props => [universityId];
}

final class UniversityStudentsChanged extends UniversityDetailEvent {
  const UniversityStudentsChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class UniversityImagePickRequested extends UniversityDetailEvent {
  const UniversityImagePickRequested(this.origin);

  final ImageOrigin origin;

  @override
  List<Object?> get props => [origin];
}

final class UniversityStudentsSaveRequested extends UniversityDetailEvent {
  const UniversityStudentsSaveRequested();
}

final class UniversityDetailNoticeShown extends UniversityDetailEvent {
  const UniversityDetailNoticeShown();
}
