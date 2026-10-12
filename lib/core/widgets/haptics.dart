import 'package:flutter/services.dart';

/// Dunne laag over [HapticFeedback], zodat schermen in betekenis praten
/// ("gelukt", "fout") en niet in motortjes.
abstract final class Haptics {
  /// Lichte tik: knop ingedrukt, sheet geopend.
  static Future<void> light() => HapticFeedback.lightImpact();

  /// Keuze gewijzigd: pill, segment, picker.
  static Future<void> selection() => HapticFeedback.selectionClick();

  /// Iets is gelukt (opgeslagen, RSVP verwerkt).
  static Future<void> success() => HapticFeedback.mediumImpact();

  /// Iets ging mis of is geweigerd.
  static Future<void> error() => HapticFeedback.heavyImpact();
}
