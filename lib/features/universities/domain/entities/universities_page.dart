import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';

part 'universities_page.freezed.dart';

/// One local page of [University] items.
@freezed
abstract class UniversitiesPage with _$UniversitiesPage {
  /// Creates a page.
  const factory UniversitiesPage({
    required List<University> items,
    required bool hasReachedMax,
  }) = _UniversitiesPage;
}
