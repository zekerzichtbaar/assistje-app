import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show KeepAliveLink;

/// Native gevoel voor `autoDispose`-providers: bewaar de data nog even nadat
/// het laatste scherm hem loslaat.
///
/// Kom je binnen [duration] terug (weer naar dezelfde wedstrijd, speler,
/// instellingen), dan staat de bewaarde stand er meteen, zonder skeleton.
/// Is die ouder dan [staleAfter], dan ververst de provider stil op de
/// achtergrond: de schermen lezen `async.value` eerst, dus de oude stand
/// blijft staan tot de nieuwe binnen is.
///
/// Roep het aan bovenin `build` (ook na een rebuild: de keep-alive hoort bij
/// één build).
///
/// Bewust zonder timers: verlopen data wordt opgeruimd zodra een volgend
/// scherm iets loslaat. Zo blijft er nooit een timer hangen (ook niet in
/// widgettests) en kost het niets zolang je nergens heen gaat.
extension CacheForRef on Ref {
  void cacheFor(
    Duration duration, {
    Duration staleAfter = const Duration(seconds: 30),
  }) {
    final entry = _Parked(keepAlive(), duration);
    final loadedAt = cacheClock();
    var disposed = false;

    onCancel(() {
      _sweepSoon();
      entry.since = cacheClock();
      _parked.add(entry);
    });
    onResume(() {
      _parked.remove(entry);
      if (cacheClock().difference(loadedAt) >= staleAfter) {
        // Niet midden in de `watch` van het scherm invalideren.
        scheduleMicrotask(() {
          if (!disposed) invalidateSelf();
        });
      }
    });
    onDispose(() {
      disposed = true;
      _parked.remove(entry);
    });
  }
}

/// Standaard bewaartermijn voor detailschermen.
const kScreenCacheDuration = Duration(minutes: 5);

/// Klok voor de bewaartermijn (te vervangen in tests).
@visibleForTesting
DateTime Function() cacheClock = DateTime.now;

/// Ruimt nu alle verlopen bewaarde providers op (ook voor tests).
@visibleForTesting
void sweepExpiredCache() {
  final now = cacheClock();
  final expired = [
    for (final entry in _parked)
      if (now.difference(entry.since) >= entry.ttl) entry,
  ];
  for (final entry in expired) {
    _parked.remove(entry);
    entry.link.close();
  }
}

/// Providers die niemand meer bekijkt maar die nog bewaard worden.
final Set<_Parked> _parked = {};

void _sweepSoon() => scheduleMicrotask(sweepExpiredCache);

class _Parked {
  _Parked(this.link, this.ttl);

  final KeepAliveLink link;
  final Duration ttl;
  DateTime since = DateTime.now();
}
