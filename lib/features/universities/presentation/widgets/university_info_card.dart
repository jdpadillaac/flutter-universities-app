import 'package:flutter/material.dart';
import 'package:universities_app/core/theme/app_colors.dart';
import 'package:universities_app/core/theme/app_sizes.dart';
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
            const _UniversityInfoDivider(),
            UniversityInfoRow(
              label: l10n.domainLabel,
              value: UniversityDomainValue(domains: university.domains),
            ),
            const _UniversityInfoDivider(),
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
          _UniversityInfoLabel(label: label),
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
      return _UniversityNotAvailableText(text: notAvailable);
    }
    return _UniversityInfoValueText(text: value);
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
      children: [
        for (final domain in domains) _UniversityInfoValueText(text: domain),
      ],
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
      children: [
        for (final page in webPages)
          _UniversityWebsiteText(text: formatter.format(page)),
      ],
    );
  }
}

class _UniversityInfoDivider extends StatelessWidget {
  const _UniversityInfoDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: AppSizes.dividerThickness,
      color: AppColors.divider,
    );
  }
}

class _UniversityInfoLabel extends StatelessWidget {
  const _UniversityInfoLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTypography.body.copyWith(color: AppColors.textSecondary),
    );
  }
}

class _UniversityInfoValueText extends StatelessWidget {
  const _UniversityInfoValueText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTypography.bodyStrong);
  }
}

class _UniversityNotAvailableText extends StatelessWidget {
  const _UniversityNotAvailableText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.bodyStrong.copyWith(
        color: AppColors.textTertiary,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}

class _UniversityWebsiteText extends StatelessWidget {
  const _UniversityWebsiteText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.bodyStrong.copyWith(color: AppColors.primaryStrong),
    );
  }
}
