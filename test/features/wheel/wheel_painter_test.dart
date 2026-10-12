import 'dart:ui' as ui;

import 'package:assistje/features/wheel/presentation/widgets/wheel_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  void paint(WheelPainter painter, {Size size = const Size(300, 300)}) {
    final recorder = ui.PictureRecorder();
    painter.paint(Canvas(recorder), size);
    recorder.endRecording().dispose();
  }

  test('tekent zonder fouten bij 0, 1, 2, oneven en veel deelnemers', () {
    for (final count in [0, 1, 2, 5, 16]) {
      paint(
        WheelPainter(
          names: [for (var i = 0; i < count; i++) 'Speler met lange naam $i'],
          rotation: 123.4 * count,
          pointerTilt: -12,
          bulbPhase: 0.3,
          spinning: count.isEven,
        ),
      );
    }
    // Niet-vierkant canvas.
    paint(
      WheelPainter(names: const ['A', 'B'], rotation: 0),
      size: const Size(400, 200),
    );
  });

  test('shouldRepaint alleen bij een verandering', () {
    final a = WheelPainter(names: const ['A', 'B'], rotation: 10);
    expect(
      a.shouldRepaint(WheelPainter(names: const ['A', 'B'], rotation: 10)),
      isFalse,
    );
    expect(
      a.shouldRepaint(WheelPainter(names: const ['A', 'B'], rotation: 11)),
      isTrue,
    );
    expect(
      a.shouldRepaint(WheelPainter(names: const ['A', 'C'], rotation: 10)),
      isTrue,
    );
  });

  testWidgets('rendert in een widget', (tester) async {
    await tester.pumpWidget(
      Center(
        child: SizedBox.square(
          dimension: 300,
          child: CustomPaint(
            key: const ValueKey('painter'),
            painter: WheelPainter(
              names: const ['Sam', 'Kim', 'Joep'],
              rotation: 45,
            ),
          ),
        ),
      ),
    );
    expect(find.byKey(const ValueKey('painter')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
