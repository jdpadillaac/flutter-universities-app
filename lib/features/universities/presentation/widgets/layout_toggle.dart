import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/core/theme/app_colors.dart';
import 'package:universities_app/core/theme/app_radius.dart';
import 'package:universities_app/core/theme/app_sizes.dart';
import 'package:universities_app/core/theme/app_spacing.dart';
import 'package:universities_app/features/universities/presentation/bloc/layout_cubit.dart';
import 'package:universities_app/features/universities/presentation/bloc/list_layout.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class LayoutToggle extends StatelessWidget {
  const LayoutToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<LayoutCubit, ListLayout>(
      builder: (context, layout) {
        return Container(
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: BoxDecoration(
            color: AppColors.segmentedBackground,
            borderRadius: BorderRadius.circular(AppRadius.control),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LayoutToggleButton(
                icon: Icons.view_list,
                selected: layout == ListLayout.list,
                tooltip: l10n.viewAsList,
                semanticLabel: l10n.viewAsList,
                onPressed: () {
                  if (layout != ListLayout.list) {
                    context.read<LayoutCubit>().toggle();
                  }
                },
              ),
              const SizedBox(width: AppSpacing.xs),
              LayoutToggleButton(
                icon: Icons.grid_view,
                selected: layout == ListLayout.grid,
                tooltip: l10n.viewAsGrid,
                semanticLabel: l10n.viewAsGrid,
                onPressed: () {
                  if (layout != ListLayout.grid) {
                    context.read<LayoutCubit>().toggle();
                  }
                },
              ),
            ],
          ),
        );
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
    final background = selected ? AppColors.primary : Colors.transparent;
    final iconColor = selected ? AppColors.onPrimary : AppColors.textSecondary;
    return Semantics(
      button: true,
      label: semanticLabel,
      selected: selected,
      child: Tooltip(
        message: tooltip,
        child: Material(
          color: background,
          borderRadius: BorderRadius.circular(AppRadius.segmentedItem),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(AppRadius.segmentedItem),
            child: SizedBox(
              width: AppSizes.layoutToggleButton,
              height: AppSizes.layoutToggleButton,
              child: Icon(icon, size: 20, color: iconColor),
            ),
          ),
        ),
      ),
    );
  }
}
