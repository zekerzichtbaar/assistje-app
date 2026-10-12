import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../data/feedback_repository.dart';
import '../data/models/feedback_models.dart';

/// Je eigen meldingen, opgevraagd via team [teamId] (de lijst zelf is niet
/// team-gefilterd). Schrijven is nooit optimistisch: na een gelukt verzoek
/// komt de melding uit het antwoord van de server in de lijst.
///
/// Acties geven de fout terug (of `null` als het lukte), zodat het scherm of
/// formulier hem kan tonen.
class FeedbackController extends AsyncNotifier<List<FeedbackItem>> {
  FeedbackController(this.teamId);

  final int teamId;

  FeedbackRepository get _repository => ref.read(feedbackRepositoryProvider);

  @override
  Future<List<FeedbackItem>> build() {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een verse lijst.
    ref.watch(authControllerProvider);
    return ref.watch(feedbackRepositoryProvider).fetch(teamId);
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

  /// Stuurt een nieuwe melding in; die komt bovenaan de lijst.
  Future<Object?> submit(FeedbackDraft draft) async {
    try {
      final item = await _repository.submit(teamId, draft);
      _put(item, prepend: true);
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  /// Reageert op het antwoord onder melding [feedbackId].
  Future<Object?> respond(int feedbackId, String body) async {
    try {
      final item = await _repository.respond(teamId, feedbackId, body);
      _put(item);
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  /// Vervangt de melding met hetzelfde id, of zet hem bovenaan.
  void _put(FeedbackItem item, {bool prepend = false}) {
    final current = state.value ?? const <FeedbackItem>[];
    final index = current.indexWhere((existing) => existing.id == item.id);
    if (index >= 0) {
      state = AsyncData([...current]..[index] = item);
    } else {
      state = AsyncData(prepend ? [item, ...current] : [...current, item]);
    }
  }
}

/// De meldingen per team-id. Geen automatische retry: het scherm toont een
/// fout met "Opnieuw proberen".
final feedbackControllerProvider =
    AsyncNotifierProvider.family<FeedbackController, List<FeedbackItem>, int>(
      FeedbackController.new,
      retry: (retryCount, error) => null,
    );

/// De bytes van een schermafbeelding, per absolute `image_url`. Vrijgegeven
/// zodra hij uit beeld is; geen retry (het scherm toont dan een
/// placeholder).
final feedbackImageProvider = FutureProvider.autoDispose
    .family<Uint8List, String>(
      (ref, url) => ref.watch(feedbackRepositoryProvider).image(url),
      retry: (retryCount, error) => null,
    );
