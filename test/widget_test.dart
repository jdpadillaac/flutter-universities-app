import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/app.dart';
import 'package:universities_app/core/di/injection.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/universities_page.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/services/university_id_generator.dart';
import 'package:universities_app/features/universities/domain/usecases/get_universities_page.dart';
import 'package:universities_app/features/universities/presentation/pages/universities_list_page.dart';

class MockGetUniversitiesPage extends Mock implements GetUniversitiesPage {}

class WidgetUniversityCatalog {
  const WidgetUniversityCatalog(this._ids);

  final UniversityIdGenerator _ids;

  University sample() {
    const name = 'Sample University';
    const domain = 'sample.edu';
    return University(
      id: _ids.buildId(name, domain),
      name: name,
      country: 'Country',
      countryCode: 'CO',
      domains: const [domain],
      webPages: const ['https://sample.edu'],
    );
  }
}

void main() {
  late MockGetUniversitiesPage getUniversitiesPage;
  const catalog = WidgetUniversityCatalog(UniversityIdGenerator());

  setUpAll(registerFallbackValues);

  setUp(() async {
    getUniversitiesPage = MockGetUniversitiesPage();
    configureDependencies();
    if (getIt.isRegistered<GetUniversitiesPage>()) {
      await getIt.unregister<GetUniversitiesPage>();
    }
    getIt.registerFactory<GetUniversitiesPage>(() => getUniversitiesPage);
    when(() => getUniversitiesPage(page: any(named: 'page'))).thenAnswer(
      (_) async => Ok<UniversitiesPage, Failure>(
        UniversitiesPage(items: [catalog.sample()], hasReachedMax: true),
      ),
    );
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('shows universities list page', (tester) async {
    await tester.pumpWidget(const UniversitiesApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text(UniversitiesListPage.title), findsOneWidget);
    expect(find.text('Sample University'), findsOneWidget);
  });

  testWidgets('toggles layout', (tester) async {
    await tester.pumpWidget(const UniversitiesApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(ListView), findsOneWidget);

    await tester.tap(find.byIcon(Icons.grid_view));
    await tester.pumpAndSettle();

    expect(find.byType(GridView), findsOneWidget);
  });

  testWidgets('opens university detail', (tester) async {
    await tester.pumpWidget(const UniversitiesApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.text('Sample University'));
    await tester.pumpAndSettle();

    final universityId = catalog.sample().id;
    expect(find.text('University id: $universityId'), findsOneWidget);
  });
}

void registerFallbackValues() {
  registerFallbackValue(0);
}
