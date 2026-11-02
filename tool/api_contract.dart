// Contractcheck: roept de app alleen API-routes aan die vogels3 ook heeft?
//
// (a) Scant `lib/**.dart` statisch op aanroepen via `ApiClient`/`Dio`
//     (`_api.get('/teams/$teamId/…')`, padhelpers als `_base(teamId)`, zie
//     `tool/api_contract_scan.dart`).
// (b) Haalt de v1-routes uit een vogels3-checkout: via
//     `php artisan route:list --json --path=api/v1` als php en `vendor/`
//     er zijn, anders door `routes/api/v1/**/*.php` te parsen.
// Exit-code 1 als een aanroep (methode + pad) geen route heeft.
//
//   dart run tool/api_contract.dart --api-repo ../vogels3
//   dart run tool/api_contract.dart --api-repo ../vogels3 --parse   # geen php
//   dart run tool/api_contract.dart --api-repo ../vogels3 --verbose # alles tonen
import 'dart:convert';
import 'dart:io';

import 'api_contract_scan.dart';

Future<void> main(List<String> args) async {
  String? apiRepo;
  var forceParse = false;
  var verbose = false;
  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (arg == '--api-repo' && i + 1 < args.length) {
      apiRepo = args[++i];
    } else if (arg.startsWith('--api-repo=')) {
      apiRepo = arg.substring('--api-repo='.length);
    } else if (arg == '--parse') {
      forceParse = true;
    } else if (arg == '--verbose' || arg == '-v') {
      verbose = true;
    } else {
      stderr.writeln('Onbekend argument: $arg');
      stderr.writeln(
        'Gebruik: dart run tool/api_contract.dart --api-repo <vogels3> '
        '[--parse] [--verbose]',
      );
      exitCode = 64;
      return;
    }
  }
  if (apiRepo == null || !Directory('$apiRepo/routes').existsSync()) {
    stderr.writeln('--api-repo <pad naar een vogels3-checkout> is verplicht.');
    exitCode = 64;
    return;
  }

  final calls = <ApiCall>[];
  final files =
      Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where(
            (f) =>
                f.path.endsWith('.dart') &&
                !f.path.endsWith('.g.dart') &&
                !f.path.endsWith('.freezed.dart') &&
                !f.path.contains('/l10n/generated/'),
          )
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  for (final file in files) {
    calls.addAll(scanDartSource(file.readAsStringSync(), file: file.path));
  }

  final (routes, bron) = forceParse
      ? (_parseRoutes(apiRepo), 'routebestanden geparst')
      : await _routeList(apiRepo) ??
            (_parseRoutes(apiRepo), 'routebestanden geparst');

  final missing = unmatchedCalls(calls, routes);
  stdout.writeln(
    'api-contract: ${calls.length} aanroepen in lib/, '
    '${routes.length} v1-routes ($bron).',
  );
  if (verbose) {
    for (final call in calls) {
      stdout.writeln('  $call');
    }
  }
  if (missing.isEmpty) {
    stdout.writeln('api-contract: OK, elke aanroep heeft een route.');
    return;
  }
  stderr.writeln('api-contract: ${missing.length} aanroep(en) zonder route:');
  for (final call in missing) {
    stderr.writeln('  $call');
  }
  exitCode = 1;
}

/// `php artisan route:list`, of `null` als dat niet kan (geen php/vendor).
Future<(List<ApiRoute>, String)?> _routeList(String repo) async {
  if (!File('$repo/vendor/autoload.php').existsSync()) return null;
  try {
    final result = await Process.run(
      'php',
      ['artisan', 'route:list', '--json', '--path=api/v1'],
      workingDirectory: repo,
      // Een lege of ontbrekende .env mag geen rol spelen.
      environment: {'APP_ENV': 'local', 'DB_CONNECTION': 'sqlite'},
    );
    if (result.exitCode != 0) {
      stderr.writeln(
        'api-contract: route:list faalde, val terug op parsen:\n'
        '${result.stderr}',
      );
      return null;
    }
    final out = result.stdout as String;
    final json = jsonDecode(out.substring(out.indexOf('['))) as List<Object?>;
    return (routesFromRouteListJson(json), 'php artisan route:list');
  } on ProcessException {
    return null;
  } on FormatException catch (e) {
    stderr.writeln('api-contract: route:list gaf geen JSON ($e), parse.');
    return null;
  }
}

/// De v1-routes uit de PHP-bestanden, met de prefixen uit `routes/api.php`:
/// `api/v1/public/*` en `api/v1/*` op `v1`, `api/v1/teams/*` onder
/// `teams/{team}`; plus de vaste auth-routes uit `routes/api.php` zelf.
List<ApiRoute> _parseRoutes(String repo) {
  final routes = <ApiRoute>[];
  final apiPhp = File('$repo/routes/api.php').readAsStringSync();
  final v1Start = apiPhp.indexOf("Route::prefix('v1')");
  if (v1Start >= 0) {
    routes.addAll(routesFromPhp(apiPhp.substring(v1Start)));
  }
  for (final (dir, prefix) in [
    ('routes/api/v1/public', ''),
    ('routes/api/v1', ''),
    ('routes/api/v1/teams', 'teams/{team}'),
  ]) {
    final d = Directory('$repo/$dir');
    if (!d.existsSync()) continue;
    final files =
        d
            .listSync()
            .whereType<File>()
            .where((f) => f.path.endsWith('.php'))
            .toList()
          ..sort((a, b) => a.path.compareTo(b.path));
    for (final f in files) {
      routes.addAll(routesFromPhp(f.readAsStringSync(), prefix: prefix));
    }
  }
  // De `v1`-prefix van de groep zelf hoort niet in de uri.
  return [
    for (final r in routes)
      ApiRoute(r.methods, r.uri.startsWith('v1/') ? r.uri.substring(3) : r.uri),
  ];
}
