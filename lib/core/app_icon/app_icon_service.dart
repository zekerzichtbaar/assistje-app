import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../session/session_providers.dart';
import 'club_logo_repository.dart';

/// Hoe het clubwapen op het beginscherm komt.
enum AppIconMode {
  /// iOS: het app-icoon zelf wisselen naar een wapen dat in de build zit.
  alternate,

  /// Android: een vastgezette snelkoppeling met het gedownloade logo; het
  /// gewone icoon blijft in de app-lade.
  shortcut,
}

/// Wat het afzetten na een [AppIconService.pinShortcut] opleverde.
enum PinShortcutResult {
  /// De launcher vraagt de gebruiker om de snelkoppeling te bevestigen.
  requested,

  /// De snelkoppeling stond er al; het logo is bijgewerkt.
  updated,
}

/// Of het clubwapen op het beginscherm kan, en of het er nu staat.
@immutable
class ClubIconState {
  const ClubIconState({
    required this.name,
    required this.active,
    this.mode = AppIconMode.alternate,
    this.logoUrl,
  });

  /// iOS: naam van het alternatieve icoon (`ClubIcon-<clubId>`); Android: id
  /// van de snelkoppeling (`club-<clubId>`).
  final String name;

  /// iOS: dit icoon staat nu; Android: de snelkoppeling staat al op het
  /// beginscherm.
  final bool active;
  final AppIconMode mode;

  /// Het clublogo ([AppIconMode.shortcut]): voorbeeld en bron van het icoon.
  final String? logoUrl;

  ClubIconState withLogo(String url) =>
      ClubIconState(name: name, active: active, mode: mode, logoUrl: url);
}

/// Het clubwapen op het beginscherm (kanaal `nl.assistje.app/app_icon`).
///
/// - iOS (`AppIconChannel` in AppDelegate.swift) laat alleen iconen toe die in
///   de build zitten; `tool/app_icons.dart` bakt daarom alle clubwapens in als
///   `ClubIcon-<clubId>` en [setIcon] wisselt ertussen.
/// - Android (`AppIconChannel.kt`) zet een snelkoppeling met het clublogo op
///   het beginscherm ([pinShortcut]); er zit niets in de build.
class AppIconService {
  const AppIconService([this._channel = const MethodChannel(channelName)]);

  static const channelName = 'nl.assistje.app/app_icon';

  final MethodChannel _channel;

  static String clubIconName(int clubId) => 'ClubIcon-$clubId';

  static String shortcutId(int clubId) => 'club-$clubId';

  /// `null` als dit toestel het niet kan of (iOS) het wapen niet in de build
  /// zit. Bij [AppIconMode.shortcut] ontbreekt [ClubIconState.logoUrl] nog;
  /// die zoekt [clubIconProvider] op.
  Future<ClubIconState?> clubIcon(int clubId) async {
    final String name;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        name = clubIconName(clubId);
      case TargetPlatform.android:
        name = shortcutId(clubId);
      default:
        return null;
    }
    try {
      final status = await _channel.invokeMapMethod<String, Object?>('status', {
        'name': name,
      });
      if (status == null ||
          status['supported'] != true ||
          status['available'] != true) {
        return null;
      }
      return ClubIconState(
        name: name,
        active: status['current'] == name,
        mode: status['mode'] == 'shortcut'
            ? AppIconMode.shortcut
            : AppIconMode.alternate,
      );
    } on MissingPluginException {
      return null;
    }
  }

  /// iOS: zet het icoon op [name], of terug naar het standaardicoon met
  /// `null`.
  Future<void> setIcon(String? name) =>
      _channel.invokeMethod<void>('set', {'name': name});

  /// Android: zet een snelkoppeling [id] met [label] en het logo [png] op het
  /// beginscherm, of werkt hem bij als hij er al staat.
  Future<PinShortcutResult> pinShortcut({
    required String id,
    required String label,
    required Uint8List png,
  }) async {
    final result = await _channel.invokeMethod<String>('pinShortcut', {
      'id': id,
      'label': label,
      'png': png,
    });
    return result == 'updated'
        ? PinShortcutResult.updated
        : PinShortcutResult.requested;
  }
}

final appIconServiceProvider = Provider<AppIconService>(
  (ref) => const AppIconService(),
);

/// Het clubicoon van het huidige team, of `null` als dat niet kan (ook:
/// Android zonder bruikbaar clublogo).
final clubIconProvider = FutureProvider.autoDispose<ClubIconState?>((
  ref,
) async {
  final clubId = ref.watch(currentMembershipProvider)?.team.clubId;
  if (clubId == null) return null;
  final service = ref.watch(appIconServiceProvider);
  final logos = ref.watch(clubLogoRepositoryProvider);
  final icon = await service.clubIcon(clubId);
  if (icon == null || icon.mode == AppIconMode.alternate) return icon;
  final url = await logos.logoUrl(clubId);
  return url == null ? null : icon.withLogo(url);
});
