import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_state.dart';

void main() {
  const university = University(
    id: 'id',
    name: 'Name',
    country: 'Country',
    countryCode: 'CO',
    domains: ['example.edu'],
    webPages: ['https://example.edu'],
  );

  test('UniversitiesLoaded copyWith overrides selected fields', () {
    const state = UniversitiesLoaded(items: [university], hasReachedMax: false);

    final updated = state.copyWith(isLoadingMore: true, hasReachedMax: true);

    expect(updated.isLoadingMore, isTrue);
    expect(updated.hasReachedMax, isTrue);
    expect(updated.items, [university]);
  });

  test('UniversitiesFailure exposes failure and items', () {
    const failure = NetworkFailure(message: 'down');
    const state = UniversitiesFailure(
      failure: failure,
      items: [university],
      hasReachedMax: false,
    );

    expect(state.failure, failure);
    expect(state.items, [university]);
    expect(state.props, [
      failure,
      [university],
      false,
    ]);
  });
}
