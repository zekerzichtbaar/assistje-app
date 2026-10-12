import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../data/fines_repository.dart';
import '../data/models/fines_models.dart';

/// Wat het boetepot-scherm van één team nu weet.
class FinesState {
  const FinesState({
    required this.overview,
    this.selectedPeriodId,
    this.switching = false,
  });

  final FinesOverview overview;

  /// De gekozen periode; `null` = de lopende (standaard van de server).
  final int? selectedPeriodId;

  /// Loopt er een periodewissel bij de server?
  final bool switching;

  FinesState copyWith({
    FinesOverview? overview,
    int? selectedPeriodId,
    bool? switching,
  }) => FinesState(
    overview: overview ?? this.overview,
    selectedPeriodId: selectedPeriodId ?? this.selectedPeriodId,
    switching: switching ?? this.switching,
  );

  /// Kijken we naar de lopende periode? (Nieuwe boetes landen altijd daar.)
  bool get isCurrentPeriod {
    final periods = overview.periods;
    if (selectedPeriodId == null || periods.isEmpty) return true;
    return periods.first.id == overview.period.id;
  }
}

/// De boetepot van team [teamId]: laden, verversen, periode kiezen en de
/// penningmeester-acties. Schrijven is nooit optimistisch: na elk gelukt
/// verzoek wordt het overzicht opnieuw opgehaald (de server rekent de pot).
///
/// Acties geven de fout terug (of `null` als het lukte), zodat het scherm
/// hem kan tonen.
class FinesController extends AsyncNotifier<FinesState> {
  FinesController(this.teamId);

  final int teamId;

  FinesRepository get _repository => ref.read(finesRepositoryProvider);

  @override
  Future<FinesState> build() async {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een verse pot.
    ref.watch(authControllerProvider);
    final overview = await ref
        .watch(finesRepositoryProvider)
        .fetchOverview(teamId);
    return FinesState(overview: overview);
  }

