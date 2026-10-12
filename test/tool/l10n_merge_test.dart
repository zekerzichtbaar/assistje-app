import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/l10n_merge.dart';

void main() {
  group('mergeArbFragments', () {
    test('voegt fragmenten op bestandsnaam samen, @@locale één keer', () {
      final merged = mergeArbFragments({
        'b_nl.arb': '{"@@locale": "nl", "bKey": "B", "@bKey": {"x": 1}}',
        'a_nl.arb': '{"@@locale": "nl", "aKey": "A"}',
      });

      expect(merged.keys.toList(), ['@@locale', 'aKey', 'bKey', '@bKey']);
      expect(merged['@@locale'], 'nl');
      expect(merged['@bKey'], {'x': 1});
    });

    test('dubbele key over fragmenten heen is een fout', () {
      expect(
        () => mergeArbFragments({
          'a_nl.arb': '{"same": "A"}',
          'b_nl.arb': '{"same": "B"}',
        }),
        throwsA(
          isA<ArbMergeException>().having(
            (e) => e.message,
            'message',
            contains('"same"'),
          ),
        ),
      );
    });

    test('verkeerde locale, kapotte JSON en geen fragmenten zijn fouten', () {
      expect(
        () => mergeArbFragments({'a.arb': '{"@@locale": "en"}'}),
        throwsA(isA<ArbMergeException>()),
      );
      expect(
        () => mergeArbFragments({'a.arb': '{'}),
        throwsA(isA<ArbMergeException>()),
      );
      expect(() => mergeArbFragments({}), throwsA(isA<ArbMergeException>()));
    });
  });

  test('de echte fragmenten hebben geen dubbele keys', () {
    final merged = mergeArbDirectory(Directory('lib/l10n/arb'));
    expect(merged['@@locale'], 'nl');
    expect(merged, contains('appTitle'));
  });

  group('tool/l10n.dart', () {
    late Directory tmp;

    setUp(() => tmp = Directory.systemTemp.createTempSync('l10n_test'));
    tearDown(() => tmp.deleteSync(recursive: true));

    Future<ProcessResult> run(Directory fragments, File out) =>
        Process.run('dart', [
          'run',
          'tool/l10n.dart',
          '--no-gen',
          '--fragments=${fragments.path}',
          '--out=${out.path}',
        ]);

    test('schrijft het samengevoegde ARB-bestand', () async {
      final fragments = Directory('${tmp.path}/arb')..createSync();
      File('${fragments.path}/a_nl.arb').writeAsStringSync('{"aKey": "A"}');
      File('${fragments.path}/b_nl.arb').writeAsStringSync('{"bKey": "B"}');
      final out = File('${tmp.path}/app_nl.arb');

      final result = await run(fragments, out);

      expect(result.exitCode, 0, reason: '${result.stderr}');
      expect(jsonDecode(out.readAsStringSync()), {
        '@@locale': 'nl',
        'aKey': 'A',
        'bKey': 'B',
      });
    });

    test('dubbele key geeft een non-zero exit', () async {
      final fragments = Directory('${tmp.path}/arb')..createSync();
      File('${fragments.path}/a_nl.arb').writeAsStringSync('{"dup": "A"}');
      File('${fragments.path}/b_nl.arb').writeAsStringSync('{"dup": "B"}');
      final out = File('${tmp.path}/app_nl.arb');

      final result = await run(fragments, out);

      expect(result.exitCode, isNot(0));
      expect(result.stderr, contains('dup'));
      expect(out.existsSync(), isFalse);
    });
  });
}
