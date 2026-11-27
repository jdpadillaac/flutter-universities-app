import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/core/di/injection.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/presentation/helpers/failure_message_resolver.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/layout_cubit/layout_cubit.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_bloc.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_event.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_state.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/university_thumbnails_bloc/university_thumbnails_bloc.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/university_thumbnails_bloc/university_thumbnails_event.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/university_thumbnails_bloc/university_thumbnails_state.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/university_initials_resolver.dart';
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
      child: UniversitiesView(
        initialsResolver: getIt<UniversityInitialsResolver>(),
        failureMessageResolver: getIt<FailureMessageResolver>(),
      ),
    );
  }
}

class UniversitiesView extends StatelessWidget {
  const UniversitiesView({
    required this.initialsResolver,
    required this.failureMessageResolver,
    super.key,
  });

  final UniversityInitialsResolver initialsResolver;
  final FailureMessageResolver failureMessageResolver;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UniversitiesHeader(),
            Expanded(
              child: _UniversitiesBody(
                initialsResolver: initialsResolver,
                failureMessageResolver: failureMessageResolver,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UniversitiesBody extends StatelessWidget {
  const _UniversitiesBody({
    required this.initialsResolver,
    required this.failureMessageResolver,
  });

  final UniversityInitialsResolver initialsResolver;
  final FailureMessageResolver failureMessageResolver;

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
            initialsResolver: initialsResolver,
            showLoadMore: isLoadingMore,
          ),
        UniversitiesFailure(:final items, :final failure) when items.isEmpty =>
          UniversitiesFailureState(
            failure: failure,
            failureMessageResolver: failureMessageResolver,
          ),
        UniversitiesFailure(:final items, :final failure) =>
          _UniversitiesListWithFailure(
            items: items,
            failure: failure,
            initialsResolver: initialsResolver,
            failureMessageResolver: failureMessageResolver,
          ),
      },
    );
  }
}

class _UniversitiesListWithFailure extends StatelessWidget {
  const _UniversitiesListWithFailure({
    required this.items,
    required this.failure,
    required this.initialsResolver,
    required this.failureMessageResolver,
  });

  final List<University> items;
  final Failure failure;
  final UniversityInitialsResolver initialsResolver;
  final FailureMessageResolver failureMessageResolver;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _UniversitiesThumbnailsScrollView(
            items: items,
            initialsResolver: initialsResolver,
          ),
        ),
        UniversitiesInlineFailureBanner(
          failure: failure,
          failureMessageResolver: failureMessageResolver,
        ),
      ],
    );
  }
}

class _UniversitiesThumbnailsScrollView extends StatelessWidget {
  const _UniversitiesThumbnailsScrollView({
    required this.items,
    required this.initialsResolver,
    this.showLoadMore = false,
  });

  final List<University> items;
  final UniversityInitialsResolver initialsResolver;
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
        initialsResolver: initialsResolver,
        showLoadMore: showLoadMore,
      ),
    );
  }
}
