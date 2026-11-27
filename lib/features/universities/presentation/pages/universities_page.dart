import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:universities_app/core/di/injection.dart';
import 'package:universities_app/core/router/app_routes.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/presentation/bloc/layout_cubit.dart';
import 'package:universities_app/features/universities/presentation/bloc/list_layout.dart';
import 'package:universities_app/features/universities/presentation/bloc/universities_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/universities_event.dart';
import 'package:universities_app/features/universities/presentation/bloc/universities_state.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_thumbnails_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_thumbnails_event.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_thumbnails_state.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_grid_card.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_list_tile.dart';

class UniversitiesPage extends StatelessWidget {
  const UniversitiesPage({super.key});

  static const String title = 'Universities';

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
      child: const UniversitiesView(),
    );
  }
}

class UniversitiesView extends StatelessWidget {
  const UniversitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(UniversitiesPage.title),
        actions: [
          BlocBuilder<LayoutCubit, ListLayout>(
            builder: (context, layout) {
              final icon = switch (layout) {
                ListLayout.list => Icons.grid_view,
                ListLayout.grid => Icons.view_list,
              };
              return IconButton(
                onPressed: context.read<LayoutCubit>().toggle,
                icon: Icon(icon),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<UniversitiesBloc, UniversitiesState>(
        builder: (context, state) {
          return switch (state) {
            UniversitiesInitial() || UniversitiesLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            UniversitiesLoaded(:final items) when items.isEmpty =>
              const _UniversitiesEmptyState(),
            UniversitiesLoaded() => _UniversitiesLoadedBody(state: state),
            UniversitiesFailure(:final items) when items.isEmpty =>
              _UniversitiesInitialFailureBody(state: state),
            UniversitiesFailure() => _UniversitiesFailureWithItemsBody(
              state: state,
            ),
          };
        },
      ),
    );
  }
}

class _UniversitiesEmptyState extends StatelessWidget {
  const _UniversitiesEmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No universities available.'));
  }
}

class _UniversitiesLoadedBody extends StatefulWidget {
  const _UniversitiesLoadedBody({required this.state});

  final UniversitiesLoaded state;

  @override
  State<_UniversitiesLoadedBody> createState() =>
      _UniversitiesLoadedBodyState();
}

class _UniversitiesLoadedBodyState extends State<_UniversitiesLoadedBody> {
  static const double _loadMoreThreshold = 200;

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }
    final position = _scrollController.position;
    if (position.extentAfter < _loadMoreThreshold) {
      context.read<UniversitiesBloc>().add(
        const UniversitiesNextPageRequested(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, ListLayout>(
      builder: (context, layout) {
        return BlocBuilder<UniversityThumbnailsBloc, UniversityThumbnailsState>(
          builder: (context, thumbnails) {
            return _UniversitiesCatalogView(
              controller: _scrollController,
              items: widget.state.items,
              layout: layout,
              imagePaths: thumbnails.imagePaths,
              footer: widget.state.isLoadingMore
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : null,
            );
          },
        );
      },
    );
  }
}

class _UniversitiesInitialFailureBody extends StatelessWidget {
  const _UniversitiesInitialFailureBody({required this.state});

  final UniversitiesFailure state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(state.failure.message),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => context.read<UniversitiesBloc>().add(
              const UniversitiesRetryRequested(),
            ),
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}

class _UniversitiesFailureWithItemsBody extends StatefulWidget {
  const _UniversitiesFailureWithItemsBody({required this.state});

  final UniversitiesFailure state;

  @override
  State<_UniversitiesFailureWithItemsBody> createState() =>
      _UniversitiesFailureWithItemsBodyState();
}

class _UniversitiesFailureWithItemsBodyState
    extends State<_UniversitiesFailureWithItemsBody> {
  static const double _loadMoreThreshold = 200;

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }
    final position = _scrollController.position;
    if (position.extentAfter < _loadMoreThreshold) {
      context.read<UniversitiesBloc>().add(
        const UniversitiesNextPageRequested(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, ListLayout>(
      builder: (context, layout) {
        return BlocBuilder<UniversityThumbnailsBloc, UniversityThumbnailsState>(
          builder: (context, thumbnails) {
            return Column(
              children: [
                Expanded(
                  child: _UniversitiesCatalogView(
                    controller: _scrollController,
                    items: widget.state.items,
                    layout: layout,
                    imagePaths: thumbnails.imagePaths,
                  ),
                ),
                Material(
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(child: Text(widget.state.failure.message)),
                        TextButton(
                          onPressed: () => context.read<UniversitiesBloc>().add(
                            const UniversitiesRetryRequested(),
                          ),
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _UniversitiesCatalogView extends StatelessWidget {
  const _UniversitiesCatalogView({
    required this.controller,
    required this.items,
    required this.layout,
    required this.imagePaths,
    this.footer,
  });

  final ScrollController controller;
  final List<University> items;
  final ListLayout layout;
  final Map<String, String> imagePaths;
  final Widget? footer;

  Future<void> _openDetail(BuildContext context, University university) {
    return context.push(AppRoutes.universityDetailPath(university.id));
  }

  @override
  Widget build(BuildContext context) {
    final extra = footer == null ? 0 : 1;
    return switch (layout) {
      ListLayout.list => ListView.separated(
        controller: controller,
        itemCount: items.length + extra,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          if (index >= items.length) {
            return footer!;
          }
          final university = items[index];
          return UniversityListTile(
            university: university,
            imagePath: imagePaths[university.id],
            onTap: () => _openDetail(context, university),
          );
        },
      ),
      ListLayout.grid => GridView.builder(
        controller: controller,
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: items.length + extra,
        itemBuilder: (context, index) {
          if (index >= items.length) {
            return footer!;
          }
          final university = items[index];
          return UniversityGridCard(
            university: university,
            imagePath: imagePaths[university.id],
            onTap: () => _openDetail(context, university),
          );
        },
      ),
    };
  }
}
