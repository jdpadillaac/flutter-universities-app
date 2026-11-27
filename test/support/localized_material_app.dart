import 'package:flutter/material.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class LocalizedMaterialApp extends StatelessWidget {
  const LocalizedMaterialApp({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    );
  }
}
