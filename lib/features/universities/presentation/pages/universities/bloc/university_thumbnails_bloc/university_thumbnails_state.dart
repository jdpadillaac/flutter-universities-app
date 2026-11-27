import 'package:equatable/equatable.dart';

sealed class UniversityThumbnailsState extends Equatable {
  const UniversityThumbnailsState();

  @override
  List<Object?> get props => [];
}

final class UniversityThumbnailsInitial extends UniversityThumbnailsState {
  @override
  List<Object?> get props => [];
}

final class UniversityThumbnailsLoaded extends UniversityThumbnailsState {
  const UniversityThumbnailsLoaded({this.imagePaths = const {}});

  final Map<String, String> imagePaths;

  @override
  List<Object?> get props => [imagePaths];
}
