import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/profile/data/avatar_picker.dart';
import 'package:assistje/features/profile/data/profile_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'profile_fixtures.dart';

void main() {
  late TestBackend backend;
  late ProfileRepository repository;

  setUp(() async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    final container = backend.container();
    addTearDown(container.dispose);
    repository = ProfileRepository(container.read(apiClientProvider));
  });

  FakeHttpAdapter http() => backend.http;

  test('fetch leest account, speler, vakanties en vaste dagen', () async {
    http().on('GET /teams/3/profile', 200, ProfileFixtures.profile());
    final profile = await repository.fetch(3);

    expect(profile.user.name, 'Sam de Vries');
    expect(profile.user.avatarUrl, contains('abc.jpg'));
    expect(profile.user.birthdate, '2001-04-05');
    expect(profile.player?.position, 'CM');
    expect(profile.player?.shirtNumber, 8);
    expect(profile.player?.isInjured, isFalse);
    expect(profile.canUseVacations, isTrue);
    expect(profile.vacations.single.note, 'Wintersport');
    expect(profile.vacations.single.startsOn, '2026-12-20');
    expect(profile.standingAbsences?.isAbsentOn(2), isTrue);
    expect(profile.standingAbsences?.isAbsentOn(4), isFalse);
    expect(profile.standingAbsences?.choices, [2, 4]);
  });

  test('fetch zonder speler: player en standing_absences null', () async {
    http().on(
      'GET /teams/3/profile',
      200,
      ProfileFixtures.profile(withPlayer: false, canUseVacations: false),
    );
    final profile = await repository.fetch(3);
    expect(profile.player, isNull);
    expect(profile.standingAbsences, isNull);
  });

  test('attach/detach/injury sturen de juiste body', () async {
    http()
      ..on('POST /teams/3/profile/player', 200, ProfileFixtures.profile())
      ..on(
        'DELETE /teams/3/profile/player',
        200,
        ProfileFixtures.profile(withPlayer: false),
      )
      ..on(
        'PATCH /teams/3/profile/injury',
        200,
        ProfileFixtures.profile(player: ProfileFixtures.player(injured: true)),
      );

    await repository.attachPlayer(3, position: 'ST', shirtNumber: 9);
    expect(http().requestsTo('POST /teams/3/profile/player').single.body, {
      'position': 'ST',
      'shirt_number': 9,
    });

    final detached = await repository.detachPlayer(3);
    expect(detached.player, isNull);

    final injured = await repository.setInjured(3, injured: true);
    expect(injured.player?.isInjured, isTrue);
    expect(http().requestsTo('PATCH /teams/3/profile/injury').single.body, {
      'is_injured': true,
    });
  });

  test('updateAccount geeft account en email_claim_sent_to', () async {
    http().on(
      'PATCH /profile',
      200,
      ProfileFixtures.accountUpdate(
        user: ProfileFixtures.account(
          name: 'Sam Jansen',
          pendingEmail: 'nieuw@example.com',
        ),
        sentTo: 'nieuw@example.com',
      ),
    );
    final result = await repository.updateAccount(
      name: 'Sam Jansen',
      email: 'nieuw@example.com',
      birthdate: '2001-04-05',
    );
    expect(result.account.name, 'Sam Jansen');
    expect(result.account.pendingEmail, 'nieuw@example.com');
    expect(result.emailClaimSentTo, 'nieuw@example.com');
    expect(http().requestsTo('PATCH /profile').single.body, {
      'name': 'Sam Jansen',
      'email': 'nieuw@example.com',
      'birthdate': '2001-04-05',
    });
  });

  test('updateAccount: 422 wordt een ValidationException met veld', () async {
    http().on(
      'PATCH /profile',
      422,
      ProfileFixtures.validation('email', 'Dit adres is al in gebruik.'),
    );
    await expectLater(
      repository.updateAccount(name: 'Sam', email: 'bezet@example.com'),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.fieldError('email'),
          'email',
          'Dit adres is al in gebruik.',
        ),
      ),
    );
  });

  test('avatar upload stuurt een data-URI, verwijderen en resend', () async {
    http()
      ..on('POST /profile/avatar', 200, {
        'data': {'avatar_url': 'https://assistje.nl/avatars/thumb/xyz.jpg'},
      })
      ..on('DELETE /profile/avatar', 200, {
        'data': {'avatar_url': null},
      })
      ..on('POST /profile/email/resend', 202, {
        'data': {'pending_email': 'chris@example.com'},
      });

    final uri = FakeAvatarPicker.jpeg().toDataUri();
    expect(uri, startsWith('data:image/jpeg;base64,'));
    final url = await repository.uploadAvatar(uri);
    expect(url, endsWith('xyz.jpg'));
    expect(http().requestsTo('POST /profile/avatar').single.body, {
      'avatar_base64': uri,
    });

    await repository.removeAvatar();
    expect(http().requestsTo('DELETE /profile/avatar'), hasLength(1));

    expect(await repository.resendEmailClaim(), 'chris@example.com');
  });

  test('deleteAccount stuurt de bevestiging; 204 is goed', () async {
    http().on('DELETE /profile', 204);
    await repository.deleteAccount(confirm: 'VERWIJDER');
    expect(http().requestsTo('DELETE /profile').single.body, {
      'confirm': 'VERWIJDER',
    });
  });

  test('mimeTypeFor valt terug op extensie en JPEG', () {
    expect(ImagePickerAvatarPicker.mimeTypeFor('image/png', 'x'), 'image/png');
    expect(ImagePickerAvatarPicker.mimeTypeFor(null, 'a.PNG'), 'image/png');
    expect(ImagePickerAvatarPicker.mimeTypeFor(null, 'a.heic'), 'image/heic');
    expect(ImagePickerAvatarPicker.mimeTypeFor(null, 'a'), 'image/jpeg');
  });
}
