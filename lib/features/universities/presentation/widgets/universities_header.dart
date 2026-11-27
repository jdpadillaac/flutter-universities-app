import 'package:flutter/material.dart';
import 'package:universities_app/core/theme/app_colors.dart';
import 'package:universities_app/core/theme/app_spacing.dart';
import 'package:universities_app/core/theme/app_typography.dart';
import 'package:universities_app/features/universities/presentation/widgets/layout_toggle.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class UniversitiesHeader extends StatelessWidget {
  const UniversitiesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.unitedStatesCaption, style: AppTypography.caption),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.universitiesTitle,
                    style: AppTypography.screenTitle,
                  ),
                ],
              ),
            ),
            const LayoutToggle(),
          ],
        ),
      ),
    );
  }
}
