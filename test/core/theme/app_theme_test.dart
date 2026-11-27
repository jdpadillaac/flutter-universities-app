import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universities_app/core/theme/app_colors.dart';
import 'package:universities_app/core/theme/app_sizes.dart';
import 'package:universities_app/core/theme/app_theme.dart';
import 'package:universities_app/core/theme/app_typography.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('light theme uses design tokens', (tester) async {
    await tester.pumpWidget(
      MaterialApp(theme: const AppTheme().light, home: const SizedBox.shrink()),
    );
    await tester.pump();

    final theme = Theme.of(tester.element(find.byType(SizedBox)));
    expect(theme.scaffoldBackgroundColor, AppColors.background);
    expect(theme.colorScheme.primary, AppColors.primary);
    expect(theme.appBarTheme.backgroundColor, AppColors.surface);
    expect(theme.progressIndicatorTheme.color, AppColors.primary);
    expect(
      theme.textTheme.headlineMedium?.fontSize,
      AppTypography.screenTitle.fontSize,
    );
    expect(
      theme.textTheme.headlineMedium?.fontWeight,
      AppTypography.screenTitle.fontWeight,
    );
    expect(theme.textTheme.bodyMedium?.fontSize, AppTypography.body.fontSize);
    expect(
      theme.inputDecorationTheme.constraints?.minHeight,
      AppSizes.fieldHeight,
    );
    expect(theme.dividerTheme.thickness, AppSizes.dividerThickness);
    final filledButtonMinSize = theme.filledButtonTheme.style!.minimumSize!
        .resolve({});
    expect(filledButtonMinSize!.height, AppSizes.fieldHeight);
  });
}
