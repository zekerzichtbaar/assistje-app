import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_controller.dart';
import '../session/session_providers.dart';
import '../theme/theme_providers.dart';

/// Of het clubwapen van het huidige team als app-icoon kan, en of het nu
/// staat.
@immutable
class ClubIconState {
  const ClubIconState({required this.name, required this.active});

  /// `ClubIcon-<clubId>`.
  final String name;

  /// Dit icoon staat nu (of wordt gezet zodra de app naar de achtergrond
  /// gaat, Android).
  final bool active;
}

/// Het app-icoon (kanaal `nl.assistje.app/app_icon`): het standaardicoon of
/// het wapen van een club. Beide platformen kunnen alleen wisselen naar
/// iconen die in de build zitten; `tool/app_icons.dart` bakt ze in.
///
/// - iOS (`AppIconChannel` in AppDelegate.swift): alternatieve iconen
///   `ClubIcon-<clubId>`; iOS toont na een wissel zelf een melding.
/// - Android (`AppIconChannel.kt`): per club een `activity-alias`
///   (gegenereerde module `android/club_icons`); de wissel gebeurt pas als de
///   app naar de achtergrond gaat.
///
/// `status {name?}` → `{supported, current, available}`; `set {name}` met
/// `null` = standaardicoon.
class AppIconService {
  const AppIconService([this._channel = const MethodChannel(channelName)]);

  static const channelName = 'nl.assistje.app/app_icon';

  final MethodChannel _channel;

  static String clubIconName(int clubId) => 'ClubIcon-$clubId';

  static bool get _platformSupported =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android;

  Future<Map<String, Object?>?> _status(String? name) async {
    if (!_platformSupported) return null;
    try {
      final status = await _channel.invokeMapMethod<String, Object?>('status', {
        'name': name,
      });
      if (status == null || status['supported'] != true) return null;
      return status;
    } on MissingPluginException {
      return null;
    }
  }

  /// `null` als dit toestel het niet kan of het wapen van [clubId] niet in de
  /// build zit.
  Future<ClubIconState?> clubIcon(int clubId) async {
    final name = clubIconName(clubId);
    final status = await _status(name);
    if (status == null || status['available'] != true) return null;
    return ClubIconState(name: name, active: status['current'] == name);
  }

  /// Zet het icoon op [name] (`null` = standaardicoon), alleen als dat nodig
  /// is: iOS toont bij elke wissel een melding. Zit [name] niet in de build,
  /// dan wordt het het standaardicoon.
  Future<void> apply(String? name) async {
    final status = await _status(name);
    if (status == null) return;
    final target = name != null && status['available'] == true ? name : null;
    if (status['current'] == target) return;
    await _channel.invokeMethod<void>('set', {'name': target});
  }
}

final appIconServiceProvider = Provider<AppIconService>(
  (ref) => const AppIconService(),
);

/// Of de gebruiker het clubwapen als app-icoon wil (standaard: ja). Uit in
/// Profiel → *App-icoon*.
class ClubAppIconEnabledNotifier extends Notifier<bool> {
  static const String storageKey = 'club_app_icon_enabled';

  @override
  bool build() =>
      ref.read(sharedPreferencesProvider).getBool(storageKey) ?? true;

  Future<void> set({required bool enabled}) async {
    state = enabled;
    await ref.read(sharedPreferencesProvider).setBool(storageKey, enabled);
  }
}

final clubAppIconEnabledProvider =
    NotifierProvider<ClubAppIconEnabledNotifier, bool>(
      ClubAppIconEnabledNotifier.new,
    );

/// Het icoon dat er hoort te staan, of `null` als dat nog niet vaststaat
/// (inloggen of `/me` laden nog bezig, `/me` mislukt). Zo wisselt een
/// koude start niet eerst naar het standaardicoon en dan terug.
@visibleForTesting
final desiredAppIconProvider = Provider<({String? name})?>((ref) {
  final status = ref.watch(authControllerProvider);
  if (status == AuthStatus.signedOut) return (name: null);
  if (status != AuthStatus.signedIn) return null;
  final me = ref.watch(meProvider);
  if (me.isLoading || me.hasError || !me.hasValue) return null;
  final clubId = ref.watch(currentMembershipProvider)?.team.clubId;
  if (clubId == null || !ref.watch(clubAppIconEnabledProvider)) {
    return (name: null);
  }
  return (name: AppIconService.clubIconName(clubId));
});

/// Houdt het app-icoon gelijk aan de club van het actieve team: na inloggen
/// en bij een teamwissel het clubwapen, na uitloggen (of met de schakelaar
/// uit) het standaardicoon. `AssistjeApp` houdt deze provider actief.
///
/// Elke keer dat de app terug naar de voorgrond komt, wordt het nog eens
/// gecontroleerd: iOS weigert een wissel die te vroeg bij een koude start of
/// vanuit de achtergrond komt, en zonder herpoging bleef dan het
/// standaardicoon staan. [AppIconService.apply] wisselt alleen als het nodig
/// is, dus dit geeft geen extra iOS-meldingen.
final appIconSyncProvider = Provider<void>((ref) {
  var queue = Future<void>.value();
  ({String? name})? desired;

  void sync() {
    final target = desired;
    if (target == null) return;
    final service = ref.read(appIconServiceProvider);
    // Na elkaar, zodat een snelle teamwissel geen wissels door elkaar haalt.
    queue = queue.then((_) => service.apply(target.name)).catchError((
      Object error,
    ) {
      debugPrint('App-icoon wisselen mislukt: $error');
    });
  }

  ref.listen<({String? name})?>(desiredAppIconProvider, (previous, next) {
    desired = next;
    sync();
  }, fireImmediately: true);

  final lifecycle = AppLifecycleListener(onResume: sync);
  ref.onDispose(lifecycle.dispose);
});

/// Het clubicoon van het huidige team, of `null` als dat niet kan.
final clubIconProvider = FutureProvider.autoDispose<ClubIconState?>((
  ref,
) async {
  final clubId = ref.watch(currentMembershipProvider)?.team.clubId;
  if (clubId == null) return null;
  // Opnieuw opvragen als de schakelaar omgaat.
  ref.watch(clubAppIconEnabledProvider);
  return ref.watch(appIconServiceProvider).clubIcon(clubId);
});
