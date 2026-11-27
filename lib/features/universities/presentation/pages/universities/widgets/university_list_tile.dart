import 'package:flutter/material.dart';
import 'package:universities_app/core/theme/app_colors.dart';
import 'package:universities_app/core/theme/app_sizes.dart';
import 'package:universities_app/core/theme/app_spacing.dart';
import 'package:universities_app/core/theme/app_typography.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/widgets/university_avatar.dart';

class UniversityListTile extends StatelessWidget {
  const UniversityListTile({
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
    return Material(
      color: AppColors.surface,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: AppSizes.minTouchTarget),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.listTileVerticalPadding,
              horizontal: AppSpacing.lg,
            ),
            child: Row(
              children: [
                UniversityAvatar(
                  initials: initials,
                  size: AppSizes.listAvatar,
                  imagePath: imagePath,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _UniversityListTileTexts(university: university),
                ),
                const _UniversityListTileChevron(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UniversityListTileTexts extends StatelessWidget {
  const _UniversityListTileTexts({required this.university});

  final University university;

  @override
  Widget build(BuildContext context) {
    final domain = university.domains.isEmpty ? '' : university.domains.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          university.name,
          style: AppTypography.itemTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (domain.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(domain, style: AppTypography.caption),
        ],
      ],
    );
  }
}

class _UniversityListTileChevron extends StatelessWidget {
  const _UniversityListTileChevron();

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.chevron_right, color: AppColors.icon);
  }
}
