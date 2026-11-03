// End-to-end-tests: de echte app op een iOS-simulator tegen een echte, lokale
// vogels3 met een verse seed. Zie README → "End-to-end tests".
//
//   dart run tool/e2e.dart --api-repo ../vogels3
//   dart run tool/e2e.dart --api-repo ../vogels3 02_rsvp     # alleen deze
//   dart run tool/e2e.dart --api-repo ../vogels3 --device <udid> --port 8001
//   dart run tool/e2e.dart --api-repo ../vogels3 --reuse-server
//
// Stappen:
// 1. vogels3 starten op 127.0.0.1:<port> (de PHP-server die ook
//    `artisan serve` draait, maar direct: `artisan serve` filtert de
//    omgevingsvariabelen weg). Alles komt uit env-vars — de lokale `.env`
//    van vogels3 doet er niet toe: verse APP_KEY, sqlite in een tijdelijke
//    map, mail naar de log, queue sync, logs naar stderr.
// 2. `php artisan migrate:fresh --force` + `php artisan assistje:e2e` (de
//    seed; JSON met team, gebruikers, events — zie `integration_test/support/
//    fixture.dart`).
// 3. Per testbestand in integration_test/: een verse inlogcode voor de rol uit
//    de kopregel `// e2e-rol: <trainer|player|spectator>` via
//    `php artisan assistje:e2e --code-for=<rol>` (codes zijn eenmalig), dan
//    `flutter test <bestand> -d <udid> --dart-define-from-file=<defines>`.
//
// Met `--reuse-server` draait er al een vogels3 op de poort; er wordt dan niet
// gemigreerd en de seed draait met jouw eigen `.env` (zelfde database als die
// server!). Exit-code 1 als een test faalt.
import 'dart:convert';
import 'dart:io';
import 'dart:math';

const _defaultRepo = '../vogels3';

Future<void> main(List<String> args) async {
  try {
    await _run(args);
  } on _E2eFailure catch (e) {
    stderr.writeln('e2e: ${e.message}');
    exitCode = 1;
  }
}

