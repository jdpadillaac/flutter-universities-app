import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_thumbnail.dart';

void main() {
  testWidgets('shows fallback icon when image path is missing', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UniversityThumbnail())),
    );

    expect(find.byIcon(Icons.school_outlined), findsOneWidget);
  });

  testWidgets('renders an image widget when a path is present', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: UniversityThumbnail(imagePath: '/missing/university.jpg'),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(Image), findsOneWidget);
  });
}
