import 'package:flutter/material.dart';
import 'package:universities_app/core/theme/app_sizes.dart';
import 'package:universities_app/core/theme/app_spacing.dart';
import 'package:universities_app/core/theme/app_typography.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_state.dart';
import 'package:universities_app/features/universities/presentation/widgets/student_count_card.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_country_chip.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_image_picker.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_info_card.dart';

class UniversityDetailContent extends StatelessWidget {
  const UniversityDetailContent({required this.state, super.key});

  final UniversityDetailLoaded state;

  @override
  Widget build(BuildContext context) {
    final university = state.university;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UniversityImagePicker(imagePath: state.imagePath),
          const SizedBox(height: AppSizes.detailContentGap),
          _UniversityDetailTitle(name: university.name),
          const SizedBox(height: AppSpacing.sm),
          UniversityCountryChip(
            countryCode: university.countryCode,
            country: university.country,
          ),
          const SizedBox(height: AppSizes.detailContentGap),
          UniversityInfoCard(university: university),
          const SizedBox(height: AppSizes.detailContentGap),
          StudentCountCard(state: state),
        ],
      ),
    );
  }
}

class _UniversityDetailTitle extends StatelessWidget {
  const _UniversityDetailTitle({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(name, style: AppTypography.detailTitle);
  }
}
