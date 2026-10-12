import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Naam van dit toestel voor het Sanctum-token (zichtbaar in een latere
/// tokenoverzicht). Bewust simpel: geen extra dependency voor het model.
String platformDeviceName([TargetPlatform? platform]) {
  return switch (platform ?? defaultTargetPlatform) {
    TargetPlatform.iOS => 'iPhone',
    TargetPlatform.android => 'Android',
    _ => 'Assistje-app',
  };
}

final deviceNameProvider = Provider<String>((ref) => platformDeviceName());
