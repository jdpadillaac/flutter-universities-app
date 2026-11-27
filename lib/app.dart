import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:universities_app/core/di/injection.dart';
import 'package:universities_app/core/theme/app_theme.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class UniversitiesApp extends StatelessWidget {
  const UniversitiesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = getIt<AppTheme>();
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      locale: const Locale('es'),
      theme: theme.light,
      themeMode: ThemeMode.light,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: getIt<GoRouter>(),
    );
  }
}