Future<void> _run(List<String> args) async {
  var apiRepo = _defaultRepo;
  var port = 8000;
  String? device;
  var reuseServer = false;
  final filters = <String>[];
  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    String next() => i + 1 < args.length ? args[++i] : _usage();
    switch (arg) {
      case '--api-repo':
        apiRepo = next();
      case '--port':
        port = int.parse(next());
      case '--device' || '-d':
        device = next();
      case '--reuse-server':
        reuseServer = true;
      case '-h' || '--help':
        _usage();
      default:
        if (arg.startsWith('-')) _usage();
        filters.add(arg);
    }
  }
  apiRepo = Directory(apiRepo).absolute.path;
  if (!File('$apiRepo/artisan').existsSync()) {
    _fail('Geen vogels3-checkout op $apiRepo (--api-repo).');
  }

  final tests =
      Directory('integration_test')
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('_test.dart'))
          .where(
            (f) => filters.isEmpty || filters.any((p) => f.path.contains(p)),
          )
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  if (tests.isEmpty) _fail('Geen integration_test/*_test.dart gevonden.');

  final udid = device ?? await _simulator();
  final tmp = Directory.systemTemp.createTempSync('assistje-e2e-');
  final baseUrl = 'http://127.0.0.1:$port';
  final env = reuseServer ? <String, String>{} : _backendEnv(tmp, baseUrl);
  Process? server;
  // Gesloten in cleanup().
  // ignore: close_sinks
  IOSink? serverLog;
  var keepTmp = false;

  Future<void> cleanup() async {
    final running = server;
    if (running != null) {
      // Met PHP_CLI_SERVER_WORKERS blijven de workers anders draaien.
      await Process.run('pkill', ['-TERM', '-P', '${running.pid}']);
      running.kill();
      await running.exitCode.timeout(
        const Duration(seconds: 5),
        onTimeout: () => 0,
      );
    }
    final log = serverLog;
    serverLog = null;
    await log?.close();
    if (keepTmp) {
      _log('Serverlog en database bewaard in ${tmp.path}');
      return;
    }
    try {
      tmp.deleteSync(recursive: true);
    } on FileSystemException {
      // Niet erg: het is de tijdelijke map.
    }
  }

  ProcessSignal.sigint.watch().listen((_) async {
    await cleanup();
    exit(130);
  });

  try {
    final running = await _isUp(baseUrl);
    if (running && !reuseServer) {
      _fail(
        'Er draait al iets op $baseUrl. Stop het, kies --port, of gebruik '
        '--reuse-server (dan met jouw .env-database).',
      );
    }
    if (!reuseServer) {
      _log('Migreren (sqlite in ${tmp.path}) …');
      await _artisan(apiRepo, env, ['migrate:fresh', '--force']);
      _log('vogels3 starten op $baseUrl …');
      server = await Process.start(
        'php',
        [
          '-S',
          '127.0.0.1:$port',
          '-t',
          'public',
          'vendor/laravel/framework/src/Illuminate/Foundation/resources/server.php',
        ],
        workingDirectory: apiRepo,
        environment: {...env, 'PHP_CLI_SERVER_WORKERS': '4'},
      );
      serverLog = File('${tmp.path}/server.log').openWrite();
      server.stdout.listen((data) => serverLog?.add(data));
      server.stderr.listen((data) => serverLog?.add(data));
      if (!await _waitUp(baseUrl)) _fail('vogels3 kwam niet op op $baseUrl.');
    } else if (!running) {
      _fail('--reuse-server, maar op $baseUrl draait niets.');
    }

    _log('Seeden (php artisan assistje:e2e) …');
    final fixture = _json(await _artisan(apiRepo, env, ['assistje:e2e']));
    // De seed weet zelf welke URL hij uitdeelt; anders de onze.
    final apiBaseUrl = fixture['api_base_url'] as String? ?? '$baseUrl/api/v1';
    final definesDir = Directory('.dart_tool/e2e')..createSync(recursive: true);

    final failed = <String>[];
    for (final test in tests) {
      final name = test.uri.pathSegments.last;
      final role = _roleOf(test);
      final login = role == null
          ? null
          : await _freshLogin(apiRepo, env, role, fixture);
      final defines = File('${definesDir.path}/$name.json')
        ..writeAsStringSync(
          jsonEncode({
            'API_BASE_URL': apiBaseUrl,
            'APP_VERSION': '1.0.0+1',
            'E2E_FIXTURE': jsonEncode(fixture),
            if (login != null) 'E2E_LOGIN': jsonEncode(login),
          }),
        );
      _log('▶ $name (${role ?? 'geen login'}) op $udid');
      final code = await _stream('flutter', [
        'test',
        test.path,
        '-d',
        udid,
        '--dart-define-from-file=${defines.path}',
      ]);
      if (code != 0) failed.add(name);
    }

    _log(
      failed.isEmpty
          ? 'e2e: alle ${tests.length} tests geslaagd.'
          : 'e2e: ${failed.length}/${tests.length} gefaald: ${failed.join(', ')}'
                '\nServerlog: ${tmp.path}/server.log',
    );
    keepTmp = failed.isNotEmpty;
    exitCode = failed.isEmpty ? 0 : 1;
  } finally {
    await cleanup();
  }
}

Never _usage() {
  stderr.writeln(
    'Gebruik: dart run tool/e2e.dart [--api-repo <vogels3>] [--port 8000] '
    '[--device <udid>] [--reuse-server] [testnaamfilter …]',
  );
  exit(64);
}

/// Gooit; `main` meldt het en ruimt de server en de tijdelijke map op.
Never _fail(String message) => throw _E2eFailure(message);

class _E2eFailure implements Exception {
  const _E2eFailure(this.message);
  final String message;
}

void _log(String message) => stdout.writeln('e2e: $message');

/// De omgeving voor vogels3: niets uit `.env`, alles hier.
Map<String, String> _backendEnv(Directory tmp, String baseUrl) {
  final key = List<int>.generate(32, (_) => Random.secure().nextInt(256));
  final db = File('${tmp.path}/e2e.sqlite')..createSync();
  return {
    'APP_KEY': 'base64:${base64Encode(key)}',
    'APP_ENV': 'local',
    'APP_DEBUG': 'true',
    'APP_URL': baseUrl,
    'APP_TIMEZONE': 'Europe/Amsterdam',
    'DB_CONNECTION': 'sqlite',
    'DB_DATABASE': db.path,
    'MAIL_MAILER': 'log',
    'QUEUE_CONNECTION': 'sync',
    'CACHE_STORE': 'array',
    'SESSION_DRIVER': 'array',
    'BROADCAST_CONNECTION': 'log',
    'LOG_CHANNEL': 'stderr',
    'VIEW_COMPILED_PATH': tmp.path,
  };
}

