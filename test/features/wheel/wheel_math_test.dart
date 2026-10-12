import 'package:assistje/features/wheel/application/wheel_math.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('eindrotatie zet het winnende segment onder de wijzer', () {
    for (final count in [2, 3, 5, 8, 13]) {
      for (var winner = 0; winner < count; winner++) {
        for (final start in [0.0, 37.5, 1234.0, -90.0]) {
          final target = spinTargetRotation(
            current: start,
            winnerIndex: winner,
            count: count,
          );
          expect(segmentAt(target, count), winner, reason: '$count/$winner');
          // Altijd vooruit, met minstens de volle rondes.
          expect(target - start, greaterThan(wheelFullTurns * 360));
          expect(target - start, lessThanOrEqualTo((wheelFullTurns + 1) * 360));
        }
      }
    }
  });

  test('segment onder de wijzer zonder rotatie', () {
    expect(segmentAt(0, 4), 0);
    // 4 segmenten van 90°: na 100° met de klok mee staat segment 2 boven.
    expect(segmentAt(100, 4), 2);
    expect(segmentAt(0, 0), -1);
  });

  test('uitloop loopt van 0 naar 1', () {
    expect(wheelEase(0), 0);
    expect(wheelEase(1), 1);
    expect(wheelEase(0.5), greaterThan(0.5));
    expect(wheelEase(2), 1);
  });

  test('wijzer ratelt tussen 0 en -20 graden', () {
    for (var r = 0.0; r < 360; r += 7) {
      final tilt = pointerTilt(r, 6);
      expect(tilt, inInclusiveRange(-20, 0));
    }
    expect(pointerTilt(30, 1), 0);
  });

  test('namen inkorten', () {
    expect(shortWheelName('Sam', 7), 'Sam');
    expect(shortWheelName('Sam de Vries', 7), 'Sam de…');
  });
}
