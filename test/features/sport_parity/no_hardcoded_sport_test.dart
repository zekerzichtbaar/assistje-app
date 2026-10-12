import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Statische bewaker: nergens in `lib/` mag code een sport bij naam kennen.
/// Wat een scherm per sport anders doet, komt uit het API-sportprofiel
/// (`membership.sport`) of uit het API-antwoord zelf.
///
/// Gezocht wordt naar string-literals met een sportsleutel of sportnaam
/// (Engels of Nederlands). Commentaar telt niet mee, en Phosphor-iconen als
/// `PhosphorIconsDuotone.soccerBall` evenmin: dat zijn identifiers, geen
/// sportkeuze.
void main() {
  // Toegestaan: alleen opzoektabellen die op een API-waarde gesleuteld zijn
  // (`field_variant` of `sport.key`) — data-gedreven, geen sportlogica.
  const allowList = <String, String>{
    // `fieldPainterFor(field_variant)`: de veldtekening per variant uit de
    // API, met een neutraal veld voor onbekende varianten.
    'lib/features/lineup/presentation/widgets/field_painters.dart':
        'veldtekening per field_variant',
    // Tabicoon per `sport.key` (hockeystick, volleybal, …) met een
    // standaardbal als terugval.
    'lib/core/shell/nav_presentation.dart': 'tabicoon per sport.key',
    // Sporticoon boven de spelersstatistieken per `sport.key`, zelfde
    // terugval.
    'lib/features/players/presentation/widgets/player_stats_section.dart':
        'sporticoon per sport.key',
  };

  // Bewust zonder "soccer": `SoccerBall` is een Phosphor-icoonnaam (ook
  // als string, bv. dienst-iconen uit de API), geen sportsleutel — de API
  // zegt `football`.
  final sportWord = RegExp(
    'football|voetbal|hockey|korfbal|volleybal',
    caseSensitive: false,
  );
  final literal = RegExp(
    r"'(?:[^'\\\n]|\\.)*'"
    r'|"(?:[^"\\\n]|\\.)*"',
  );

  bool generated(String path) =>
      path.endsWith('.g.dart') ||
      path.endsWith('.freezed.dart') ||
      path.startsWith('lib/l10n/generated/');

  /// Haalt `//`-commentaar weg buiten strings (grof, maar genoeg voor de
  /// regel-voor-regel-scan hieronder).
  String stripComment(String line) {
    final trimmed = line.trimLeft();
    if (trimmed.startsWith('//') || trimmed.startsWith('*')) return '';
    var inSingle = false;
    var inDouble = false;
    for (var i = 0; i < line.length - 1; i++) {
      final c = line[i];
      if (c == r'\') {
        i++;
        continue;
      }
      if (c == "'" && !inDouble) inSingle = !inSingle;
      if (c == '"' && !inSingle) inDouble = !inDouble;
      if (!inSingle && !inDouble && c == '/' && line[i + 1] == '/') {
        return line.substring(0, i);
      }
    }
    return line;
  }

  List<String> violations() {
    final found = <String>[];
    final files = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));
    for (final file in files) {
      final path = file.path.replaceAll(r'\', '/');
      if (generated(path) || allowList.containsKey(path)) continue;
      final lines = file.readAsLinesSync();
      for (final (i, line) in lines.indexed) {
        for (final match in literal.allMatches(stripComment(line))) {
          if (sportWord.hasMatch(match.group(0)!)) {
            found.add('$path:${i + 1}: ${line.trim()}');
          }
        }
      }
    }
    return found;
  }

  test('geen hardgecodeerde sport in lib/ (buiten de toegestane tabellen)', () {
    expect(violations(), isEmpty);
  });

  test('de toegestane bestanden bestaan nog (lijst blijft actueel)', () {
    for (final path in allowList.keys) {
      expect(File(path).existsSync(), isTrue, reason: path);
    }
  });

  test('de scan vindt een sport in een string-literal', () {
    expect(sportWord.hasMatch("'korfball'"), isTrue);
    expect(
      literal
          .allMatches(stripComment("if (key == 'hockey') x(); // voetbal"))
          .map((m) => m.group(0)),
      ["'hockey'"],
    );
    expect(stripComment('/// Een volleybalteam zegt "Libero".'), isEmpty);
  });
}
