import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../data/agreements_repository.dart';
import '../data/models/agreements_models.dart';

/// De afspraken van team [teamId]: laden, verversen en de trainer-acties.
/// Schrijven is nooit optimistisch: na elk gelukt verzoek wordt de lijst
/// opnieuw opgehaald (de server bepaalt groepen en volgorde).
///
/// Acties geven de fout terug (of `null` als het lukte), zodat het scherm of
/// formulier hem kan tonen.
class AgreementsController extends AsyncNotifier<AgreementsOverview> {
  AgreementsController(this.teamId);

  final int teamId;

  AgreementsRepository get _repository =>
      ref.read(agreementsRepositoryProvider);

  @override
  Future<AgreementsOverview> build() {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een verse lijst.
    ref.watch(authControllerProvider);
    return ref.watch(agreementsRepositoryProvider).fetch(teamId);
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

  Future<Object?> createAgreement(AgreementDraft draft) =>
      _write(() => _repository.create(teamId, draft));

  Future<Object?> updateAgreement(int agreementId, AgreementDraft draft) =>
      _write(() => _repository.update(teamId, agreementId, draft));

  Future<Object?> deleteAgreement(int agreementId) =>
      _write(() => _repository.delete(teamId, agreementId));

  Future<Object?> updateIntro(String intro) =>
      _write(() => _repository.updateIntro(teamId, intro));

  /// Voert [request] uit en haalt daarna de lijst opnieuw op. Een fout bij
  /// dat verversen telt niet als mislukte actie.
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

/// De afspraken per team-id. Geen automatische retry: het scherm toont een
/// fout met "Opnieuw proberen".
final agreementsControllerProvider =
    AsyncNotifierProvider.family<AgreementsController, AgreementsOverview, int>(
      AgreementsController.new,
      retry: (retryCount, error) => null,
    );
