import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:universities_app/core/router/app_routes.dart';
import 'package:universities_app/core/theme/app_spacing.dart';
import 'package:universities_app/core/theme/app_typography.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class UniversityNotFoundView extends StatelessWidget {
  const UniversityNotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.universityNotFound,
              style: AppTypography.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(AppRoutes.list);
                }
              },
              child: Text(l10n.backToList),
            ),
          ],
        ),
      ),
    );
  }
}
