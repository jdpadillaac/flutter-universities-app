import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/widgets/university_avatar.dart';

void main() {
  testWidgets('shows initials when image path is missing', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: UniversityAvatar(initials: 'MU', size: 44)),
      ),
    );

    expect(find.text('MU'), findsOneWidget);
  });

  testWidgets('renders an image widget when a path is present', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: UniversityAvatar(
            initials: 'MU',
            size: 44,
            imagePath: '/missing/university.jpg',
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(Image), findsOneWidget);
  });
}
