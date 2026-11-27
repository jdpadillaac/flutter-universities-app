import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_state.dart';
import 'package:universities_app/features/universities/presentation/l10n/failure_message_resolver.dart';
import 'package:universities_app/features/universities/presentation/pages/university_detail_page.dart';
import '../../../../support/localized_material_app.dart';

class MockUniversityDetailBloc extends Mock implements UniversityDetailBloc {}

void main() {
  const university = University(
    id: 'u-id',
    name: 'Sample University',
    country: 'Colombia',
    countryCode: 'CO',
    domains: ['sample.edu'],
    webPages: ['https://sample.edu'],
  );

  late MockUniversityDetailBloc bloc;

  setUp(() {
    bloc = MockUniversityDetailBloc();
    when(
      () => bloc.state,
    ).thenReturn(const UniversityDetailLoaded(university: university));
    when(() => bloc.stream).thenAnswer(
      (_) => Stream.value(const UniversityDetailLoaded(university: university)),
    );
    when(() => bloc.close()).thenAnswer((_) async {});
  });

  Widget buildHarness(UniversityDetailState state) {
    when(() => bloc.state).thenReturn(state);
    return LocalizedMaterialApp(
      child: BlocProvider<UniversityDetailBloc>.value(
        value: bloc,
        child: const UniversityDetailView(
          failureMessageResolver: FailureMessageResolver(),
        ),
      ),
    );
  }

  testWidgets(
    'shows country chip and No disponible when state province is missing',
    (tester) async {
      await tester.pumpWidget(
        buildHarness(const UniversityDetailLoaded(university: university)),
      );

      expect(find.text('CO · Colombia'), findsOneWidget);
      expect(find.textContaining('No disponible'), findsOneWidget);
    },
  );

  testWidgets('does not show validation error before interaction', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildHarness(
        const UniversityDetailLoaded(
          university: university,
          studentsInput: '0',
        ),
      ),
    );

    expect(find.text('El valor debe ser mayor que cero.'), findsNothing);
  });

  testWidgets('shows camera and gallery actions on image placeholder', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildHarness(const UniversityDetailLoaded(university: university)),
    );

    expect(find.text('Cámara'), findsOneWidget);
    expect(find.text('Galería'), findsOneWidget);
  });

  testWidgets('shows validation error and disables save after interaction', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildHarness(
        const UniversityDetailLoaded(
          university: university,
          studentsInput: '0',
          studentsTouched: true,
          validationError: StudentCountError.mustBePositive,
        ),
      ),
    );

    expect(find.text('El valor debe ser mayor que cero.'), findsOneWidget);
    final button = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Guardar'),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('shows back to list when university is not found', (
    tester,
  ) async {
    await tester.pumpWidget(buildHarness(UniversityDetailNotFound()));

    expect(find.text('No se encontró la universidad.'), findsOneWidget);
    expect(find.text('Volver a la lista'), findsOneWidget);
  });

  testWidgets('enables save with valid student count', (tester) async {
    await tester.pumpWidget(
      buildHarness(
        const UniversityDetailLoaded(
          university: university,
          studentsInput: '42',
          studentsTouched: true,
        ),
      ),
    );

    final saveButton = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Guardar'),
    );
    expect(saveButton.onPressed, isNotNull);
  });
}
