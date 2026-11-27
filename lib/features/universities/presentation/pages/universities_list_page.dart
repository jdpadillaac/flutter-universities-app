import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:universities_app/core/router/app_routes.dart';

class UniversitiesListPage extends StatelessWidget {
  const UniversitiesListPage({super.key});

  static const String title = 'Universities';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      body: Center(
        child: FilledButton(
          onPressed: () =>
              context.push(AppRoutes.universityDetailPath('sample')),
          child: const Text('Open sample detail'),
        ),
      ),
    );
  }
}
