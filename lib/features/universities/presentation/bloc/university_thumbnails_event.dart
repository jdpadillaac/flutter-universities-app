import 'package:equatable/equatable.dart';

sealed class UniversityThumbnailsEvent extends Equatable {
  const UniversityThumbnailsEvent();

  @override
  List<Object?> get props => [];
}

final class UniversityThumbnailsSubscriptionRequested
    extends UniversityThumbnailsEvent {
  const UniversityThumbnailsSubscriptionRequested();
}
