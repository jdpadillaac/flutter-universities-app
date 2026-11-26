import 'package:flutter/material.dart';
import 'package:universities_app/app.dart';
import 'package:universities_app/core/di/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const UniversitiesApp());
}
