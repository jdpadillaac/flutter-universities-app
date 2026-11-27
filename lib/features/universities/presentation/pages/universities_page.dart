import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/core/di/injection.dart';
import 'package:universities_app/features/universities/presentation/bloc/layout_cubit.dart';
import 'package:universities_app/features/universities/presentation/bloc/universities_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/universities_event.dart';
import 'package:universities_app/features/universities/presentation/bloc/universities_state.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_thumbnails_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_thumbnails_event.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_thumbnails_state.dart';
import 'package:universities_app/features/universities/presentation/services/university_initials_resolver.dart';
import 'package:universities_app/features/universities/presentation/widgets/universities_header.dart';
import 'package:universities_app/features/universities/presentation/widgets/universities_scroll_view.dart';
import 'package:universities_app/features/universities/presentation/widgets/universities_status_views.dart';

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
                ..add(const UniversityThumbnailsSubscriptionRequested()),
        ),
      ],
      child: UniversitiesView(
        initialsResolver: getIt<UniversityInitialsResolver>(),
      ),
    );
  }
}

class UniversitiesView extends StatelessWidget {
  const UniversitiesView({required this.initialsResolver, super.key});

  final UniversityInitialsResolver initialsResolver;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UniversitiesHeader(),
            Expanded(
              child: BlocBuilder<UniversitiesBloc, UniversitiesState>(
                builder: (context, state) {
                  return switch (state) {
                    UniversitiesInitial() ||
                    UniversitiesLoading() => const UniversitiesLoadingState(),
                    UniversitiesLoaded(:final items) when items.isEmpty =>
                      const UniversitiesEmptyState(),
                    UniversitiesLoaded(:final items, :final isLoadingMore) =>
                      BlocBuilder<
                        UniversityThumbnailsBloc,
                        UniversityThumbnailsState
                      >(
                        builder: (context, thumbnails) {
                          return UniversitiesScrollView(
                            items: items,
                            imagePaths: thumbnails.imagePaths,
                            initialsResolver: initialsResolver,
                            showLoadMore: isLoadingMore,
                          );
                        },
                      ),
                    UniversitiesFailure(:final items, :final failure)
                        when items.isEmpty =>
                      UniversitiesFailureState(failure: failure),
                    UniversitiesFailure(:final items, :final failure) =>
                      BlocBuilder<
                        UniversityThumbnailsBloc,
                        UniversityThumbnailsState
                      >(
                        builder: (context, thumbnails) {
                          return Column(
                            children: [
                              Expanded(
                                child: UniversitiesScrollView(
                                  items: items,
                                  imagePaths: thumbnails.imagePaths,
                                  initialsResolver: initialsResolver,
                                ),
                              ),
                              UniversitiesInlineFailureBanner(failure: failure),
                            ],
                          );
                        },
                      ),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
