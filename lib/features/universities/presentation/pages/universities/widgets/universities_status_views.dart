import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/core/theme/app_colors.dart';
import 'package:universities_app/core/theme/app_sizes.dart';
import 'package:universities_app/core/theme/app_spacing.dart';
import 'package:universities_app/core/theme/app_typography.dart';
import 'package:universities_app/features/universities/presentation/helpers/failure_message_resolver.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_bloc.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_event.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class UniversitiesLoadingState extends StatelessWidget {
  const UniversitiesLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class UniversitiesEmptyState extends StatelessWidget {
  const UniversitiesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Text(
        l10n.emptyUniversities,
        style: AppTypography.body,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class UniversitiesFailureState extends StatelessWidget {
  const UniversitiesFailureState({
    required this.failure,
    required this.failureMessageResolver,
    super.key,
  });

  final Failure failure;
  final FailureMessageResolver failureMessageResolver;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _UniversitiesFailureIcon(),
            const SizedBox(height: AppSpacing.md),
            Text(
              failureMessageResolver.resolve(failure, l10n),
              style: AppTypography.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            const _UniversitiesRetryButton(),
          ],
        ),
      ),
    );
  }
}

class UniversitiesInlineFailureBanner extends StatelessWidget {
  const UniversitiesInlineFailureBanner({
    required this.failure,
    required this.failureMessageResolver,
    super.key,
  });

  final Failure failure;
  final FailureMessageResolver failureMessageResolver;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Expanded(
              child: Text(
                failureMessageResolver.resolve(failure, l10n),
                style: AppTypography.caption,
              ),
            ),
            const _UniversitiesInlineRetryButton(),
          ],
        ),
      ),
    );
  }
}

class _UniversitiesFailureIcon extends StatelessWidget {
  const _UniversitiesFailureIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.error_outline,
      color: AppColors.icon,
      size: AppSizes.iconXl,
    );
  }
}

class _UniversitiesRetryButton extends StatelessWidget {
  const _UniversitiesRetryButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => context.read<UniversitiesBloc>().add(
        const UniversitiesRetryRequested(),
      ),
      child: Text(AppLocalizations.of(context).retry),
    );
  }
}

class _UniversitiesInlineRetryButton extends StatelessWidget {
  const _UniversitiesInlineRetryButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<UniversitiesBloc>().add(
        const UniversitiesRetryRequested(),
      ),
      child: Text(AppLocalizations.of(context).retry),
    );
  }
}
