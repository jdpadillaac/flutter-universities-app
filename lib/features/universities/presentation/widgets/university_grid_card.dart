import 'package:flutter/material.dart';
import 'package:universities_app/core/theme/app_colors.dart';
import 'package:universities_app/core/theme/app_radius.dart';
import 'package:universities_app/core/theme/app_sizes.dart';
import 'package:universities_app/core/theme/app_spacing.dart';
import 'package:universities_app/core/theme/app_typography.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_avatar.dart';

class UniversityGridCard extends StatelessWidget {
  const UniversityGridCard({
    required this.university,
    required this.initials,
    required this.onTap,
    this.imagePath,
    super.key,
  });

  final University university;
  final String initials;
  final String? imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final domain = university.domains.isEmpty ? '' : university.domains.first;
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppSizes.gridCardMinHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UniversityAvatar(
                  initials: initials,
                  size: AppSizes.gridAvatar,
                  imagePath: imagePath,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(university.name, style: AppTypography.gridTitle),
                const Spacer(),
                if (domain.isNotEmpty)
                  Text(domain, style: AppTypography.gridDomain),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
