import 'package:equatable/equatable.dart';

sealed class UniversitiesEvent extends Equatable {
  const UniversitiesEvent();

  @override
  List<Object?> get props => [];
}

final class UniversitiesRequested extends UniversitiesEvent {
  const UniversitiesRequested();
}

final class UniversitiesNextPageRequested extends UniversitiesEvent {
  const UniversitiesNextPageRequested();
}

final class UniversitiesRetryRequested extends UniversitiesEvent {
  const UniversitiesRetryRequested();
}
