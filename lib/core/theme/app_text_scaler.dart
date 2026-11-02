import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Tekstschaling zoals iOS Dynamic Type: kleine tekst groeit volledig mee,
/// grote koppen veel minder (Body 17 → 53 pt, Large Title 34 → 60 pt bij de
/// grootste toegankelijkheidsmaat). Flutter schaalt standaard lineair, waardoor
/// een titel van 28 pt bij AX5 87 pt wordt en letter voor letter afbreekt.
///
/// Daarnaast is de factor begrensd op [maxFactor] (≈ AX2, Body 34 pt): daarboven
/// passen formulieren en tabelrijen op een telefoon niet meer zinnig.
class AppTextScaler extends TextScaler {
  const AppTextScaler(this.factor);

  /// Bouwt de schaler uit de systeeminstelling (de factor voor Body-tekst).
  factory AppTextScaler.from(TextScaler system) {
    final factor = system.scale(_body) / _body;
    return AppTextScaler(factor.clamp(minFactor, maxFactor));
  }

  static const double _body = 17;
  static const double minFactor = 0.8;
  static const double maxFactor = 2;

  /// De systeemfactor voor Body-tekst (al begrensd).
  final double factor;

  @override
  double scale(double fontSize) {
    if (factor <= 1 || fontSize <= _body) return fontSize * factor;
    // Hoe groter de letter, hoe minder hij meegroeit (benadert de iOS-tabel:
    // 22 pt ≈ 0.7, 28 pt ≈ 0.5, 34 pt ≈ 0.35 van de extra groei).
    final weight = math.pow(_body / fontSize, 1.5).toDouble();
    return fontSize * (1 + (factor - 1) * weight);
  }

  @override
  double get textScaleFactor => factor;

  @override
  bool operator ==(Object other) =>
      other is AppTextScaler && other.factor == factor;

  @override
  int get hashCode => factor.hashCode;

  @override
  String toString() => 'AppTextScaler(${factor.toStringAsFixed(2)})';
}
