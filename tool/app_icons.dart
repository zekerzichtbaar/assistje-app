// Bakt de clubwapens in als alternatieve iOS-app-iconen.
//
// iOS laat een app alleen wisselen tussen iconen die in de build zitten
// (`setAlternateIconName`); een logo downloaden en als icoon zetten kan niet.
// Dit script haalt daarom vóór een release alle clublogo's op via
// `GET /api/v1/app-icons` (vogels3 `docs/api/v1/app-icons.md`) en schrijft per
// club een `ClubIcon-<id>.appiconset` in `ios/Runner/Assets.xcassets`. Xcode
// neemt ze mee via `ASSETCATALOG_COMPILER_INCLUDE_ALL_APPICON_ASSETS`.
//
// Klein gehouden: alleen de beginschermformaten (iPhone 120/180 px, iPad
// 152/167 px), als palet-PNG. App thinning levert per toestel alleen het
// passende formaat. De sets staan in .gitignore: draai dit voor elke release.
//
//   dart run tool/app_icons.dart                      # productie-API
//   dart run tool/app_icons.dart --api http://localhost:8000/api/v1
//   dart run tool/app_icons.dart --clean              # alle clubiconen weg
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;

const _catalog = 'ios/Runner/Assets.xcassets';
const _prefix = 'ClubIcon-';
const _cacheFile = '.dart_tool/app_icons/manifest.json';

/// Bestandsnaam → (idiom, size in pt, scale) → pixels.
const _renditions = [
  ('iphone', '60x60', '2x', 120),
  ('iphone', '60x60', '3x', 180),
  ('ipad', '76x76', '2x', 152),
  ('ipad', '83.5x83.5', '2x', 167),
];

/// Ruimte rond het wapen: iOS rondt de hoeken af en een wapen tegen de rand
/// oogt gekneld.
const _padding = 0.14;

Future<void> main(List<String> args) async {
  if (args.contains('--clean')) {
    final removed = _existingSets().length;
    for (final dir in _existingSets()) {
      dir.deleteSync(recursive: true);
    }
    File(_cacheFile).deleteSyncIfExists();
    stdout.writeln('$removed clubiconen verwijderd.');
    return;
  }

  final api =
      _option(args, '--api') ?? _apiFromEnv() ?? 'https://assistje.nl/api/v1';
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 20);
  try {
    final clubs = await _fetchList(client, '$api/app-icons');
    final cache = _readCache();
    final keep = <String>{};
    var written = 0, skipped = 0, failed = 0;

    for (final club in clubs) {
      final id = club['club_id'] as int;
      final url = club['logo_url'] as String?;
      final stamp = club['updated_at'] as String? ?? '';
      final name = '$_prefix$id';
      if (url == null) continue;
      keep.add(name);
      final dir = Directory('$_catalog/$name.appiconset');
      if (cache[name] == stamp && dir.existsSync()) {
        skipped++;
        continue;
      }
      try {
        final logo = img.decodeImage(await _download(client, url));
        if (logo == null) throw const FormatException('onbekend beeldformaat');
        _writeSet(dir, logo);
        cache[name] = stamp;
        written++;
      } on Object catch (error) {
        failed++;
        stderr.writeln('club $id (${club['name']}): $error');
      }
    }

    // Clubs die niet meer in de lijst staan: weg.
    for (final dir in _existingSets()) {
      final name = dir.uri.pathSegments.lastWhere((s) => s.isNotEmpty);
      if (!keep.contains(name.replaceAll('.appiconset', ''))) {
        dir.deleteSync(recursive: true);
      }
    }
    cache.removeWhere((name, _) => !keep.contains(name));
    _writeCache(cache);

    stdout.writeln(
      '${clubs.length} clubs: $written nieuw/bijgewerkt, $skipped ongewijzigd, '
      '$failed mislukt.',
    );
    // Eén onleesbaar wapen mag een release niet tegenhouden (die club houdt
    // dan het standaardicoon); niets bruikbaars wel.
    if (clubs.isNotEmpty && written + skipped == 0) exitCode = 1;
  } finally {
    client.close();
  }
}

