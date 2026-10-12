import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

/// Geeft de statistieken-CSV als bestand aan het systeem-deelmenu (bewaren in
/// Bestanden, mailen, AirDrop, …). Achter een provider zodat tests hem kunnen
/// vervangen.
class StatsCsvSharer {
  const StatsCsvSharer();

  /// [origin] is het anker van het deelmenu op iPad.
  Future<void> share(Uint8List bytes, String filename, {Rect? origin}) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile.fromData(bytes, mimeType: 'text/csv', name: filename)],
        fileNameOverrides: [filename],
        sharePositionOrigin: origin,
      ),
    );
  }
}

final statsCsvSharerProvider = Provider<StatsCsvSharer>(
  (ref) => const StatsCsvSharer(),
);
