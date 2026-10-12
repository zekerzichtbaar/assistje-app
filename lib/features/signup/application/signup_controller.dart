import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_repository.dart';
import '../../../core/session/session_providers.dart';
import '../data/models/signup_models.dart';
import '../data/signup_repository.dart';

/// De stappen van de aanmeldflow, in volgorde (PWA `Pages/Signup/Index.tsx`).
enum SignupStep { sport, club, team, you, trainings, programme }

/// Welke stappen er zijn: de sportstap valt weg als de sport uit de link
/// kwam ([SignupOptions.sport]); de programmastap staat er alleen bij een
/// sport met een agenda-feed.
List<SignupStep> signupSteps({
  required bool sportFromLink,
  required SignupSport? chosen,
}) => [
  if (!sportFromLink) SignupStep.sport,
  SignupStep.club,
  SignupStep.team,
  SignupStep.you,
  SignupStep.trainings,
  if (chosen?.hasFeed ?? false) SignupStep.programme,
];

/// Op welke stap een veldfout van de server (`422`) hoort; `null` = geen.
SignupStep? signupStepOf(String field) {
  if (field == 'sport') return SignupStep.sport;
  if (const {'club_id', 'club_name', 'logo'}.contains(field)) {
    return SignupStep.club;
  }
  if (field == 'designation' || field == 'duplicate') return SignupStep.team;
  if (field == 'name' || field == 'email') return SignupStep.you;
  if (field.startsWith('trainings')) return SignupStep.trainings;
  if (field == 'schedule_feed_url') return SignupStep.programme;
  return null;
}

/// `GET /signup[?sport=]`, per sport uit de link. Geen automatische retry:
/// het scherm toont de fout met "opnieuw".
final signupOptionsProvider = FutureProvider.autoDispose
    .family<SignupOptions, String?>(
      (ref, sport) =>
          ref.watch(signupRepositoryProvider).fetchOptions(sport: sport),
      retry: (retryCount, error) => null,
    );

/// De acties van het aanmeldscherm. Fouten (`ApiException`) gaan door naar
/// het scherm, behalve bij [findExisting] (een vriendelijkheid: de server
/// vangt een dubbel team bij het aanmaken nog een keer af).
class SignupFlow {
  SignupFlow(this._ref);

  final Ref _ref;

  SignupRepository get _repository => _ref.read(signupRepositoryProvider);

  Future<SignupClubResults> searchClubs(String query, String sport) =>
      _repository.searchClubs(query, sport);

  /// Staat dit elftal er al? Een fout leest als "nee".
  Future<SignupTeam?> findExisting({
    required int clubId,
    required String sport,
    required String designation,
  }) async {
    try {
      return await _repository.findExisting(
        clubId: clubId,
        sport: sport,
        designation: designation,
      );
    } on Object {
      return null;
    }
  }

  Future<SignupSent> submit(SignupDraft draft) => _repository.submit(draft);

  Future<SignupRequested> requestOtherSport({
    required String sport,
    required String clubName,
    required String name,
    required String email,
  }) => _repository.requestOtherSport(
    sport: sport,
    clubName: clubName,
    name: name,
    email: email,
  );

  /// Na "check je mail": een inlogcode aanvragen voor het adres, met de
  /// slug van de (nieuwe) omgeving (`POST /auth/request` met `team`).
  Future<void> requestLoginCode(SignupSent sent) => _ref
      .read(authRepositoryProvider)
      .requestCode(
        sent.email,
        team: sent.team.slug.isEmpty ? null : sent.team.slug,
      );

  /// Ingelogd aangemeld: `/me` opnieuw laden, want een nieuw team van dit
  /// account staat er dan bij.
  void refreshMe() => _ref.invalidate(meProvider);
}

final signupFlowProvider = Provider<SignupFlow>(SignupFlow.new);
