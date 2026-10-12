import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../data/models/notification_models.dart';
import '../data/notification_preferences_repository.dart';

/// De pushvoorkeuren van de ingelogde gebruiker (accountniveau): laden en
/// per categorie optimistisch aan/uit zetten, met terugdraaien bij een fout.
class NotificationPreferencesController
    extends AsyncNotifier<NotificationPreferences> {
  /// Categorieën waarvan een PATCH onderweg is: hun optimistische stand
  /// wint van een (ouder) antwoord van de server op een andere categorie.
  final Map<String, bool> _inFlight = {};

  NotificationPreferencesRepository get _repository =>
      ref.read(notificationPreferencesRepositoryProvider);

  @override
  Future<NotificationPreferences> build() async {
    ref.watch(authControllerProvider);
    _inFlight.clear();
    return ref.watch(notificationPreferencesRepositoryProvider).fetch();
  }

  /// Opnieuw laden; geeft de fout terug (of `null`).
  Future<Object?> refresh() async {
    if (state.value == null) {
      ref.invalidateSelf();
      try {
        await future;
        return null;
      } on Object catch (error) {
        return error;
      }
    }
    try {
      final fresh = await _repository.fetch();
      state = AsyncData(_withInFlight(fresh));
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  /// Zet categorie [key] op [enabled]. Geeft de fout terug (of `null`).
  Future<Object?> toggle(String key, {required bool enabled}) async {
    final current = state.value;
    if (current == null) return null;
    final before = current.isEnabled(key);
    _inFlight[key] = enabled;
    state = AsyncData(current.withValue(key, enabled: enabled));
    try {
      final saved = await _repository.update(key, enabled: enabled);
      if (_inFlight[key] == enabled) _inFlight.remove(key);
      state = AsyncData(_withInFlight(saved));
      return null;
    } on Object catch (error) {
      if (_inFlight[key] == enabled) {
        _inFlight.remove(key);
        final latest = state.value;
        if (latest != null) {
          state = AsyncData(latest.withValue(key, enabled: before));
        }
      }
      return error;
    }
  }

  NotificationPreferences _withInFlight(NotificationPreferences prefs) {
    var next = prefs;
    for (final MapEntry(:key, :value) in _inFlight.entries) {
      next = next.withValue(key, enabled: value);
    }
    return next;
  }
}

final notificationPreferencesControllerProvider =
    AsyncNotifierProvider<
      NotificationPreferencesController,
      NotificationPreferences
    >(
      NotificationPreferencesController.new,
      retry: (retryCount, error) => null,
    );