Future<String> _artisan(
  String repo,
  Map<String, String> env,
  List<String> args,
) async {
  final result = await Process.run(
    'php',
    ['artisan', ...args],
    workingDirectory: repo,
    environment: env,
  );
  if (result.exitCode != 0) {
    _fail(
      'php artisan ${args.join(' ')} faalde (${result.exitCode}):\n'
      '${result.stdout}\n${result.stderr}',
    );
  }
  return result.stdout as String;
}

/// Het JSON-object in [output] (eventuele regels ervoor/erna genegeerd).
Map<String, Object?> _json(String output) {
  final start = output.indexOf('{');
  final end = output.lastIndexOf('}');
  if (start < 0 || end < start) _fail('Geen JSON in de uitvoer:\n$output');
  return jsonDecode(output.substring(start, end + 1)) as Map<String, Object?>;
}

/// `// e2e-rol: trainer` bovenin het testbestand.
String? _roleOf(File test) {
  final m = RegExp(
    r'^//\s*e2e-rol:\s*(\w+)',
    multiLine: true,
  ).firstMatch(test.readAsStringSync());
  return m?.group(1);
}

/// Een verse code voor [role]; lukt `--code-for` niet, dan die uit de seed.
Future<Map<String, Object?>> _freshLogin(
  String repo,
  Map<String, String> env,
  String role,
  Map<String, Object?> fixture,
) async {
  final result = await Process.run(
    'php',
    ['artisan', 'assistje:e2e', '--code-for=$role'],
    workingDirectory: repo,
    environment: env,
  );
  if (result.exitCode == 0) return _json(result.stdout as String);
  stderr.writeln(
    'e2e: --code-for=$role faalde, gebruik de code uit de seed.\n'
    '${result.stderr}',
  );
  final user = (fixture['users'] as Map)[role] as Map;
  return {'email': user['email'], 'code': user['code']};
}

Future<bool> _isUp(String baseUrl) async {
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 1);
  try {
    final request = await client.getUrl(Uri.parse('$baseUrl/up'));
    final response = await request.close();
    await response.drain<void>();
    return true;
  } on Object {
    return false;
  } finally {
    client.close(force: true);
  }
}

Future<bool> _waitUp(String baseUrl) async {
  for (var i = 0; i < 60; i++) {
    if (await _isUp(baseUrl)) return true;
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
  return false;
}

/// Een opgestarte iPhone-simulator, anders "iPhone 16" (of de eerste
/// beschikbare iPhone) opstarten.
Future<String> _simulator() async {
  final result = await Process.run('xcrun', [
    'simctl',
    'list',
    'devices',
    'available',
    '-j',
  ]);
  if (result.exitCode != 0) _fail('xcrun simctl werkt niet (Xcode nodig).');
  final runtimes =
      (jsonDecode(result.stdout as String) as Map)['devices'] as Map;
  final phones = [
    for (final MapEntry(:key, :value) in runtimes.entries)
      if ((key as String).contains('iOS'))
        for (final d in value as List)
          if (((d as Map)['name'] as String).startsWith('iPhone')) d,
  ];
  if (phones.isEmpty) _fail('Geen iPhone-simulator beschikbaar.');
  final booted = phones.where((d) => d['state'] == 'Booted');
  if (booted.isNotEmpty) return booted.first['udid'] as String;
  final pick = phones.firstWhere(
    (d) => d['name'] == 'iPhone 16',
    orElse: () => phones.first,
  );
  final udid = pick['udid'] as String;
  _log('Simulator ${pick['name']} opstarten …');
  await Process.run('xcrun', ['simctl', 'boot', udid]);
  await Process.run('xcrun', ['simctl', 'bootstatus', udid, '-b']);
  return udid;
}

Future<int> _stream(String executable, List<String> args) async {
  final process = await Process.start(
    executable,
    args,
    mode: ProcessStartMode.inheritStdio,
  );
  return process.exitCode;
}
