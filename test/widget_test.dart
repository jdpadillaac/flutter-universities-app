import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/app.dart';
import 'package:universities_app/core/di/injection.dart';
import 'package:universities_app/features/universities/presentation/pages/universities_list_page.dart';

void main() {
  setUp(configureDependencies);

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('shows universities list page', (tester) async {
    await tester.pumpWidget(const UniversitiesApp());
    await tester.pumpAndSettle();

    expect(find.text(UniversitiesListPage.title), findsOneWidget);
  });
}
