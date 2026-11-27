import 'package:equatable/equatable.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';

class UniversitiesSliceEntity extends Equatable {
  const UniversitiesSliceEntity({
    required this.items,
    required this.hasReachedMax,
  });

  final List<University> items;
  final bool hasReachedMax;

  @override
  List<Object?> get props => [items, hasReachedMax];
}
