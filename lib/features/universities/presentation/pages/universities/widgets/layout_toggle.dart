import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/core/theme/app_colors.dart';
import 'package:universities_app/core/theme/app_radius.dart';
import 'package:universities_app/core/theme/app_sizes.dart';
import 'package:universities_app/core/theme/app_spacing.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/layout_cubit/layout_cubit.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/layout_cubit/list_layout.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class LayoutToggle extends StatelessWidget {
  const LayoutToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, ListLayout>(
      builder: (context, layout) => _LayoutToggleSegments(layout: layout),
    );
  }
}

class _LayoutToggleSegments extends StatelessWidget {
  const _LayoutToggleSegments({required this.layout});

  final ListLayout layout;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Material(
      color: AppColors.segmentedBackground,
      borderRadius: BorderRadius.circular(AppRadius.control),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LayoutToggleOption(
              target: ListLayout.list,
              current: layout,
              icon: Icons.view_list,
              label: l10n.viewAsList,
            ),
            const SizedBox(width: AppSpacing.xs),
            _LayoutToggleOption(
              target: ListLayout.grid,
              current: layout,
              icon: Icons.grid_view,
              label: l10n.viewAsGrid,
            ),
          ],
        ),
      ),
    );
  }
}

class _LayoutToggleOption extends StatelessWidget {
  const _LayoutToggleOption({
    required this.target,
    required this.current,
    required this.icon,
    required this.label,
  });

  final ListLayout target;
  final ListLayout current;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return LayoutToggleButton(
      icon: icon,
      selected: current == target,
      tooltip: label,
      semanticLabel: label,
      onPressed: () {
        if (current != target) {
          context.read<LayoutCubit>().toggle();
        }
      },
    );
  }
}

class LayoutToggleButton extends StatelessWidget {
  const LayoutToggleButton({
    required this.icon,
    required this.selected,
    required this.tooltip,
    required this.semanticLabel,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final bool selected;
  final String tooltip;
  final String semanticLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppRadius.segmentedItem);
    return Semantics(
      button: true,
      label: semanticLabel,
      selected: selected,
      child: Tooltip(
        message: tooltip,
        child: Ink(
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.transparent,
            borderRadius: borderRadius,
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: borderRadius,
            child: SizedBox(
              width: AppSizes.layoutToggleButton,
              height: AppSizes.layoutToggleButton,
              child: Icon(
                icon,
                size: AppSizes.iconMd,
                color: selected ? AppColors.onPrimary : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
