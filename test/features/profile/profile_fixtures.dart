import 'dart:typed_data';

import 'package:assistje/features/profile/data/avatar_picker.dart';

/// JSON uit vogels3 `docs/api/v1/profile.md`.
abstract final class ProfileFixtures {
  static Map<String, dynamic> account({
    String name = 'Sam de Vries',
    String? email = 'sam@example.com',
    String? pendingEmail,
    String? avatarUrl = 'https://assistje.nl/avatars/thumb/abc.jpg',
    String? birthdate = '2001-04-05',
  }) => {
    'id': 12,
    'name': name,
    'email': email,
    'pending_email': pendingEmail,
    'avatar_url': avatarUrl,
    'birthdate': birthdate,
  };

  static Map<String, dynamic> player({bool injured = false}) => {
    'id': 34,
    'name': 'Sam de Vries',
    'shirt_number': 8,
    'position': 'CM',
    'birthdate': '2001-04-05',
    'is_injured': injured,
  };

  static Map<String, dynamic> profile({
    Map<String, dynamic>? user,
    Map<String, dynamic>? player,
    bool withPlayer = true,
    bool canUseVacations = true,
    List<Map<String, dynamic>>? vacations,
    Map<String, dynamic>? standingAbsences,
  }) => {
    'data': {
      'user': user ?? account(),
      'player': withPlayer ? (player ?? ProfileFixtures.player()) : null,
      'can_use_vacations': canUseVacations,
      'vacations':
          vacations ??
          [
            {
              'id': 5,
              'starts_on': '2026-12-20',
              'ends_on': '2027-01-03',
              'note': 'Wintersport',
            },
          ],
      'standing_absences': withPlayer
          ? (standingAbsences ??
                {
                  'days': [
                    {'id': 1, 'weekday': 2},
                  ],
                  'choices': [2, 4],
                })
          : null,
      'personal_stats': withPlayer
          ? {'season': <String, dynamic>{}, 'career': <String, dynamic>{}}
          : null,
      'achievements': <Object>[],
      'duties': <Object>[],
    },
  };

  static Map<String, dynamic> accountUpdate({
    Map<String, dynamic>? user,
    String? sentTo,
  }) => {
    'data': user ?? account(),
    'meta': {'email_claim_sent_to': sentTo},
  };

  static const demoMessage =
      'Dit is een demo: wijzigen is hier uitgeschakeld. In je eigen omgeving '
      'kan dit gewoon.';

  static Map<String, dynamic> demo403() => {'message': demoMessage};

  static Map<String, dynamic> validation(String field, String message) => {
    'message': message,
    'errors': {
      field: [message],
    },
  };
}

/// [AvatarPicker] voor tests: geeft [result] terug en telt de aanroepen.
class FakeAvatarPicker implements AvatarPicker {
  FakeAvatarPicker([this.result]);

  PickedAvatar? result;
  final List<AvatarSource> calls = [];

  static PickedAvatar jpeg() => PickedAvatar(
    bytes: Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0, 1, 2, 3]),
    mimeType: 'image/jpeg',
  );

  @override
  Future<PickedAvatar?> pick(AvatarSource source) async {
    calls.add(source);
    return result;
  }
}
