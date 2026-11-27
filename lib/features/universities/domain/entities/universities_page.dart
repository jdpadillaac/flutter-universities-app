import 'package:equatable/equatable.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';

class UniversitiesPage extends Equatable {
  const UniversitiesPage({required this.items, required this.hasReachedMax});

  final List<University> items;
  final bool hasReachedMax;

  @override
  List<Object?> get props => [items, hasReachedMax];
}
