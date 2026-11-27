import 'package:flutter/material.dart';
import 'package:universities_app/core/theme/app_colors.dart';
import 'package:universities_app/core/theme/app_sizes.dart';
import 'package:universities_app/core/theme/app_spacing.dart';
import 'package:universities_app/core/theme/app_typography.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class LoadMoreIndicator extends StatelessWidget {
  const LoadMoreIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _LoadMoreSpinner(),
            const SizedBox(width: AppSpacing.sm),
            Text(
              AppLocalizations.of(context).loadingMore,
              style: AppTypography.caption,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadMoreSpinner extends StatelessWidget {
  const _LoadMoreSpinner();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: AppSizes.loadMoreIndicator,
      height: AppSizes.loadMoreIndicator,
      child: CircularProgressIndicator(
        strokeWidth: AppSizes.loadMoreStroke,
        color: AppColors.primary,
      ),
    );
  }
}
