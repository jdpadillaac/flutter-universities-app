import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:universities_app/core/router/app_routes.dart';
import 'package:universities_app/core/theme/app_colors.dart';
import 'package:universities_app/core/theme/app_radius.dart';
import 'package:universities_app/core/theme/app_sizes.dart';
import 'package:universities_app/core/theme/app_spacing.dart';
import 'package:universities_app/features/universities/domain/config/universities_list_config.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/layout_cubit/layout_cubit.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/layout_cubit/list_layout.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_bloc.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_event.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/university_initials_resolver.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/widgets/load_more_indicator.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/widgets/university_grid_card.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/widgets/university_list_tile.dart';

class UniversitiesScrollView extends StatefulWidget {
  const UniversitiesScrollView({
    required this.items,
    required this.imagePaths,
    required this.initialsResolver,
    this.showLoadMore = false,
    super.key,
  });

  final List<University> items;
  final Map<String, String> imagePaths;
  final UniversityInitialsResolver initialsResolver;
  final bool showLoadMore;

  @override
  State<UniversitiesScrollView> createState() => UniversitiesScrollViewState();
}

class UniversitiesScrollViewState extends State<UniversitiesScrollView> {
  static const double _loadMoreThreshold =
      UniversitiesListConfig.loadMoreThreshold;

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

  void _openDetail(University university) {
    unawaited(context.push(AppRoutes.universityDetailPath(university.id)));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        _UniversitiesLayoutSliver(
          items: widget.items,
          imagePaths: widget.imagePaths,
          initialsResolver: widget.initialsResolver,
          onOpenDetail: _openDetail,
        ),
        if (widget.showLoadMore)
          const SliverToBoxAdapter(child: LoadMoreIndicator()),
      ],
    );
  }
}

class _UniversitiesLayoutSliver extends StatelessWidget {
  const _UniversitiesLayoutSliver({
    required this.items,
    required this.imagePaths,
    required this.initialsResolver,
    required this.onOpenDetail,
  });

  final List<University> items;
  final Map<String, String> imagePaths;
  final UniversityInitialsResolver initialsResolver;
  final void Function(University university) onOpenDetail;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, ListLayout>(
      builder: (context, layout) => switch (layout) {
        ListLayout.list => UniversitiesListSliver(
          items: items,
          imagePaths: imagePaths,
          initialsResolver: initialsResolver,
          onOpenDetail: onOpenDetail,
        ),
        ListLayout.grid => UniversitiesGridSliver(
          items: items,
          imagePaths: imagePaths,
          initialsResolver: initialsResolver,
          onOpenDetail: onOpenDetail,
        ),
      },
    );
  }
}

class UniversitiesListSliver extends StatelessWidget {
  const UniversitiesListSliver({
    required this.items,
    required this.imagePaths,
    required this.initialsResolver,
    required this.onOpenDetail,
    super.key,
  });

  final List<University> items;
  final Map<String, String> imagePaths;
  final UniversityInitialsResolver initialsResolver;
  final void Function(University university) onOpenDetail;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      sliver: DecoratedSliver(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        sliver: SliverList.separated(
          itemCount: items.length,
          separatorBuilder: (context, index) =>
              const _UniversitiesListDivider(),
          itemBuilder: (context, index) => UniversityListTile(
            university: items[index],
            imagePath: imagePaths[items[index].id],
            initials: initialsResolver.resolve(items[index].name),
            onTap: () => onOpenDetail(items[index]),
          ),
        ),
      ),
    );
  }
}

class _UniversitiesListDivider extends StatelessWidget {
  const _UniversitiesListDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: AppSizes.dividerThickness,
      color: AppColors.divider,
    );
  }
}

class UniversitiesGridSliver extends StatelessWidget {
  const UniversitiesGridSliver({
    required this.items,
    required this.imagePaths,
    required this.initialsResolver,
    required this.onOpenDetail,
    super.key,
  });

  final List<University> items;
  final Map<String, String> imagePaths;
  final UniversityInitialsResolver initialsResolver;
  final void Function(University university) onOpenDetail;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          mainAxisExtent: AppSizes.gridItemExtent,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => UniversityGridCard(
            university: items[index],
            imagePath: imagePaths[items[index].id],
            initials: initialsResolver.resolve(items[index].name),
            onTap: () => onOpenDetail(items[index]),
          ),
          childCount: items.length,
        ),
      ),
    );
  }
}
