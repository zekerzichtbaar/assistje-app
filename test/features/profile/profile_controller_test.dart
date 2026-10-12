import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/core/auth/auth_controller.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:assistje/features/profile/application/profile_controller.dart';
import 'package:assistje/features/profile/data/avatar_picker.dart';
import 'package:assistje/features/profile/data/models/profile_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'profile_fixtures.dart';

const _profile = 'GET /teams/3/profile';

void main() {
  late TestBackend backend;
  late ProviderContainer container;
  late FakeAvatarPicker picker;

  Future<ProfileController> start(
    void Function(FakeHttpAdapter http) setup,
  ) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http.on('GET /me', 200, ApiFixtures.meResponse());
    setup(backend.http);
    picker = FakeAvatarPicker();
    container = ProviderContainer(
      overrides: [
        ...backend.overrides,
        avatarPickerProvider.overrideWithValue(picker),
      ],
      retry: (_, _) => null,
    );
    addTearDown(container.dispose);
    container
      ..listen(meProvider, (_, _) {})
      ..listen(profileControllerProvider(3), (_, _) {});
    await container.read(meProvider.future);
    await container.read(profileControllerProvider(3).future);
    return container.read(profileControllerProvider(3).notifier);
  }

  Profile current() =>
      container.read(profileControllerProvider(3)).requireValue;

  int meCalls() => backend.http.requestsTo('GET /me').length;

  Future<void> settleMe() => container.read(meProvider.future);

  test('laadt het profiel', () async {
    await start((http) => http.on(_profile, 200, ProfileFixtures.profile()));
    expect(current().user.email, 'sam@example.com');
    expect(current().player?.id, 34);
  });

  test(
    'updateAccount: zet het account, meldt de claim en ververst /me',
    () async {
      final controller = await start((http) {
        http
          ..on(_profile, 200, ProfileFixtures.profile())
          ..on(
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
      });
      final before = meCalls();
      final result = await controller.updateAccount(
        name: 'Sam Jansen',
        email: 'nieuw@example.com',
      );
      await settleMe();
      expect(result.error, isNull);
      expect(result.emailClaimSentTo, 'nieuw@example.com');
      expect(current().user.name, 'Sam Jansen');
      expect(current().user.pendingEmail, 'nieuw@example.com');
      expect(meCalls(), before + 1);
    },
  );

  test('updateAccount: 422 komt terug, state blijft', () async {
    final controller = await start((http) {
      http
        ..on(_profile, 200, ProfileFixtures.profile())
        ..on(
          'PATCH /profile',
          422,
          ProfileFixtures.validation('name', 'Naam is verplicht.'),
        );
    });
    final result = await controller.updateAccount(name: 'x');
    expect(result.error, isA<ValidationException>());
    expect(current().user.name, 'Sam de Vries');
  });

  test('blessure is optimistisch en springt terug bij een demo-403', () async {
    final controller = await start((http) {
      http
        ..on(_profile, 200, ProfileFixtures.profile())
        ..on('PATCH /teams/3/profile/injury', 403, ProfileFixtures.demo403());
    });
    final future = controller.setInjured(injured: true);
    expect(current().player?.isInjured, isTrue);
    final error = await future;
    expect(error, isA<ForbiddenException>());
    expect(current().player?.isInjured, isFalse);
  });

  test('blessure gelukt: serverstand en /me ververst', () async {
    final controller = await start((http) {
      http
        ..on(_profile, 200, ProfileFixtures.profile())
        ..on(
          'PATCH /teams/3/profile/injury',
          200,
          ProfileFixtures.profile(
            player: ProfileFixtures.player(injured: true),
          ),
        );
    });
    final before = meCalls();
    expect(await controller.setInjured(injured: true), isNull);
    await settleMe();
    expect(current().player?.isInjured, isTrue);
    expect(meCalls(), before + 1);
  });

  test('attach en detach vervangen het profiel', () async {
    final controller = await start((http) {
      http
        ..on(_profile, 200, ProfileFixtures.profile(withPlayer: false))
        ..on('POST /teams/3/profile/player', 200, ProfileFixtures.profile())
        ..on(
          'DELETE /teams/3/profile/player',
          200,
          ProfileFixtures.profile(withPlayer: false),
        );
    });
    expect(current().player, isNull);
    expect(await controller.attachPlayer(position: 'CM'), isNull);
    expect(current().player?.position, 'CM');
    expect(await controller.detachPlayer(), isNull);
    expect(current().player, isNull);
  });

  test('avatar: afbreken stuurt niets, kiezen uploadt en zet de url', () async {
    final controller = await start((http) {
      http
        ..on(_profile, 200, ProfileFixtures.profile())
        ..on('POST /profile/avatar', 200, {
          'data': {'avatar_url': 'https://assistje.nl/avatars/thumb/xyz.jpg'},
        })
        ..on('DELETE /profile/avatar', 200, {
          'data': {'avatar_url': null},
        });
    });

    final cancelled = await controller.pickAndUploadAvatar(
      AvatarSource.gallery,
    );
    expect(cancelled.cancelled, isTrue);
    expect(backend.http.requestsTo('POST /profile/avatar'), isEmpty);

    picker.result = FakeAvatarPicker.jpeg();
    final done = await controller.pickAndUploadAvatar(AvatarSource.camera);
    expect(done.error, isNull);
    expect(picker.calls, [AvatarSource.gallery, AvatarSource.camera]);
    expect(current().user.avatarUrl, endsWith('xyz.jpg'));

    expect(await controller.removeAvatar(), isNull);
    expect(current().user.avatarUrl, isNull);
  });

  test('avatar: 422 van de server komt terug', () async {
    final controller = await start((http) {
      http
        ..on(_profile, 200, ProfileFixtures.profile())
        ..on('POST /profile/avatar', 422, {
          'message': 'Ongeldige afbeelding.',
          'errors': {
            'avatar': ['Ongeldig formaat.'],
          },
        });
    });
    picker.result = FakeAvatarPicker.jpeg();
    final result = await controller.pickAndUploadAvatar(AvatarSource.gallery);
    expect(result.error, isA<ValidationException>());
    expect(current().user.avatarUrl, endsWith('abc.jpg'));
  });

  test('account verwijderen logt lokaal uit', () async {
    final controller = await start((http) {
      http
        ..on(_profile, 200, ProfileFixtures.profile())
        ..on('DELETE /profile', 204);
    });
    expect(await controller.deleteAccount(deleteAccountConfirmWord), isNull);
    expect(container.read(authControllerProvider), AuthStatus.signedOut);
    await Future<void>.delayed(Duration.zero);
    expect(backend.tokens.token, isNull);
    expect(backend.http.requestsTo('POST /auth/logout'), isEmpty);
  });

  test('account verwijderen: 422 blijft ingelogd', () async {
    final controller = await start((http) {
      http
        ..on(_profile, 200, ProfileFixtures.profile())
        ..on(
          'DELETE /profile',
          422,
          ProfileFixtures.validation('confirm', 'Typ VERWIJDER.'),
        );
    });
    expect(await controller.deleteAccount('nee'), isA<ValidationException>());
    expect(container.read(authControllerProvider), AuthStatus.signedIn);
  });
}
