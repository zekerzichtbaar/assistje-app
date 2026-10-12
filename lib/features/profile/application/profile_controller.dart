import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../../../core/session/session_providers.dart';
import '../data/avatar_picker.dart';
import '../data/models/profile_models.dart';
import '../data/profile_repository.dart';

/// Het woord dat je moet typen om je account te verwijderen.
const String deleteAccountConfirmWord = 'VERWIJDER';

/// De "Mij"-tab van team [teamId]: laden, verversen en alle schrijfacties.
///
/// Acties geven de fout terug (of `null` als het lukte), zodat het scherm
/// hem kan tonen. Schrijfacties die `/me` raken (naam, foto, eigen speler,
/// blessure) verversen daarna [meProvider].
class ProfileController extends AsyncNotifier<Profile> {
  ProfileController(this.teamId);

  final int teamId;

  ProfileRepository get _repository => ref.read(profileRepositoryProvider);

  @override
  Future<Profile> build() async {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een vers profiel.
    ref.watch(authControllerProvider);
    return ref.watch(profileRepositoryProvider).fetch(teamId);
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

  /// Naam, e-mail en geboortedatum opslaan. Geeft ook terug waar een
  /// bevestigingslink heen ging (nieuw adres).
  Future<({Object? error, String? emailClaimSentTo})> updateAccount({
    required String name,
    String? email,
    String? birthdate,
  }) async {
    try {
      final result = await _repository.updateAccount(
        name: name,
        email: email,
        birthdate: birthdate,
      );
      _setAccount(result.account);
      _refreshMe();
      return (error: null, emailClaimSentTo: result.emailClaimSentTo);
    } on Object catch (error) {
      return (error: error, emailClaimSentTo: null);
    }
  }

  /// De bevestigingslink opnieuw sturen.
  Future<Object?> resendEmailClaim() async {
    try {
      await _repository.resendEmailClaim();
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  /// Een nieuwe foto kiezen ([source]) en uploaden. `cancelled` als de
  /// gebruiker afbrak.
  Future<({Object? error, bool cancelled})> pickAndUploadAvatar(
    AvatarSource source,
  ) async {
    final PickedAvatar? picked;
    try {
      picked = await ref.read(avatarPickerProvider).pick(source);
    } on Object catch (error) {
      return (error: error, cancelled: false);
    }
    if (picked == null) return (error: null, cancelled: true);
    try {
      final url = await _repository.uploadAvatar(picked.toDataUri());
      _patchAccount((a) => a.copyWith(avatarUrl: url));
      _refreshMe();
      return (error: null, cancelled: false);
    } on Object catch (error) {
      return (error: error, cancelled: false);
    }
  }

  /// De profielfoto weghalen.
  Future<Object?> removeAvatar() async {
    try {
      await _repository.removeAvatar();
      _patchAccount((a) => a.copyWith(avatarUrl: null));
      _refreshMe();
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  /// "Ik speel ook mee": een spelersprofiel in dit team.
  Future<Object?> attachPlayer({required String position, int? shirtNumber}) =>
      _write(
        () => _repository.attachPlayer(
          teamId,
          position: position,
          shirtNumber: shirtNumber,
        ),
      );

  /// Het spelersprofiel in dit team loslaten.
  Future<Object?> detachPlayer() =>
      _write(() => _repository.detachPlayer(teamId));

  /// Jezelf geblesseerd of weer fit melden. Optimistisch; bij een fout
  /// springt de schakelaar terug.
  Future<Object?> setInjured({required bool injured}) async {
    final current = state.value;
    final player = current?.player;
    if (current == null || player == null) return null;
    state = AsyncData(
      current.copyWith(player: player.copyWith(isInjured: injured)),
    );
    try {
      state = AsyncData(await _repository.setInjured(teamId, injured: injured));
      _refreshMe();
      return null;
    } on Object catch (error) {
      final latest = state.value;
      final latestPlayer = latest?.player;
      if (latest != null && latestPlayer != null) {
        state = AsyncData(
          latest.copyWith(
            player: latestPlayer.copyWith(isInjured: player.isInjured),
          ),
        );
      }
      return error;
    }
  }

  /// Account verwijderen (getypte bevestiging [confirm]); daarna lokaal
  /// uitloggen — de server heeft alle tokens al ingetrokken.
  Future<Object?> deleteAccount(String confirm) async {
    try {
      await _repository.deleteAccount(confirm: confirm);
    } on Object catch (error) {
      return error;
    }
    ref.read(authControllerProvider.notifier).handleUnauthorized();
    return null;
  }

  Future<Object?> _write(Future<Profile> Function() request) async {
    try {
      state = AsyncData(await request());
      _refreshMe();
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  void _setAccount(ProfileAccount account) =>
      _patchAccount((current) => account);

  void _patchAccount(ProfileAccount Function(ProfileAccount) update) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(user: update(current.user)));
  }

  void _refreshMe() => ref.invalidate(meProvider);
}

final profileControllerProvider =
    AsyncNotifierProvider.family<ProfileController, Profile, int>(
      ProfileController.new,
      retry: (retryCount, error) => null,
    );
