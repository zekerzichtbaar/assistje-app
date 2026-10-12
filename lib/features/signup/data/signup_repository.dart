import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/signup_models.dart';
import 'signup_logo_picker.dart';

/// Wat `POST /signup` meekrijgt.
class SignupDraft {
  const SignupDraft({
    required this.sport,
    required this.designation,
    required this.name,
    required this.email,
    required this.trainings,
    this.clubId,
    this.clubName,
    this.scheduleFeedUrl,
    this.logo,
    this.duplicateOk = false,
  });

  final String sport;

  /// Een club uit de keuzelijst; anders [clubName].
  final int? clubId;
  final String? clubName;
  final String designation;
  final String name;
  final String email;
  final List<SignupTraining> trainings;
  final String? scheduleFeedUrl;

  /// Optioneel logo (alleen bij een ingetypte club); dan gaat het verzoek
  /// als `multipart/form-data`.
  final PickedSignupLogo? logo;

  /// "Toch een nieuwe maken" na de duplicate-melding.
  final bool duplicateOk;

  static String? _blank(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  /// De JSON-body; met club uit de lijst gaat `club_name` als `null`.
  Map<String, dynamic> toJson() => {
    'sport': sport,
    'club_id': clubId,
    'club_name': clubId == null ? _blank(clubName) : null,
    'designation': designation.trim(),
    'name': name.trim(),
    'email': email.trim(),
    'trainings': [
      for (final t in trainings)
        {
          'weekday': t.weekday,
          'starts_at': t.startsAt,
          'ends_at': t.endsAt,
          'venue': _blank(t.venue),
        },
    ],
    'schedule_feed_url': _blank(scheduleFeedUrl),
    'duplicate_ok': duplicateOk,
  };

  /// JSON zonder logo, anders multipart met veld `logo` (Laravel-notatie
  /// voor de lijst: `trainings[0][weekday]`, booleans als `1`/`0`).
  Object toRequestData() {
    final logo = this.logo;
    if (logo == null) return toJson();
    final json = toJson();
    final fields = <String, Object>{};
    json.forEach((key, value) {
      if (value == null) return;
      if (value is bool) {
        fields[key] = value ? '1' : '0';
      } else if (value is List) {
        for (var i = 0; i < value.length; i++) {
          (value[i] as Map<String, dynamic>).forEach((field, v) {
            if (v != null) fields['$key[$i][$field]'] = '$v';
          });
        }
      } else {
        fields[key] = '$value';
      }
    });
    final [type, subtype] = logo.mimeType.split('/');
    return FormData.fromMap({
      ...fields,
      'logo': MultipartFile.fromBytes(
        logo.bytes,
        filename: logo.name,
        contentType: DioMediaType(type, subtype),
      ),
    });
  }
}

/// De publieke aanmeld-endpoints (vogels3 `docs/api/v1/signup.md`). Geen
/// token nodig; een meegestuurd token wordt genegeerd. Nooit een token
/// terug: na `202` logt de app in met de mail of een code.
///
/// Fouten: `422` per veld (`ValidationException`, ook `errors.duplicate`),
/// `429` na te veel pogingen (`ThrottledException`).
class SignupRepository {
  const SignupRepository(this._api);

  final ApiClient _api;

  /// `GET /signup[?sport=]`.
  Future<SignupOptions> fetchOptions({String? sport}) async {
    final trimmed = sport?.trim();
    final body = await _api.get(
      '/signup',
      query: trimmed == null || trimmed.isEmpty ? null : {'sport': trimmed},
    );
    return SignupOptions.fromJson(_data(body));
  }

  /// `GET /signup/clubs?q=&sport=`: hoogstens 8 treffers, beste bovenaan.
  Future<SignupClubResults> searchClubs(String query, String sport) async {
    final body = await _api.get(
      '/signup/clubs',
      query: {'q': query.trim(), 'sport': sport},
    );
    final data = body['data'];
    final meta = body['meta'];
    return SignupClubResults(
      clubs: [
        if (data is List)
          for (final club in data)
            if (club is Map<String, dynamic>) SignupClub.fromJson(club),
      ],
      more: meta is Map<String, dynamic> && meta['more'] is num
          ? (meta['more'] as num).toInt()
          : 0,
    );
  }

  /// `GET /signup/existing?club_id=&sport=&designation=`: staat dit elftal
  /// er al? `null` = nee (of een parameter ontbrak).
  Future<SignupTeam?> findExisting({
    required int clubId,
    required String sport,
    required String designation,
  }) async {
    final body = await _api.get(
      '/signup/existing',
      query: {
        'club_id': '$clubId',
        'sport': sport,
        'designation': designation.trim(),
      },
    );
    final team = _data(body)['team'];
    return team is Map<String, dynamic> ? SignupTeam.fromJson(team) : null;
  }

  /// `POST /signup` (JSON, of multipart met een logo) → `202`.
  Future<SignupSent> submit(SignupDraft draft) async {
    final body = await _api.post('/signup', data: draft.toRequestData());
    return SignupSent.fromJson(_data(body));
  }

  /// `POST /signup/other-sport` → `202`: een aanvraag, geen omgeving.
  Future<SignupRequested> requestOtherSport({
    required String sport,
    required String clubName,
    required String name,
    required String email,
  }) async {
    final body = await _api.post(
      '/signup/other-sport',
      data: {
        'sport': sport.trim(),
        'club_name': clubName.trim(),
        'name': name.trim(),
        'email': email.trim(),
      },
    );
    return SignupRequested.fromJson(_data(body));
  }

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final signupRepositoryProvider = Provider<SignupRepository>(
  (ref) => SignupRepository(ref.watch(apiClientProvider)),
);
