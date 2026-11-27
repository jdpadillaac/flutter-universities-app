import 'package:equatable/equatable.dart';

sealed class UniversityThumbnailsEvent extends Equatable {
  const UniversityThumbnailsEvent();

  @override
  List<Object?> get props => [];
}

final class UniversityThumbnailsRequested extends UniversityThumbnailsEvent {
  const UniversityThumbnailsRequested();
}
