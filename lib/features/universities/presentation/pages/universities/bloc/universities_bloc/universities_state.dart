import 'package:equatable/equatable.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';

sealed class UniversitiesState extends Equatable {
  const UniversitiesState();

  @override
  List<Object?> get props => [];
}

final class UniversitiesInitial extends UniversitiesState {
  const UniversitiesInitial();
}

final class UniversitiesLoading extends UniversitiesState {
  const UniversitiesLoading();
}

final class UniversitiesLoaded extends UniversitiesState {
  const UniversitiesLoaded({
    required this.items,
    required this.hasReachedMax,
    this.isLoadingMore = false,
  });

  final List<University> items;
  final bool hasReachedMax;
  final bool isLoadingMore;

  UniversitiesLoaded copyWith({
    List<University>? items,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return UniversitiesLoaded(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, isLoadingMore];
}

final class UniversitiesFailure extends UniversitiesState {
  const UniversitiesFailure({
    required this.failure,
    required this.items,
    required this.hasReachedMax,
  });

  final Failure failure;
  final List<University> items;
  final bool hasReachedMax;

  @override
  List<Object?> get props => [failure, items, hasReachedMax];
}
