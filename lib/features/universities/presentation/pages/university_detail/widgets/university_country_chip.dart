import 'package:flutter/material.dart';
import 'package:universities_app/core/theme/app_colors.dart';
import 'package:universities_app/core/theme/app_radius.dart';
import 'package:universities_app/core/theme/app_sizes.dart';
import 'package:universities_app/core/theme/app_spacing.dart';
import 'package:universities_app/core/theme/app_typography.dart';

class UniversityCountryChip extends StatelessWidget {
  const UniversityCountryChip({
    required this.countryCode,
    required this.country,
    super.key,
  });

  final String countryCode;
  final String country;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.countryChipHorizontalPadding,
          vertical: AppSpacing.xs,
        ),
        child: Text('$countryCode · $country', style: AppTypography.chip),
      ),
    );
  }
}
