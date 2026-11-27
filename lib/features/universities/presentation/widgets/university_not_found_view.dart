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
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _UniversityNotFoundMessage(),
            SizedBox(height: AppSpacing.lg),
            _BackToListButton(),
          ],
        ),
      ),
    );
  }
}

class _UniversityNotFoundMessage extends StatelessWidget {
  const _UniversityNotFoundMessage();

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context).universityNotFound,
      style: AppTypography.body,
      textAlign: TextAlign.center,
    );
  }
}

class _BackToListButton extends StatelessWidget {
  const _BackToListButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        if (context.canPop()) {
          context.pop();
        } else {
          context.go(AppRoutes.list);
        }
      },
      child: Text(AppLocalizations.of(context).backToList),
    );
  }
}
