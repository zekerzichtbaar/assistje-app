import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../data/messages_repository.dart';
import '../data/models/messages_models.dart';

/// Berichten van team [teamId]: geschiedenis, automatische meldingen en de
/// trainer-acties. Schrijven is nooit optimistisch: na elk gelukt verzoek
/// wordt het overzicht opnieuw opgehaald.
///
/// Acties geven de fout terug (of `null` als het lukte), zodat het scherm of
/// formulier hem kan tonen.
class MessagesController extends AsyncNotifier<MessagesOverview> {
  MessagesController(this.teamId);

  final int teamId;

  MessagesRepository get _repository => ref.read(messagesRepositoryProvider);

  @override
  Future<MessagesOverview> build() {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een vers overzicht.
    ref.watch(authControllerProvider);
    return ref.watch(messagesRepositoryProvider).fetch(teamId);
  }

  /// Opnieuw laden. Met data in beeld blijft die staan bij een fout.
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
      state = AsyncData(await _repository.fetch(teamId));
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  /// Verstuurt een bericht naar het hele team.
  Future<Object?> send(MessageDraft draft) =>
      _write(() => _repository.send(teamId, draft));

  /// Zet automatische melding [key] aan of uit.
  Future<Object?> setEnabled(String key, {required bool enabled}) =>
      _write(() => _repository.updateSetting(teamId, key, enabled: enabled));

  /// Bewaart eigen teksten; leeg = standaardtekst.
  Future<Object?> saveTemplates(
    String key, {
    required String title,
    required String body,
  }) => _write(
    () => _repository.updateSetting(
      teamId,
      key,
      titleTemplate: title,
      bodyTemplate: body,
    ),
  );

  /// Voert [request] uit en haalt daarna het overzicht opnieuw op. Een fout
  /// bij dat verversen telt niet als mislukte actie.
  Future<Object?> _write(Future<void> Function() request) async {
    try {
      await request();
    } on Object catch (error) {
      return error;
    }
    await refresh();
    return null;
  }
}

/// De berichten per team-id. Geen automatische retry: het scherm toont een
/// fout met "Opnieuw proberen".
final messagesControllerProvider =
    AsyncNotifierProvider.family<MessagesController, MessagesOverview, int>(
      MessagesController.new,
      retry: (retryCount, error) => null,
    );
