import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../session/session_providers.dart';

/// Of het clubwapen als app-icoon kan, en of het nu staat.
@immutable
class ClubIconState {
  const ClubIconState({required this.name, required this.active});

  /// Naam van het alternatieve icoon (`ClubIcon-<clubId>`).
  final String name;
  final bool active;
}

/// Het app-icoon wisselen (iOS, `AppIconChannel` in AppDelegate.swift).
///
/// iOS laat alleen iconen toe die in de build zitten; `tool/app_icons.dart`
/// bakt daarom alle clubwapens in als `ClubIcon-<clubId>`. Op andere
/// platformen is er niets te wisselen.
class AppIconService {
  const AppIconService([this._channel = const MethodChannel(channelName)]);

  static const channelName = 'nl.assistje.app/app_icon';

  final MethodChannel _channel;

  static String clubIconName(int clubId) => 'ClubIcon-$clubId';

  /// `null` als dit toestel niet kan wisselen of het wapen niet in de build
  /// zit.
  Future<ClubIconState?> clubIcon(int clubId) async {
    if (defaultTargetPlatform != TargetPlatform.iOS) return null;
    final name = clubIconName(clubId);
    try {
      final status = await _channel.invokeMapMethod<String, Object?>('status', {
        'name': name,
      });
      if (status == null ||
          status['supported'] != true ||
          status['available'] != true) {
        return null;
      }
      return ClubIconState(name: name, active: status['current'] == name);
    } on MissingPluginException {
      return null;
    }
  }

  /// Zet het icoon op [name], of terug naar het standaardicoon met `null`.
  Future<void> setIcon(String? name) =>
      _channel.invokeMethod<void>('set', {'name': name});
}

final appIconServiceProvider = Provider<AppIconService>(
  (ref) => const AppIconService(),
);

/// Het clubicoon van het huidige team, of `null` als dat niet kan.
final clubIconProvider = FutureProvider.autoDispose<ClubIconState?>((ref) {
  final clubId = ref.watch(currentMembershipProvider)?.team.clubId;
  if (clubId == null) return null;
  return ref.watch(appIconServiceProvider).clubIcon(clubId);
});
