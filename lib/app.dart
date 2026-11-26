import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:universities_app/core/di/injection.dart';
import 'package:universities_app/core/theme/app_theme.dart';

/// Root widget wiring theme and navigation.
class UniversitiesApp extends StatelessWidget {
  const UniversitiesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Universities',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: getIt<GoRouter>(),
    );
  }
}
