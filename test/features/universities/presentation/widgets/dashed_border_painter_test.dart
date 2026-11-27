import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/presentation/widgets/dashed_border_painter.dart';

void main() {
  testWidgets('repaints when radius changes', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CustomPaint(
          painter: DashedBorderPainter(radius: 16),
          child: const SizedBox(width: 100, height: 100),
        ),
      ),
    );

    final painter = DashedBorderPainter(radius: 16);
    final other = DashedBorderPainter(radius: 12);
    expect(painter.shouldRepaint(other), isTrue);
    expect(painter.shouldRepaint(painter), isFalse);
  });
}
