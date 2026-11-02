import 'package:assistje/core/theme/app_text_scaler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('standaardgrootte verandert niets', () {
    const scaler = AppTextScaler(1);
    expect(scaler.scale(17), 17);
    expect(scaler.scale(34), 34);
  });

  test('broodtekst groeit volledig, koppen minder (als iOS)', () {
    const scaler = AppTextScaler(2);
    expect(scaler.scale(13), 26);
    expect(scaler.scale(17), 34);
    // Large Title groeit ~35% van de extra groei.
    expect(scaler.scale(34), closeTo(46, 1));
    expect(scaler.scale(28) / 28, lessThan(scaler.scale(17) / 17));
  });

  test('systeemfactor wordt begrensd op ≈ AX2', () {
    expect(AppTextScaler.from(const TextScaler.linear(3.12)).factor, 2);
    expect(AppTextScaler.from(const TextScaler.linear(1.2)).factor, 1.2);
    expect(AppTextScaler.from(const TextScaler.linear(0.5)).factor, 0.8);
  });
}
