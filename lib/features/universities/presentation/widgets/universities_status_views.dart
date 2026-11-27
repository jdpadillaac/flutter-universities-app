import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/core/theme/app_colors.dart';
import 'package:universities_app/core/theme/app_sizes.dart';
import 'package:universities_app/core/theme/app_spacing.dart';
import 'package:universities_app/core/theme/app_typography.dart';
import 'package:universities_app/features/universities/presentation/bloc/universities_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/universities_event.dart';
import 'package:universities_app/features/universities/presentation/l10n/failure_message_resolver.dart';
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
    final message = failureMessageResolver.resolve(failure, l10n);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.icon,
              size: AppSizes.iconXl,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              style: AppTypography.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
              onPressed: () => context.read<UniversitiesBloc>().add(
                const UniversitiesRetryRequested(),
              ),
              child: Text(l10n.retry),
            ),
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
    final message = failureMessageResolver.resolve(failure, l10n);
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Expanded(child: Text(message, style: AppTypography.caption)),
            TextButton(
              onPressed: () => context.read<UniversitiesBloc>().add(
                const UniversitiesRetryRequested(),
              ),
              child: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
