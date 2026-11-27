import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:universities_app/core/theme/app_sizes.dart';
import 'package:universities_app/core/theme/app_typography.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class UniversityDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const UniversityDetailAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const _UniversityDetailBackButton(),
      title: Text(
        AppLocalizations.of(context).detailTitle,
        style: AppTypography.appBarTitle,
      ),
    );
  }
}

class _UniversityDetailBackButton extends StatelessWidget {
  const _UniversityDetailBackButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Semantics(
      button: true,
      label: l10n.backTooltip,
      child: Tooltip(
        message: l10n.backTooltip,
        child: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
          iconSize: AppSizes.appBarIcon,
          constraints: const BoxConstraints(
            minWidth: AppSizes.appBarBackButton,
            minHeight: AppSizes.appBarBackButton,
          ),
        ),
      ),
    );
  }
}
