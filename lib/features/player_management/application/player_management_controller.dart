import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/auth/auth_controller.dart';
import '../../players/application/player_detail_controller.dart';
import '../../team/application/roster_controller.dart';
import '../data/csv_file_picker.dart';
import '../data/models/player_import_result.dart';
import '../data/models/player_management_models.dart';
import '../data/player_management_repository.dart';

/// Wat het spelersbeheer van één team nu weet.
class PlayerManagementState {
  const PlayerManagementState({
    required this.data,
    this.writesForbidden = false,
  });

  final PlayerManagement data;

  /// Een schrijvende actie gaf `403` (demo-team, of de rol is intussen
  /// ingetrokken): het scherm valt terug op alleen-lezen.
  final bool writesForbidden;

  PlayerManagementState copyWith({
    PlayerManagement? data,
    bool? writesForbidden,
  }) => PlayerManagementState(
    data: data ?? this.data,
    writesForbidden: writesForbidden ?? this.writesForbidden,
  );

  ManagedPlayer? player(int id) {
    for (final player in data.players) {
      if (player.id == id) return player;
    }
    return null;
  }
}

/// Het spelersbeheer van team [teamId] (`Trainer/Players/Index` + het
/// beheerdeel van de spelerpagina): laden, verversen en alle trainer-acties.
///
/// - Schakelaars (aanvoerder, beheerder, bevoegdheden) zijn optimistisch en
///   draaien terug bij een fout; daarna komt de rij van de server.
/// - Bewerken en uitnodigen vervangen de rij door het antwoord.
/// - Toevoegen en verwijderen halen het hele overzicht opnieuw op.
///
/// Na elke gelukte wijziging wordt de selectie van `/team` (en een open
/// spelerpagina) ververst. Acties geven de fout terug, of `null`.
class PlayerManagementController extends AsyncNotifier<PlayerManagementState> {
  PlayerManagementController(this.teamId);

  final int teamId;

  PlayerManagementRepository get _repository =>
      ref.read(playerManagementRepositoryProvider);