/// Schrijft één iconenset: wapen gecentreerd op wit, per formaat geschaald.
void _writeSet(Directory dir, img.Image logo) {
  dir.createSync(recursive: true);
  final images = <Map<String, String>>[];
  for (final (idiom, size, scale, px) in _renditions) {
    final file = 'icon-$px.png';
    File('${dir.path}/$file').writeAsBytesSync(_render(logo, px));
    images.add({
      'idiom': idiom,
      'size': size,
      'scale': scale,
      'filename': file,
    });
  }
  File('${dir.path}/Contents.json').writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert({
      'images': images,
      'info': {'author': 'tool/app_icons.dart', 'version': 1},
    }),
  );
}

List<int> _render(img.Image logo, int px) {
  final inner = (px * (1 - 2 * _padding)).round();
  final scale = inner / (logo.width > logo.height ? logo.width : logo.height);
  final fitted = img.copyResize(
    logo,
    width: (logo.width * scale).round(),
    height: (logo.height * scale).round(),
    interpolation: img.Interpolation.cubic,
  );
  // App-iconen zijn ondoorzichtig: wit vlak eronder.
  final canvas = img.Image(width: px, height: px)
    ..clear(img.ColorRgb8(255, 255, 255));
  img.compositeImage(
    canvas,
    fitted,
    dstX: (px - fitted.width) ~/ 2,
    dstY: (px - fitted.height) ~/ 2,
  );
  final rgb = canvas.convert(numChannels: 3);
  return img.encodePng(img.quantize(rgb), level: 9);
}

Future<List<Map<String, dynamic>>> _fetchList(
  HttpClient client,
  String url,
) async {
  final body = utf8.decode(await _download(client, url, json: true));
  final data = (jsonDecode(body) as Map<String, dynamic>)['data'] as List;
  return data.cast<Map<String, dynamic>>();
}

Future<Uint8List> _download(
  HttpClient client,
  String url, {
  bool json = false,
}) async {
  final request = await client.getUrl(Uri.parse(url));
  if (json) request.headers.set(HttpHeaders.acceptHeader, 'application/json');
  final response = await request.close();
  if (response.statusCode != 200) {
    await response.drain<void>();
    throw HttpException('HTTP ${response.statusCode}', uri: Uri.parse(url));
  }
  final bytes = BytesBuilder(copy: false);
  await for (final chunk in response) {
    bytes.add(chunk);
  }
  return bytes.takeBytes();
}

Iterable<Directory> _existingSets() {
  final catalog = Directory(_catalog);
  if (!catalog.existsSync()) return const [];
  return catalog.listSync().whereType<Directory>().where(
    (d) => d.path.split('/').last.startsWith(_prefix),
  );
}

Map<String, String> _readCache() {
  final file = File(_cacheFile);
  if (!file.existsSync()) return {};
  return (jsonDecode(file.readAsStringSync()) as Map<String, dynamic>).map(
    (k, v) => MapEntry(k, v as String),
  );
}

void _writeCache(Map<String, String> cache) {
  File(_cacheFile)
    ..createSync(recursive: true)
    ..writeAsStringSync(jsonEncode(cache));
}

String? _option(List<String> args, String name) {
  final i = args.indexOf(name);
  return i >= 0 && i + 1 < args.length ? args[i + 1] : null;
}

/// `API_BASE_URL` uit `env/prod.json`, zodat er één bron van waarheid is.
String? _apiFromEnv() {
  final file = File('env/prod.json');
  if (!file.existsSync()) return null;
  return (jsonDecode(file.readAsStringSync())
          as Map<String, dynamic>)['API_BASE_URL']
      as String?;
}

extension on File {
  void deleteSyncIfExists() {
    if (existsSync()) deleteSync();
  }
}