  /// Opnieuw laden voor de gekozen periode. Met data in beeld blijft die
  /// staan bij een fout.
  Future<Object?> refresh() async {
    final current = state.value;
    if (current == null) {
      ref.invalidateSelf();
      try {
        await future;
        return null;
      } on Object catch (error) {
        return error;
      }
    }
    try {
      final overview = await _repository.fetchOverview(
        teamId,
        periodId: current.selectedPeriodId,
      );
      final latest = state.value ?? current;
      state = AsyncData(latest.copyWith(overview: overview));
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  /// Naar periode [periodId]. Bij een fout blijft de vorige periode staan.
  Future<Object?> selectPeriod(int periodId) async {
    final current = state.value;
    if (current == null || current.overview.period.id == periodId) return null;
    state = AsyncData(current.copyWith(switching: true));
    try {
      final overview = await _repository.fetchOverview(
        teamId,
        periodId: periodId,
      );
      state = AsyncData(
        FinesState(overview: overview, selectedPeriodId: periodId),
      );
      return null;
    } on Object catch (error) {
      final latest = state.value ?? current;
      state = AsyncData(latest.copyWith(switching: false));
      return error;
    }
  }

  /// Een boete uitdelen aan [targets]. Geeft het aantal uitgedeelde boetes
  /// terug, of de fout.
  Future<({int count, Object? error})> recordFines({
    required FineTargets targets,
    required int typeId,
    int? amountCents,
    String? description,
  }) async {
    var count = 0;
    final error = await _write(() async {
      final fines = await _repository.recordFines(
        teamId,
        targets: targets,
        typeId: typeId,
        amountCents: amountCents,
        description: description,
      );
      count = fines.length;
    });
    return (count: count, error: error);
  }

  /// Een boete bijwerken (bedrag, omschrijving, status).
  Future<Object?> updateFine(
    int fineId, {
    int? amountCents,
    String? description,
    bool clearDescription = false,
    FineStatus? status,
  }) => _write(
    () => _repository.updateFine(
      teamId,
      fineId,
      amountCents: amountCents,
      description: description,
      clearDescription: clearDescription,
      status: status,
    ),
  );

  Future<Object?> deleteFine(int fineId) =>
      _write(() => _repository.deleteFine(teamId, fineId));

  Future<Object?> createPotEntry(PotEntryDraft draft) =>
      _write(() => _repository.createPotEntry(teamId, draft));

  Future<Object?> updatePotEntry(int entryId, PotEntryDraft draft) =>
      _write(() => _repository.updatePotEntry(teamId, entryId, draft));

  Future<Object?> deletePotEntry(int entryId) =>
      _write(() => _repository.deletePotEntry(teamId, entryId));

  // ── Beheer (penningmeester) ──────────────────────────────────────────

  /// Een nieuwe periode beginnen (sluit de lopende af). Daarna staat de
  /// nieuwe, lopende periode in beeld.
  Future<Object?> createPeriod(String name) => _write(
    () => _repository.createPeriod(teamId, name: name),
    toCurrentPeriod: true,
  );

  /// Periode [periodId] hernoemen; de gekozen periode blijft in beeld.
  Future<Object?> renamePeriod(int periodId, String name) =>
      _write(() => _repository.renamePeriod(teamId, periodId, name: name));

  /// Periode [periodId] afsluiten. Daarna staat de nieuwe lopende periode in
  /// beeld (iedereen begint weer bij nul).
  Future<Object?> closePeriod(int periodId) => _write(
    () => _repository.closePeriod(teamId, periodId),
    toCurrentPeriod: true,
  );

  /// De standaardbedragen per soort opslaan ([amounts]: id → centen).
  Future<Object?> updateFineSettings(Map<int, int> amounts) =>
      _write(() => _repository.updateFineSettings(teamId, amounts));

  /// Een eigen boetesoort toevoegen.
  Future<Object?> createFineType({
    required String label,
    required int amountCents,
  }) => _write(
    () => _repository.createFineType(
      teamId,
      label: label,
      amountCents: amountCents,
    ),
  );

  /// Een soort hernoemen, een ander bedrag geven of aan/uit zetten.
  Future<Object?> updateFineType(
    int typeId, {
    String? label,
    int? amountCents,
    bool? active,
  }) => _write(
    () => _repository.updateFineType(
      teamId,
      typeId,
      label: label,
      amountCents: amountCents,
      active: active,
    ),
  );

  /// Een handmatige soort weghalen. [archived] zegt of hij (vanwege oude
  /// boetes) alleen uit de lijst is gehaald.
  Future<({bool archived, Object? error})> deleteFineType(int typeId) async {
    var archived = false;
    final error = await _write(() async {
      archived = await _repository.deleteFineType(teamId, typeId);
    });
    return (archived: archived, error: error);
  }

  /// Voert [request] uit en haalt daarna het overzicht opnieuw op. Een fout
  /// bij dat verversen telt niet als mislukte actie. Met [toCurrentPeriod]
  /// komt daarna de lopende periode in beeld (na een nieuwe of afgesloten
  /// periode is dat een andere dan ervoor).
  Future<Object?> _write(
    Future<void> Function() request, {
    bool toCurrentPeriod = false,
  }) async {
    try {
      await request();
    } on Object catch (error) {
      return error;
    }
    // Details van personen kunnen veranderd zijn.
    ref.invalidate(personFinesProvider);
    if (toCurrentPeriod) {
      try {
        final overview = await _repository.fetchOverview(teamId);
        state = AsyncData(FinesState(overview: overview));
      } on Object {
        // Verversen mislukt: de actie zelf is wel gelukt.
      }
      return null;
    }
    await refresh();
    return null;
  }
}

/// De boetepot per team-id. Geen automatische retry: het scherm toont een
/// fout met "Opnieuw proberen".
final finesControllerProvider =
    AsyncNotifierProvider.family<FinesController, FinesState, int>(
      FinesController.new,
      retry: (retryCount, error) => null,
    );

/// Welke persoon (en periode) een detail laat zien.
typedef PersonFinesQuery = ({
  int teamId,

  /// `player_id`, of bij [staff] het `user_id`.
  int id,
  bool staff,
  int? periodId,
});

/// De boetes van één speler of staflid in een periode.
final personFinesProvider = FutureProvider.autoDispose
    .family<PersonFines, PersonFinesQuery>((ref, query) {
      final repository = ref.watch(finesRepositoryProvider);
      return query.staff
          ? repository.fetchStaff(
              query.teamId,
              query.id,
              periodId: query.periodId,
            )
          : repository.fetchPlayer(
              query.teamId,
              query.id,
              periodId: query.periodId,
            );
    }, retry: (retryCount, error) => null);
