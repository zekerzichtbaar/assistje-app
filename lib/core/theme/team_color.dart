import 'dart:math' as math;
import 'dart:ui' show Color;

/// 1-op-1 port van de kleurlogica in vogels3
/// `resources/js/Components/ThemeApplier.tsx`.
///
/// Werkt bewust op hex-strings, net als het origineel: dezelfde invoer moet
/// exact dezelfde uitvoer geven (inclusief de terugvalwaarden bij ongeldige
/// hex), anders lopen app en PWA uit elkaar. De unit-tests in
/// `test/core/theme/team_color_test.dart` zijn met de TS-code doorgerekend.
abstract final class TeamColor {
  /// Standaard clubkleur (Valleivogels) als een team nog geen kleur heeft;
  /// dezelfde terugval als `--color-primary-light` in app.css.
  static const String fallbackHex = '#006837';

  /// Zwart of wit, afhankelijk van de waargenomen helderheid van [hex].
  ///
  /// Port van `luminanceContrast()`.
  static String luminanceContrast(String hex) {
    final clean = hex.replaceFirst('#', '');
    if (clean.length != 6) return '#ffffff';
    final r = _channel(clean, 0) / 255;
    final g = _channel(clean, 2) / 255;
    final b = _channel(clean, 4) / 255;
    final lum = 0.299 * r + 0.587 * g + 0.114 * b;
    return lum > 0.5 ? '#000000' : '#ffffff';
  }

  /// Dezelfde clubkleur, maar leesbaar op een donkere achtergrond.
  ///
  /// Optillen gebeurt in HSL: de helderheid gaat naar minstens 0,5 en de
  /// verzadiging wordt op 0,85 afgetopt. Grijstinten worden neutraal grijs.
  /// Port van `liftForDark()`; zie daar de afweging achter de getallen.
  static String liftForDark(String hex) {
    final clean = hex.replaceFirst('#', '');
    if (clean.length != 6) return hex;

    final r = _channel(clean, 0) / 255;
    final g = _channel(clean, 2) / 255;
    final b = _channel(clean, 4) / 255;

    final max = math.max(r, math.max(g, b));
    final min = math.min(r, math.min(g, b));
    final l = (max + min) / 2;
    final d = max - min;

    var h = 0.0;
    var sat = 0.0;

    if (d != 0) {
      sat = l > 0.5 ? d / (2 - max - min) : d / (max + min);
      if (max == r) {
        h = ((g - b) / d + (g < b ? 6 : 0)) / 6;
      } else if (max == g) {
        h = ((b - r) / d + 2) / 6;
      } else {
        h = ((r - g) / d + 4) / 6;
      }
    }

    final targetL = math.max(l, 0.5);
    final targetS = sat == 0 ? 0.0 : math.min(sat, 0.85);

    double hue2rgb(double p, double q, double t) {
      var tt = t;
      if (tt < 0) tt += 1;
      if (tt > 1) tt -= 1;
      if (tt < 1 / 6) return p + (q - p) * 6 * tt;
      if (tt < 1 / 2) return q;
      if (tt < 2 / 3) return p + (q - p) * (2 / 3 - tt) * 6;
      return p;
    }

    final q = targetL < 0.5
        ? targetL * (1 + targetS)
        : targetL + targetS - targetL * targetS;
    final p = 2 * targetL - q;

    String toHex(double v) =>
        (v.clamp(0.0, 1.0) * 255).round().toRadixString(16).padLeft(2, '0');

    return targetS == 0
        ? '#${toHex(targetL)}${toHex(targetL)}${toHex(targetL)}'
        : '#${toHex(hue2rgb(p, q, h + 1 / 3))}'
              '${toHex(hue2rgb(p, q, h))}'
              '${toHex(hue2rgb(p, q, h - 1 / 3))}';
  }

  /// RGB-kanalen als `"r g b"`, met dezelfde terugval als het origineel.
  ///
  /// Port van `rgbChannels()`; in Flutter niet nodig voor opacity, maar wel
  /// handig om de uitkomsten 1-op-1 tegen de PWA te testen.
  static String rgbChannels(String hex) {
    final clean = hex.replaceFirst('#', '');
    if (clean.length != 6) return '0 104 55';
    return [
      _channel(clean, 0),
      _channel(clean, 2),
      _channel(clean, 4),
    ].join(' ');
  }

  /// Hex (`#rrggbb` of `rrggbb`) naar een ondoorzichtige [Color].
  /// Ongeldige invoer valt terug op [fallbackHex].
  static Color toColor(String hex) {
    var clean = hex.replaceFirst('#', '');
    if (clean.length != 6 || int.tryParse(clean, radix: 16) == null) {
      clean = fallbackHex.substring(1);
    }
    return Color(0xFF000000 | int.parse(clean, radix: 16));
  }

  // JS geeft bij ongeldige hex NaN door; hier liever 0 dan een crash.
  static int _channel(String clean, int start) =>
      int.tryParse(clean.substring(start, start + 2), radix: 16) ?? 0;
}

/// Alle afgeleide teamkleuren die ThemeApplier op `<html>` zet, per thema.
class TeamPalette {
  const TeamPalette({
    required this.light,
    required this.lightContrast,
    required this.dark,
    required this.darkContrast,
  });

  /// Rekent de vier kleuren uit zoals `ThemeApplier` dat doet.
  factory TeamPalette.fromHex(String? primaryHex) {
    final light = (primaryHex == null || primaryHex.isEmpty)
        ? TeamColor.fallbackHex
        : primaryHex;
    final dark = TeamColor.liftForDark(light);
    return TeamPalette(
      light: TeamColor.toColor(light),
      lightContrast: TeamColor.toColor(TeamColor.luminanceContrast(light)),
      dark: TeamColor.toColor(dark),
      darkContrast: TeamColor.toColor(TeamColor.luminanceContrast(dark)),
    );
  }

  /// `--color-primary-light`: de clubkleur zelf.
  final Color light;

  /// `--color-primary-light-contrast`: tekst op de clubkleur.
  final Color lightContrast;

  /// `--color-primary-dark`: de opgetilde clubkleur voor donkere modus.
  final Color dark;

  /// `--color-primary-dark-contrast`: tekst op de opgetilde clubkleur.
  final Color darkContrast;
}