  @override
  Future<PlayerManagementState> build() async {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een vers overzicht.
    ref.watch(authControllerProvider);
    final data = await ref
        .watch(playerManagementRepositoryProvider)
        .fetch(teamId);
    return PlayerManagementState(data: data);
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
      final data = await _repository.fetch(teamId);
      final latest = state.value;
      if (ref.mounted) {
        state = AsyncData(
          latest == null
              ? PlayerManagementState(data: data)
              : latest.copyWith(data: data),
        );
      }
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  // Spelers ------------------------------------------------------------------

  Future<Object?> createPlayer(NewPlayer player) =>
      _writeAndRefetch(() => _repository.createPlayer(teamId, player));

  /// Spelers uit een CSV importeren; daarna het overzicht opnieuw ophalen.
  /// Geeft de samenvatting terug, of de fout.
  Future<({PlayerImportResult? result, Object? error})> importPlayers(
    CsvFile file, {
    bool sendInvites = false,
  }) async {
    final PlayerImportResult result;
    try {
      result = await _repository.importPlayers(
        teamId,
        file,
        sendInvites: sendInvites,
      );
    } on Object catch (error) {
      _noteForbidden(error);
      return (result: null, error: error);
    }
    _invalidateOthers(null);
    await refresh();
    return (result: result, error: null);
  }

  Future<Object?> updatePlayer(int playerId, PlayerUpdate update) =>
      _writeRow(() => _repository.updatePlayer(teamId, playerId, update));

  Future<Object?> deletePlayer(int playerId) =>
      _writeAndRefetch(() => _repository.deletePlayer(teamId, playerId));

  /// Vaste aanvoerder aan/uit. Eén per team: aan haalt hem bij de vorige weg.
  Future<Object?> setCaptain(int playerId, {required bool captain}) => _toggle(
    playerId,
    optimistic: (players) => [
      for (final p in players)
        if (p.id == playerId)
          p.copyWith(isCaptain: captain)
        else if (captain && p.isCaptain)
          p.copyWith(isCaptain: false)
        else
          p,
    ],
    request: () => _repository.setCaptain(teamId, playerId, captain: captain),
  );

  /// Beheerdersrechten (rol `trainer`) aan/uit. Daarna wordt het overzicht
  /// ververst, want de lijst met trainers verandert mee.
  Future<Object?> setTrainer(int playerId, {required bool isTrainer}) async {
    final error = await _toggle(
      playerId,
      optimistic: (players) => [
        for (final p in players)
          p.id == playerId ? p.copyWith(isTrainer: isTrainer) : p,
      ],
      request: () =>
          _repository.setTrainer(teamId, playerId, isTrainer: isTrainer),
    );
    if (error == null) await refresh();
    return error;
  }

  /// Eén losse bevoegdheid aan/uit.
  Future<Object?> setAbility(
    int playerId, {
    required String ability,
    required bool granted,
  }) => _toggle(
    playerId,
    optimistic: (players) => [
      for (final p in players)
        if (p.id == playerId)
          p.copyWith(
            abilities: granted
                ? {...p.abilities, ability}.toList()
                : [
                    for (final a in p.abilities)
                      if (a != ability) a,
                  ],
          )
        else
          p,
    ],
    request: () => _repository.setAbility(
      teamId,
      playerId,
      ability: ability,
      granted: granted,
    ),
  );

  Future<Object?> invitePlayer(int playerId, String email) =>
      _writeRow(() => _repository.invitePlayer(teamId, playerId, email: email));

  Future<Object?> resendPlayerInvite(int playerId) =>
      _writeRow(() => _repository.resendPlayerInvite(teamId, playerId));

  // Trainers -----------------------------------------------------------------

  Future<Object?> addTrainer({required String name, required String email}) =>
      _writeAndRefetch(
        () => _repository.addTrainer(teamId, name: name, email: email),
      );

  Future<Object?> removeTrainer(int userId) =>
      _writeAndRefetch(() => _repository.removeTrainer(teamId, userId));

  // Toeschouwers -------------------------------------------------------------

  Future<Object?> addSpectator({required String name, required String email}) =>
      _writeAndRefetch(
        () => _repository.addSpectator(teamId, name: name, email: email),
      );

  Future<Object?> resendSpectatorInvite(int userId) async {
    try {
      final spectator = await _repository.resendSpectatorInvite(teamId, userId);
      final current = state.value;
      if (current != null && ref.mounted) {
        state = AsyncData(
          current.copyWith(
            data: current.data.copyWith(
              spectators: [
                for (final s in current.data.spectators)
                  s.id == userId ? spectator : s,
              ],
            ),
          ),
        );
      }
      return null;
    } on Object catch (error) {
      _noteForbidden(error);
      return error;
    }
  }

  Future<Object?> removeSpectator(int userId) =>
      _writeAndRefetch(() => _repository.removeSpectator(teamId, userId));

  // Intern -------------------------------------------------------------------

  /// Optimistisch: zet [optimistic] meteen, vraagt [request] en zet daarna
  /// de rij van de server; bij een fout terug naar hoe het was.
  Future<Object?> _toggle(
    int playerId, {
    required List<ManagedPlayer> Function(List<ManagedPlayer> players)
    optimistic,
    required Future<ManagedPlayer> Function() request,
  }) async {
    final before = state.value;
    if (before == null) return const NotFoundException();
    state = AsyncData(
      before.copyWith(
        data: before.data.copyWith(players: optimistic(before.data.players)),
      ),
    );
    try {
      final player = await request();
      _replacePlayer(player);
      _invalidateOthers(playerId);
      return null;
    } on Object catch (error) {
      if (ref.mounted) {
        final latest = state.value ?? before;
        state = AsyncData(
          latest.copyWith(
            data: latest.data.copyWith(players: before.data.players),
          ),
        );
      }
      _noteForbidden(error);
      return error;
    }
  }

  /// Vraagt [request] en vervangt de rij door het antwoord.
  Future<Object?> _writeRow(Future<ManagedPlayer> Function() request) async {
    try {
      final player = await request();
      _replacePlayer(player);
      _invalidateOthers(player.id);
      return null;
    } on Object catch (error) {
      _noteForbidden(error);
      return error;
    }
  }

  /// Vraagt [request] en haalt daarna het overzicht opnieuw op. Een fout bij
  /// dat verversen telt niet als mislukte actie.
  Future<Object?> _writeAndRefetch(Future<void> Function() request) async {
    try {
      await request();
    } on Object catch (error) {
      _noteForbidden(error);
      return error;
    }
    _invalidateOthers(null);
    await refresh();
    return null;
  }

  void _replacePlayer(ManagedPlayer player) {
    final current = state.value;
    if (current == null || !ref.mounted) return;
    state = AsyncData(
      current.copyWith(
        data: current.data.copyWith(
          players: [
            for (final p in current.data.players)
              p.id == player.id ? player : p,
          ],
        ),
      ),
    );
  }

  void _noteForbidden(Object error) {
    if (error is! ForbiddenException || !ref.mounted) return;
    final current = state.value;
    if (current != null && !current.writesForbidden) {
      state = AsyncData(current.copyWith(writesForbidden: true));
    }
  }

  /// `/team` en een open spelerpagina tonen dezelfde mensen.
  void _invalidateOthers(int? playerId) {
    if (!ref.mounted) return;
    ref.invalidate(rosterControllerProvider(teamId));
    if (playerId == null) {
      ref.invalidate(playerDetailControllerProvider);
    } else {
      ref.invalidate(
        playerDetailControllerProvider((teamId: teamId, playerId: playerId)),
      );
    }
  }
}

/// Het spelersbeheer per team-id; weg zodra het scherm dicht is. Geen
/// automatische retry: het scherm toont een fout met "Opnieuw proberen".
final playerManagementControllerProvider = AsyncNotifierProvider.autoDispose
    .family<PlayerManagementController, PlayerManagementState, int>(
      PlayerManagementController.new,
      retry: (retryCount, error) => null,
    );
