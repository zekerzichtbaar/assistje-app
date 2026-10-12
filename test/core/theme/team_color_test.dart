import 'package:assistje/core/theme/team_color.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

/// Verwachte waarden zijn doorgerekend met de originele TS-functies uit
/// vogels3 `resources/js/Components/ThemeApplier.tsx` (onder node, letterlijk
/// overgenomen). Wijzigt ThemeApplier, reken dan deze tabel opnieuw uit.
///
/// Kolommen: invoer, contrast(invoer), rgb(invoer), liftForDark(invoer),
/// contrast(lift), rgb(lift).
const _cases = <List<String>>[
  ['#006837', '#ffffff', '0 104 55', '#13ec86', '#000000', '19 236 134'],
  ['#E30613', '#ffffff', '227 6 19', '#ec1320', '#ffffff', '236 19 32'],
  ['#000000', '#ffffff', '0 0 0', '#808080', '#000000', '128 128 128'],
  ['#ffffff', '#000000', '255 255 255', '#ffffff', '#000000', '255 255 255'],
  ['#1e3a8a', '#ffffff', '30 58 138', '#2e58d1', '#ffffff', '46 88 209'],
  ['#FFD700', '#000000', '255 215 0', '#ecca13', '#000000', '236 202 19'],
  ['#808080', '#000000', '128 128 128', '#808080', '#000000', '128 128 128'],
  ['#ff6600', '#000000', '255 102 0', '#ec6a13', '#000000', '236 106 19'],
  ['#7f7f7f', '#ffffff', '127 127 127', '#808080', '#000000', '128 128 128'],
  ['#123456', '#ffffff', '18 52 86', '#2c7fd3', '#ffffff', '44 127 211'],
  ['#00ff00', '#000000', '0 255 0', '#13ec13', '#000000', '19 236 19'],
  ['#663399', '#ffffff', '102 51 153', '#7f40bf', '#ffffff', '127 64 191'],
  ['#0000ff', '#ffffff', '0 0 255', '#1313ec', '#ffffff', '19 19 236'],
  ['#C0C0C0', '#000000', '192 192 192', '#c0c0c0', '#000000', '192 192 192'],
  // Zonder hekje werkt het origineel ook.
  ['abcdef', '#000000', '171 205 239', '#abcdef', '#000000', '171 205 239'],
  // Ongeldige lengte: de terugvalwaarden van het origineel.
  ['#fff', '#ffffff', '0 104 55', '#fff', '#ffffff', '0 104 55'],
];

void main() {
  group('TeamColor (port van ThemeApplier.tsx)', () {
    for (final c in _cases) {
      final input = c[0];

      test('$input: contrast, kanalen en liftForDark', () {
        expect(TeamColor.luminanceContrast(input), c[1]);
        expect(TeamColor.rgbChannels(input), c[2]);

        final lifted = TeamColor.liftForDark(input);
        expect(lifted, c[3]);
        expect(TeamColor.luminanceContrast(lifted), c[4]);
        expect(TeamColor.rgbChannels(lifted), c[5]);
      });
    }
  });

  group('TeamPalette', () {
    test('rekent de vier kleuren uit zoals ThemeApplier', () {
      final p = TeamPalette.fromHex('#E30613');
      expect(p.light, const Color(0xFFE30613));
      expect(p.lightContrast, const Color(0xFFFFFFFF));
      expect(p.dark, const Color(0xFFEC1320));
      expect(p.darkContrast, const Color(0xFFFFFFFF));
    });

    test('valt zonder teamkleur terug op de standaardkleur', () {
      final p = TeamPalette.fromHex(null);
      expect(p.light, const Color(0xFF006837));
      expect(p.dark, const Color(0xFF13EC86));
      expect(p.darkContrast, const Color(0xFF000000));
    });

    test('toColor valt bij ongeldige hex terug op de standaardkleur', () {
      expect(TeamColor.toColor('#zzzzzz'), const Color(0xFF006837));
      expect(TeamColor.toColor('#fff'), const Color(0xFF006837));
    });
  });
}
