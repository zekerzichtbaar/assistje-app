import 'dart:convert';
import 'dart:io';

/// Fout bij het samenvoegen van ARB-fragmenten (dubbele key, kapotte JSON,
/// verkeerde locale, geen fragmenten).
class ArbMergeException implements Exception {
  ArbMergeException(this.message);

  final String message;

  @override
  String toString() => 'ArbMergeException: $message';
}

/// Voegt ARB-fragmenten samen tot één template-ARB voor `flutter gen-l10n`.
///
/// [fragments] is een map van bestandsnaam naar JSON-inhoud. Fragmenten worden
/// op bestandsnaam gesorteerd verwerkt, zodat de uitvoer deterministisch is.
/// `@@locale` komt één keer bovenaan; een key (of `@key`-metadata) die in
/// meer dan één fragment staat is een fout.
Map<String, Object?> mergeArbFragments(
  Map<String, String> fragments, {
  String locale = 'nl',
}) {
  if (fragments.isEmpty) {
    throw ArbMergeException('Geen ARB-fragmenten gevonden.');
  }
  final merged = <String, Object?>{'@@locale': locale};
  final owner = <String, String>{};
  final names = fragments.keys.toList()..sort();
  for (final name in names) {
    final Object? decoded;
    try {
      decoded = jsonDecode(fragments[name]!);
    } on FormatException catch (e) {
      throw ArbMergeException('$name is geen geldige JSON: ${e.message}');
    }
    if (decoded is! Map<String, Object?>) {
      throw ArbMergeException('$name moet een JSON-object zijn.');
    }
    for (final MapEntry(:key, :value) in decoded.entries) {
      if (key == '@@locale') {
        if (value != locale) {
          throw ArbMergeException(
            '$name heeft @@locale "$value", verwacht "$locale".',
          );
        }
        continue;
      }
      final previous = owner[key];
      if (previous != null) {
        throw ArbMergeException('Dubbele key "$key" in $previous en $name.');
      }
      owner[key] = name;
      merged[key] = value;
    }
  }
  return merged;
}

/// Leest alle `*.arb`-bestanden in [dir] en voegt ze samen.
Map<String, Object?> mergeArbDirectory(Directory dir, {String locale = 'nl'}) {
  if (!dir.existsSync()) {
    throw ArbMergeException('Map ${dir.path} bestaat niet.');
  }
  final files = dir.listSync().whereType<File>().where(
    (f) => f.path.endsWith('.arb'),
  );
  return mergeArbFragments({
    for (final f in files) f.uri.pathSegments.last: f.readAsStringSync(),
  }, locale: locale);
}

/// Serialiseert een ARB-map zoals de bestaande bestanden (2 spaties, `\n`).
String encodeArb(Map<String, Object?> arb) =>
    '${const JsonEncoder.withIndent('  ').convert(arb)}\n';
