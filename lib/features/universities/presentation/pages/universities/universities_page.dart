import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/core/di/injection.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/layout_cubit/layout_cubit.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_bloc.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_event.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_state.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/university_thumbnails_bloc/university_thumbnails_bloc.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/university_thumbnails_bloc/university_thumbnails_event.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/university_thumbnails_bloc/university_thumbnails_state.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/widgets/universities_header.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/widgets/universities_scroll_view.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/widgets/universities_status_views.dart';

class UniversitiesPage extends StatelessWidget {
  const UniversitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<UniversitiesBloc>()..add(const UniversitiesRequested()),
        ),
        BlocProvider(create: (_) => getIt<LayoutCubit>()),
        BlocProvider(
          create: (_) =>
              getIt<UniversityThumbnailsBloc>()
                ..add(const UniversityThumbnailsRequested()),
        ),
      ],
      child: const UniversitiesView(),
    );
  }
}

class UniversitiesView extends StatelessWidget {
  const UniversitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            UniversitiesHeader(),
            Expanded(child: _UniversitiesBody()),
          ],
        ),
      ),
    );
  }
}

class _UniversitiesBody extends StatelessWidget {
  const _UniversitiesBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UniversitiesBloc, UniversitiesState>(
      builder: (context, state) => switch (state) {
        UniversitiesInitial() ||
        UniversitiesLoading() => const UniversitiesLoadingState(),
        UniversitiesLoaded(:final items) when items.isEmpty =>
          const UniversitiesEmptyState(),
        UniversitiesLoaded(:final items, :final isLoadingMore) =>
          _UniversitiesThumbnailsScrollView(
            items: items,
            showLoadMore: isLoadingMore,
          ),
        UniversitiesFailure(:final items, :final failure) when items.isEmpty =>
          UniversitiesFailureState(failure: failure),
        UniversitiesFailure(:final items, :final failure) =>
          _UniversitiesListWithFailure(items: items, failure: failure),
      },
    );
  }
}

class _UniversitiesListWithFailure extends StatelessWidget {
  const _UniversitiesListWithFailure({
    required this.items,
    required this.failure,
  });

  final List<University> items;
  final Failure failure;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _UniversitiesThumbnailsScrollView(items: items)),
        UniversitiesInlineFailureBanner(failure: failure),
      ],
    );
  }
}

class _UniversitiesThumbnailsScrollView extends StatelessWidget {
  const _UniversitiesThumbnailsScrollView({
    required this.items,
    this.showLoadMore = false,
  });

  final List<University> items;
  final bool showLoadMore;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UniversityThumbnailsBloc, UniversityThumbnailsState>(
      builder: (context, thumbnails) => UniversitiesScrollView(
        items: items,
        imagePaths: switch (thumbnails) {
          UniversityThumbnailsLoaded(:final imagePaths) => imagePaths,
          UniversityThumbnailsInitial() => const <String, String>{},
        },
        showLoadMore: showLoadMore,
      ),
    );
  }
}
