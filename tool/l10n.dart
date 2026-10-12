// Voegt de copy-fragmenten `lib/l10n/arb/*_nl.arb` samen tot
// `lib/l10n/app_nl.arb` (gegenereerd, gitignored) en draait daarna
// `flutter gen-l10n`.
//
// Gebruik (vanuit de projectroot):
//   dart run tool/l10n.dart            # samenvoegen + gen-l10n
//   dart run tool/l10n.dart --no-gen   # alleen samenvoegen
//   dart run tool/l10n.dart --fragments=<map> --out=<bestand>
//
// Exit-code 1 bij een dubbele key of kapot fragment; anders de exit-code van
// `flutter gen-l10n`.
import 'dart:io';

import 'l10n_merge.dart';

Future<void> main(List<String> args) async {
  var fragmentsDir = 'lib/l10n/arb';
  var outFile = 'lib/l10n/app_nl.arb';
  var runGen = true;
  for (final arg in args) {
    if (arg == '--no-gen') {
      runGen = false;
    } else if (arg.startsWith('--fragments=')) {
      fragmentsDir = arg.substring('--fragments='.length);
    } else if (arg.startsWith('--out=')) {
      outFile = arg.substring('--out='.length);
    } else {
      stderr.writeln('Onbekend argument: $arg');
      exitCode = 64;
      return;
    }
  }

  final Map<String, Object?> merged;
  try {
    merged = mergeArbDirectory(Directory(fragmentsDir));
  } on ArbMergeException catch (e) {
    stderr.writeln('l10n: ${e.message}');
    exitCode = 1;
    return;
  }
  File(outFile).writeAsStringSync(encodeArb(merged));
  final count = merged.keys.where((k) => !k.startsWith('@')).length;
  stdout.writeln('l10n: $count keys -> $outFile');

  if (!runGen) return;
  final result = await Process.run('flutter', [
    'gen-l10n',
  ], runInShell: Platform.isWindows);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
  exitCode = result.exitCode;
}
