import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../data/models/savings_models.dart';
import '../data/savings_repository.dart';

/// Laadt opnieuw via [load] en zet het resultaat in [set]. Met data in beeld
/// blijft die staan bij een fout; geeft de fout terug (of `null`).
Future<Object?> _reload<T>({
  required T? current,
  required void Function() invalidate,
  required Future<T> Function() future,
  required Future<T> Function() load,
  required void Function(T value) set,
}) async {
  if (current == null) {
    invalidate();
    try {
      await future();
      return null;
    } on Object catch (error) {
      return error;
    }
  }
  try {
    set(await load());
    return null;
  } on Object catch (error) {
    return error;
  }
}

/// De potten van team [teamId]. Schrijven (een pot aanmaken) is nooit
/// optimistisch: na een gelukt verzoek wordt het overzicht opnieuw opgehaald.
class SavingsListController extends AsyncNotifier<SavingsOverview> {
  SavingsListController(this.teamId);

  final int teamId;

  SavingsRepository get _repository => ref.read(savingsRepositoryProvider);

  @override
  Future<SavingsOverview> build() {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een vers overzicht.
    ref.watch(authControllerProvider);
    return ref.watch(savingsRepositoryProvider).fetchOverview(teamId);
  }

  Future<Object?> refresh() => _reload(
    current: state.value,
    invalidate: ref.invalidateSelf,
    future: () => future,
    load: () => _repository.fetchOverview(teamId),
    set: (value) => state = AsyncData(value),
  );

  /// Een pot aanmaken. Geeft de nieuwe pot terug, of de fout.
  Future<({SavingsPot? pot, Object? error})> createPot(
    SavingsPotDraft draft,
  ) async {
    final SavingsPot pot;
    try {
      pot = await _repository.createPot(teamId, draft);
    } on Object catch (error) {
      return (pot: null, error: error);
    }
    await refresh();
    return (pot: pot, error: null);
  }
}

/// Het overzicht per team-id. Geen automatische retry: het scherm toont een
/// fout met "Opnieuw proberen".
final savingsListControllerProvider =
    AsyncNotifierProvider.family<SavingsListController, SavingsOverview, int>(
      SavingsListController.new,
      retry: (retryCount, error) => null,
    );

/// Welke pot een detail laat zien.
typedef SavingsPotRef = ({int teamId, int potId});

/// Wat het detail van één pot nu weet.
class SavingsPotState {
  const SavingsPotState({required this.detail, this.pending = const {}});

  final SavingsPotDetail detail;

  /// Cellen (`key|ym`) en refund-keys waarvoor een verzoek loopt.
  final Set<String> pending;

  SavingsPotState copyWith({SavingsPotDetail? detail, Set<String>? pending}) =>
      SavingsPotState(
        detail: detail ?? this.detail,
        pending: pending ?? this.pending,
      );
}

/// Eén pot: laden, verversen en de penningmeester-acties.
///
/// Een cel aftikken past de cel aan met wat de server teruggeeft (niet
/// optimistisch: tot het antwoord er is staat de cel op "bezig"). De overige
/// acties halen daarna de hele pot opnieuw op. Na elke schrijfactie wordt
/// ook het overzicht ververst (`saved_cents`, `member_count`).
///
/// Acties geven de fout terug (of `null` als het lukte).
class SavingsPotController extends AsyncNotifier<SavingsPotState> {
  SavingsPotController(this.arg);

  final SavingsPotRef arg;

  SavingsRepository get _repository => ref.read(savingsRepositoryProvider);

  @override
  Future<SavingsPotState> build() async {
    ref.watch(authControllerProvider);
    final detail = await ref
        .watch(savingsRepositoryProvider)
        .fetchPot(arg.teamId, arg.potId);
    return SavingsPotState(detail: detail);
  }

  Future<Object?> refresh() => _reload<SavingsPotDetail>(
    current: state.value?.detail,
    invalidate: ref.invalidateSelf,
    future: () async => (await future).detail,
    load: () => _repository.fetchPot(arg.teamId, arg.potId),
    set: (detail) {
      final latest = state.value;
      state = AsyncData(
        latest == null
            ? SavingsPotState(detail: detail)
            : latest.copyWith(detail: detail),
      );
    },
  );

