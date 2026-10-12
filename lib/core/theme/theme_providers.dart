import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'team_color.dart';

/// De [SharedPreferences]-instantie; wordt in `main()` overschreven nadat hij
/// asynchroon is geladen, zodat de rest van de app hem synchroon kan lezen.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(
    'sharedPreferencesProvider moet in main() worden overschreven.',
  ),
);

/// Licht / donker / systeem, bewaard in shared_preferences — net als de
/// keuze "altijd licht / altijd donker / volg toestel" in de PWA.
class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const String storageKey = 'theme_mode';

  @override
  ThemeMode build() {
    final stored = ref.read(sharedPreferencesProvider).getString(storageKey);
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == stored,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;
    await ref.read(sharedPreferencesProvider).setString(storageKey, mode.name);
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

/// De kleur van het actieve team (`primary_color`, hex). Tot er een API en
/// teamwissel is, staat hij op de standaardkleur; een latere slice zet hem
/// vanuit `/api/v1/me`.
class TeamColorNotifier extends Notifier<String> {
  @override
  String build() => TeamColor.fallbackHex;

  void set(String hex) => state = hex;
}

final teamColorProvider = NotifierProvider<TeamColorNotifier, String>(
  TeamColorNotifier.new,
);
