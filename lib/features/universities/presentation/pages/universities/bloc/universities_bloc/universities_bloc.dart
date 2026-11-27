import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/usecases/get_universities_page.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_event.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_state.dart';

@injectable
class UniversitiesBloc extends Bloc<UniversitiesEvent, UniversitiesState> {
  UniversitiesBloc(this._getUniversitiesPage)
    : super(const UniversitiesInitial()) {
    on<UniversitiesRequested>(_onUniversitiesRequested);
    on<UniversitiesNextPageRequested>(_onUniversitiesNextPageRequested);
    on<UniversitiesRetryRequested>(_onUniversitiesRetryRequested);
  }

  final GetUniversitiesPage _getUniversitiesPage;
  int _nextPageIndex = 0;

  Future<void> _onUniversitiesRequested(
    UniversitiesRequested event,
    Emitter<UniversitiesState> emit,
  ) async {
    _nextPageIndex = 0;
    emit(const UniversitiesLoading());
    await _loadPage(emit, page: 0, appendTo: const []);
  }

  Future<void> _onUniversitiesNextPageRequested(
    UniversitiesNextPageRequested event,
    Emitter<UniversitiesState> emit,
  ) async {
    final current = state;
    if (current is! UniversitiesLoaded) {
      return;
    }
    if (current.isLoadingMore || current.hasReachedMax) {
      return;
    }

    emit(current.copyWith(isLoadingMore: true));
    await _loadPage(
      emit,
      page: _nextPageIndex,
      appendTo: current.items,
      hasReachedMaxBefore: current.hasReachedMax,
    );
  }

  Future<void> _onUniversitiesRetryRequested(
    UniversitiesRetryRequested event,
    Emitter<UniversitiesState> emit,
  ) async {
    final current = state;
    if (current is! UniversitiesFailure) {
      return;
    }

    if (current.items.isEmpty) {
      _nextPageIndex = 0;
      emit(const UniversitiesLoading());
      await _loadPage(emit, page: 0, appendTo: const []);
      return;
    }

    emit(
      UniversitiesLoaded(
        items: current.items,
        hasReachedMax: current.hasReachedMax,
        isLoadingMore: true,
      ),
    );
    await _loadPage(
      emit,
      page: _nextPageIndex,
      appendTo: current.items,
      hasReachedMaxBefore: current.hasReachedMax,
    );
  }

  Future<void> _loadPage(
    Emitter<UniversitiesState> emit, {
    required int page,
    required List<University> appendTo,
    bool hasReachedMaxBefore = false,
  }) async {
    final result = await _getUniversitiesPage(page: page);

    switch (result) {
      case Ok(value: final universitiesPage):
        final merged = [...appendTo, ...universitiesPage.items];
        _nextPageIndex = page + 1;
        emit(
          UniversitiesLoaded(
            items: merged,
            hasReachedMax: universitiesPage.hasReachedMax,
          ),
        );
      case Err(error: final failure):
        if (appendTo.isEmpty) {
          emit(
            UniversitiesFailure(
              failure: failure,
              items: const [],
              hasReachedMax: false,
            ),
          );
        } else {
          emit(
            UniversitiesFailure(
              failure: failure,
              items: List.of(appendTo),
              hasReachedMax: hasReachedMaxBefore,
            ),
          );
        }
    }
  }
}
