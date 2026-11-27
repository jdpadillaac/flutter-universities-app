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

class UniversitiesListPage extends StatelessWidget {
  const UniversitiesListPage({super.key});

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
      ],
      child: const UniversitiesListBody(),
    );
  }
}

class UniversitiesListBody extends StatelessWidget {
  const UniversitiesListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(UniversitiesListPage.title),
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
            UniversitiesLoaded() => _LoadedUniversitiesBody(state: state),
            UniversitiesFailure() => _FailureUniversitiesBody(state: state),
          };
        },
      ),
    );
  }
}

class _LoadedUniversitiesBody extends StatelessWidget {
  const _LoadedUniversitiesBody({required this.state});

  final UniversitiesLoaded state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, ListLayout>(
      builder: (context, layout) {
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            return _UniversitiesScrollTrigger.handle(notification, context);
          },
          child: _UniversitiesCatalogView(
            items: state.items,
            layout: layout,
            footer: state.isLoadingMore
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : null,
          ),
        );
      },
    );
  }
}

class _FailureUniversitiesBody extends StatelessWidget {
  const _FailureUniversitiesBody({required this.state});

  final UniversitiesFailure state;

  @override
  Widget build(BuildContext context) {
    if (state.items.isEmpty) {
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
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return BlocBuilder<LayoutCubit, ListLayout>(
      builder: (context, layout) {
        return Column(
          children: [
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  return _UniversitiesScrollTrigger.handle(
                    notification,
                    context,
                  );
                },
                child: _UniversitiesCatalogView(
                  items: state.items,
                  layout: layout,
                ),
              ),
            ),
            Material(
              color: Theme.of(context).colorScheme.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(child: Text(state.failure.message)),
                    TextButton(
                      onPressed: () => context.read<UniversitiesBloc>().add(
                        const UniversitiesRetryRequested(),
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _UniversitiesScrollTrigger {
  const _UniversitiesScrollTrigger._();

  static bool handle(ScrollNotification notification, BuildContext context) {
    if (notification.metrics.maxScrollExtent <= 0) {
      return false;
    }
    if (!notification.metrics.outOfRange &&
        notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 48) {
      context.read<UniversitiesBloc>().add(
        const UniversitiesNextPageRequested(),
      );
    }
    return false;
  }
}

class _UniversitiesCatalogView extends StatelessWidget {
  const _UniversitiesCatalogView({
    required this.items,
    required this.layout,
    this.footer,
  });

  final List<University> items;
  final ListLayout layout;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return switch (layout) {
      ListLayout.list => ListView.separated(
        itemCount: items.length + (footer == null ? 0 : 1),
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          if (index >= items.length) {
            return footer!;
          }
          return _UniversityListTile(university: items[index]);
        },
      ),
      ListLayout.grid => GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: items.length + (footer == null ? 0 : 1),
        itemBuilder: (context, index) {
          if (index >= items.length) {
            return footer!;
          }
          return _UniversityGridTile(university: items[index]);
        },
      ),
    };
  }
}

class _UniversityListTile extends StatelessWidget {
  const _UniversityListTile({required this.university});

  final University university;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(university.name),
      onTap: () => context.push(AppRoutes.universityDetailPath(university.id)),
    );
  }
}

class _UniversityGridTile extends StatelessWidget {
  const _UniversityGridTile({required this.university});

  final University university;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () =>
            context.push(AppRoutes.universityDetailPath(university.id)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              university.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
