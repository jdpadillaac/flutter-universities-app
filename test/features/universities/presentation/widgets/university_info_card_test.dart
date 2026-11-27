import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_info_card.dart';
import '../../../../support/localized_material_app.dart';

void main() {
  testWidgets('shows formatted websites and province when present', (
    tester,
  ) async {
    const university = University(
      id: 'id',
      name: 'School',
      country: 'United States',
      countryCode: 'US',
      domains: ['school.edu'],
      webPages: ['https://school.edu/'],
      stateProvince: 'California',
    );

    await tester.pumpWidget(
      LocalizedMaterialApp(
        child: const Scaffold(body: UniversityInfoCard(university: university)),
      ),
    );

    expect(find.text('California'), findsOneWidget);
    expect(find.text('school.edu'), findsWidgets);
  });
}
