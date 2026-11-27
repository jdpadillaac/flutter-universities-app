import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/domain/entities/image_origin.dart';
import 'package:universities_app/features/universities/presentation/widgets/image_source_sheet.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('shows camera and gallery options', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: ImageSourceSheet()),
      ),
    );

    expect(find.text('Cámara'), findsOneWidget);
    expect(find.text('Galería'), findsOneWidget);
  });

  testWidgets('returns ImageOrigin.camera when camera is tapped', (
    tester,
  ) async {
    ImageOrigin? selected;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  selected = await ImageSourceSheet.show(context);
                },
                child: const Text('open'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cámara'));
    await tester.pumpAndSettle();

    expect(selected, ImageOrigin.camera);
  });

  testWidgets('returns ImageOrigin.gallery when gallery is tapped', (
    tester,
  ) async {
    ImageOrigin? selected;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  selected = await ImageSourceSheet.show(context);
                },
                child: const Text('open'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Galería'));
    await tester.pumpAndSettle();

    expect(selected, ImageOrigin.gallery);
  });
}
