import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../data/models/wheel_models.dart';
import '../data/wheel_repository.dart';

/// Wat het rad-scherm van één team nu weet.
class WheelState {
  const WheelState({
    required this.overview,
    this.selected = const {},
    this.lastSpinId,
  });

  final WheelOverview overview;

  /// De gekozen deelnemers (`key`s, `p17`/`u4`).
  final Set<String> selected;

  /// De draai die deze gebruiker net deed (voor koppelen/"Foutje?").
  final int? lastSpinId;

  WheelState copyWith({
    WheelOverview? overview,
    Set<String>? selected,
    int? lastSpinId,
    bool clearLastSpin = false,
  }) => WheelState(
    overview: overview ?? this.overview,
    selected: selected ?? this.selected,
    lastSpinId: clearLastSpin ? null : lastSpinId ?? this.lastSpinId,
  );

  /// De deelnemers op het rad, in de volgorde van `players`.
  List<WheelPlayer> get candidates => [
    for (final player in overview.players)
      if (selected.contains(player.key)) player,
  ];

  Set<String> get _known => {for (final p in overview.players) p.key};

  /// "Team": de vaste selectie (geen gasten, geen pure staf).
  List<String> get teamKeys => [
    for (final p in overview.players)
      if (p.isRoster) p.key,
  ];

  /// "Aanwezig": wie er bij het preset-event is (spelers én pure staf).
  List<String> get presentKeys {
    final preset = overview.preset;
    if (preset == null) return const [];
    final known = _known;
    return [
      for (final id in preset.presentIds) 'p$id',
      for (final id in preset.presentStaffIds) 'u$id',
    ].where(known.contains).toList();
  }

  /// "Bank": aanwezig maar niet in de opstelling.
  List<String> get benchKeys {
    final preset = overview.preset;
    if (preset == null) return const [];
    final known = _known;
    return [
      for (final id in preset.benchIds) 'p$id',
    ].where(known.contains).toList();
  }

  /// De draai [lastSpinId] uit de recente lijst, als die er (nog) is.
  WheelSpin? get lastSpin {
    final id = lastSpinId;
    if (id == null) return null;
    for (final spin in overview.recentSpins) {
      if (spin.id == id) return spin;
    }
    return null;
  }
}

/// Het rad van team [teamId]: laden, deelnemers kiezen, draaien vastleggen,
/// koppelen aan de wedstrijd en verwijderen. Schrijven is nooit
/// optimistisch: na elk gelukt verzoek wordt het overzicht opnieuw opgehaald.
///
/// Acties geven de fout terug (of `null` als het lukte).
class WheelController extends AsyncNotifier<WheelState> {
  WheelController(this.teamId);

  final int teamId;

  WheelRepository get _repository => ref.read(wheelRepositoryProvider);

  @override
  Future<WheelState> build() async {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een vers rad.
    ref.watch(authControllerProvider);
    final overview = await ref.watch(wheelRepositoryProvider).fetch(teamId);
    return WheelState(overview: overview);
  }

  /// Opnieuw laden. Met data in beeld blijft die staan bij een fout; de
  /// selectie blijft staan voor wie er nog is.
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
      final overview = await _repository.fetch(teamId);
      final latest = state.value ?? current;
      final known = {for (final p in overview.players) p.key};
      state = AsyncData(
        latest.copyWith(
          overview: overview,
          selected: latest.selected.where(known.contains).toSet(),
        ),
      );
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  void _update(WheelState Function(WheelState current) change) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(change(current));
  }

  /// Deelnemer [key] aan of uit.
  void toggle(String key) => _update((s) {
    final next = {...s.selected};
    if (!next.remove(key)) next.add(key);
    return s.copyWith(selected: next);
  });

  /// Zet de selectie op [keys] (alleen wie bekend is).
  void fill(Iterable<String> keys) => _update((s) {
    final known = s._known;
    return s.copyWith(selected: keys.where(known.contains).toSet());
  });

  void clear() => _update((s) => s.copyWith(selected: const {}));

  /// Kiest een winnaar uit de deelnemers (index in `candidates`), of `null`
  /// bij minder dan twee.
  int? pickWinnerIndex() {
    final count = state.value?.candidates.length ?? 0;
    if (count < 2) return null;
    return ref.read(wheelRandomProvider).nextInt(count);
  }

  /// Legt een draai vast. Geeft de vastgelegde draai of de fout terug.
  Future<({WheelSpin? spin, Object? error})> recordSpin({
    required WheelPlayer winner,
    required List<WheelPlayer> candidates,
  }) async {
    final WheelSpin spin;
    try {
      spin = await _repository.recordSpin(
        teamId,
        winner: winner,
        candidates: candidates,
      );
    } on Object catch (error) {
      return (spin: null, error: error);
    }
    _update((s) => s.copyWith(lastSpinId: spin.id));
    await refresh();
    return (spin: spin, error: null);
  }

  Future<Object?> deleteSpin(int spinId) async {
    final error = await _write(() => _repository.deleteSpin(teamId, spinId));
    if (error == null && state.value?.lastSpinId == spinId) {
      _update((s) => s.copyWith(clearLastSpin: true));
    }
    return error;
  }

  Future<Object?> assign(int spinId) =>
      _write(() => _repository.assign(teamId, spinId));

  Future<Object?> unassign(int spinId) =>
      _write(() => _repository.unassign(teamId, spinId));

  /// Vergeet de laatste draai (nieuwe selectie of nieuwe draai).
  void forgetLastSpin() => _update((s) => s.copyWith(clearLastSpin: true));

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

/// Het rad per team-id. Geen automatische retry: het scherm toont een fout
/// met "Opnieuw proberen".
final wheelControllerProvider =
    AsyncNotifierProvider.family<WheelController, WheelState, int>(
      WheelController.new,
      retry: (retryCount, error) => null,
    );

/// De toevalsbron voor de winnaar (te vervangen in tests).
final wheelRandomProvider = Provider<Random>((ref) => Random());
