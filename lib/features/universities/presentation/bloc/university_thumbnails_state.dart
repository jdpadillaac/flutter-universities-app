import 'package:equatable/equatable.dart';

class UniversityThumbnailsState extends Equatable {
  const UniversityThumbnailsState({this.imagePaths = const {}});

  final Map<String, String> imagePaths;

  UniversityThumbnailsState copyWith({Map<String, String>? imagePaths}) {
    return UniversityThumbnailsState(imagePaths: imagePaths ?? this.imagePaths);
  }

  @override
  List<Object?> get props => [imagePaths];
}
