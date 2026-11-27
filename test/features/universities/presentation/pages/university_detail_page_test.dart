import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_state.dart';
import 'package:universities_app/features/universities/presentation/pages/university_detail_page.dart';

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
    when(() => bloc.state).thenReturn(
      const UniversityDetailState(
        status: UniversityDetailStatus.ready,
        university: university,
      ),
    );
    when(() => bloc.stream).thenAnswer(
      (_) => Stream.value(
        const UniversityDetailState(
          status: UniversityDetailStatus.ready,
          university: university,
        ),
      ),
    );
    when(() => bloc.close()).thenAnswer((_) async {});
  });

  Widget buildHarness(UniversityDetailState state) {
    when(() => bloc.state).thenReturn(state);
    return MaterialApp(
      home: BlocProvider<UniversityDetailBloc>.value(
        value: bloc,
        child: const UniversityDetailView(),
      ),
    );
  }

  testWidgets('shows No disponible when state province is missing', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildHarness(
        const UniversityDetailState(
          status: UniversityDetailStatus.ready,
          university: university,
        ),
      ),
    );

    expect(find.textContaining('No disponible'), findsOneWidget);
  });

  testWidgets('does not show validation error before interaction', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildHarness(
        const UniversityDetailState(
          status: UniversityDetailStatus.ready,
          university: university,
          studentsInput: '0',
        ),
      ),
    );

    expect(find.text('El valor debe ser mayor que cero.'), findsNothing);
  });

  testWidgets('opens image source bottom sheet', (tester) async {
    await tester.pumpWidget(
      buildHarness(
        const UniversityDetailState(
          status: UniversityDetailStatus.ready,
          university: university,
        ),
      ),
    );

    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle();

    expect(find.text('Cámara'), findsOneWidget);
    expect(find.text('Galería'), findsOneWidget);
  });

  testWidgets('shows validation error and disables save after interaction', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildHarness(
        const UniversityDetailState(
          status: UniversityDetailStatus.ready,
          university: university,
          studentsInput: '0',
          studentsTouched: true,
          validationError: StudentCountError.mustBePositive,
        ),
      ),
    );

    expect(find.text('El valor debe ser mayor que cero.'), findsOneWidget);
    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);
  });
}
