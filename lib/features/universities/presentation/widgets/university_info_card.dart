import 'package:flutter/material.dart';
import 'package:universities_app/core/theme/app_colors.dart';
import 'package:universities_app/core/theme/app_spacing.dart';
import 'package:universities_app/core/theme/app_typography.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/presentation/utils/website_display.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class UniversityInfoCard extends StatelessWidget {
  const UniversityInfoCard({required this.university, super.key});

  final University university;

  static const WebsiteDisplay _websiteDisplay = WebsiteDisplay();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          children: [
            UniversityInfoRow(
              label: l10n.stateProvinceLabel,
              value: UniversityProvinceValue(
                stateProvince: university.stateProvince,
                notAvailable: l10n.notAvailable,
              ),
            ),
            const Divider(height: 1, color: AppColors.divider),
            UniversityInfoRow(
              label: l10n.domainLabel,
              value: UniversityDomainValue(domains: university.domains),
            ),
            const Divider(height: 1, color: AppColors.divider),
            UniversityInfoRow(
              label: l10n.websiteLabel,
              value: UniversityWebsiteValue(
                webPages: university.webPages,
                formatter: _websiteDisplay,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UniversityInfoRow extends StatelessWidget {
  const UniversityInfoRow({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.xs),
          value,
        ],
      ),
    );
  }
}

class UniversityProvinceValue extends StatelessWidget {
  const UniversityProvinceValue({
    required this.stateProvince,
    required this.notAvailable,
    super.key,
  });

  final String? stateProvince;
  final String notAvailable;

  @override
  Widget build(BuildContext context) {
    final value = stateProvince;
    if (value == null || value.isEmpty) {
      return Text(
        notAvailable,
        style: AppTypography.bodyStrong.copyWith(
          color: AppColors.textTertiary,
          fontStyle: FontStyle.italic,
        ),
      );
    }
    return Text(value, style: AppTypography.bodyStrong);
  }
}

class UniversityDomainValue extends StatelessWidget {
  const UniversityDomainValue({required this.domains, super.key});

  final List<String> domains;

  @override
  Widget build(BuildContext context) {
    if (domains.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: domains
          .map((domain) => Text(domain, style: AppTypography.bodyStrong))
          .toList(),
    );
  }
}

class UniversityWebsiteValue extends StatelessWidget {
  const UniversityWebsiteValue({
    required this.webPages,
    required this.formatter,
    super.key,
  });

  final List<String> webPages;
  final WebsiteDisplay formatter;

  @override
  Widget build(BuildContext context) {
    if (webPages.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: webPages
          .map(
            (page) => Text(
              formatter.format(page),
              style: AppTypography.bodyStrong.copyWith(
                color: AppColors.primaryStrong,
              ),
            ),
          )
          .toList(),
    );
  }
}