  void _setPending(String id, {required bool on}) {
    final current = state.value;
    if (current == null) return;
    final pending = {...current.pending};
    on ? pending.add(id) : pending.remove(id);
    state = AsyncData(current.copyWith(pending: pending));
  }

  /// Cel [key]×[ym] omzetten. Loopt er al een verzoek voor die cel, dan
  /// gebeurt er niets.
  Future<Object?> togglePayment(String key, String ym) async {
    final current = state.value;
    final cell = cellKey(key, ym);
    if (current == null || current.pending.contains(cell)) return null;
    _setPending(cell, on: true);
    try {
      final result = await _repository.togglePayment(
        arg.teamId,
        arg.potId,
        key: key,
        ym: ym,
      );
      final latest = state.value;
      if (latest != null) {
        final payments = [
          for (final p in latest.detail.payments)
            if (p.key != result.key || p.ym != result.ym) p,
          if (result.paid)
            SavingsPayment(
              key: result.key,
              ym: result.ym,
              cents: result.cents ?? latest.detail.pot.amountCents,
            ),
        ];
        state = AsyncData(
          latest.copyWith(
            detail: latest.detail.copyWith(payments: payments),
            pending: {...latest.pending}..remove(cell),
          ),
        );
      }
      ref.invalidate(savingsListControllerProvider(arg.teamId));
      return null;
    } on Object catch (error) {
      _setPending(cell, on: false);
      return error;
    }
  }

  /// Deelnemer [key] (met `refund: true`) op terugbetaald zetten of terug.
  Future<Object?> setRefunded(String key, {required bool refunded}) async {
    final id = 'refund|$key';
    if (state.value?.pending.contains(id) ?? false) return null;
    _setPending(id, on: true);
    final error = await _write(
      () => _repository.refundPayment(
        arg.teamId,
        arg.potId,
        key: key,
        refunded: refunded,
      ),
    );
    _setPending(id, on: false);
    return error;
  }

  /// Herinnering sturen; geeft het aantal ontvangers of de fout.
  Future<({int sent, Object? error})> remind() async {
    try {
      final sent = await _repository.remind(arg.teamId, arg.potId);
      return (sent: sent, error: null);
    } on Object catch (error) {
      return (sent: 0, error: error);
    }
  }

  Future<Object?> updatePot(SavingsPotDraft draft) =>
      _write(() => _repository.updatePot(arg.teamId, arg.potId, draft));

  Future<Object?> settle(int actualCostCents) => _write(
    () => _repository.settle(
      arg.teamId,
      arg.potId,
      actualCostCents: actualCostCents,
    ),
  );

  Future<Object?> unsettle() =>
      _write(() => _repository.unsettle(arg.teamId, arg.potId));

  /// Archiveren. Bij succes verdwijnt de pot uit het overzicht; het scherm
  /// sluit het detail.
  Future<Object?> archive() async {
    try {
      await _repository.archivePot(arg.teamId, arg.potId);
    } on Object catch (error) {
      return error;
    }
    ref.invalidate(savingsListControllerProvider(arg.teamId));
    return null;
  }

  /// Voert [request] uit en haalt daarna pot en overzicht opnieuw op. Een
  /// fout bij dat verversen telt niet als mislukte actie.
  Future<Object?> _write(Future<void> Function() request) async {
    try {
      await request();
    } on Object catch (error) {
      return error;
    }
    ref.invalidate(savingsListControllerProvider(arg.teamId));
    await refresh();
    return null;
  }
}

/// Het detail per (team, pot); weg zodra het scherm dicht is.
final savingsPotControllerProvider = AsyncNotifierProvider.autoDispose
    .family<SavingsPotController, SavingsPotState, SavingsPotRef>(
      SavingsPotController.new,
      retry: (retryCount, error) => null,
    );

/// Wat het formulier laadt: nieuw (met optioneel een activiteit) of bewerken.
typedef SavingsFormQuery = ({int teamId, int? potId, int? eventId});

/// De keuzelijsten (en bij bewerken de huidige waarden) van het formulier.
final savingsFormOptionsProvider = FutureProvider.autoDispose
    .family<SavingsFormOptions, SavingsFormQuery>((ref, query) {
      final repository = ref.watch(savingsRepositoryProvider);
      final potId = query.potId;
      return potId == null
          ? repository.fetchCreateOptions(query.teamId, eventId: query.eventId)
          : repository.fetchEditOptions(query.teamId, potId);
    }, retry: (retryCount, error) => null);
