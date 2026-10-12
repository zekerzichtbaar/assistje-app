import 'package:assistje/app.dart';
import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/features/profile/data/avatar_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/test_app.dart';
import 'profile_fixtures.dart';

const _profile = 'GET /teams/3/profile';

/// Zoals `pumpSignedIn`, maar met een nep-[AvatarPicker], en meteen op de
/// Mij-tab.
Future<(ProviderContainer, TestBackend, FakeAvatarPicker)> _open(
  WidgetTester tester, {
  required void Function(FakeHttpAdapter http) setup,
  String role = 'player',
  Map<String, bool> features = const {
    'injuries': true,
    'vacations': true,
    'standing_absences': true,
  },
}) async {
  tester.view
    ..physicalSize = const Size(1800, 4200)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final backend = TestBackend(token: '12|abc');
  await backend.init();
  backend.http
    ..on(
      'GET /me',
      200,
      ApiFixtures.meResponse(
        teams: [ApiFixtures.membership(role: role, features: features)],
      ),
    )
    ..on('GET /teams/3/agenda', 200, ApiFixtures.emptyAgendaResponse());
  setup(backend.http);
  final picker = FakeAvatarPicker();
  final container = ProviderContainer(
    overrides: [
      ...backend.overrides,
      avatarPickerProvider.overrideWithValue(picker),
    ],
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const AssistjeApp()),
  );
  await pumpUntilFound(tester, find.byKey(const Key('glass-tab-bar')));
  container.read(routerProvider).go(AppRoutes.profile);
  await tester.pumpAndSettle();
  return (container, backend, picker);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('toont account, blessure, vakanties, vaste dagen en team', (
    tester,
  ) async {
    await _open(
      tester,
      setup: (http) => http.on(
        _profile,
        200,
        ProfileFixtures.profile(
          user: ProfileFixtures.account(
            email: null,
            pendingEmail: 'nieuw@example.com',
          ),
        ),
      ),
    );

    expect(find.byKey(const Key('placeholder-title')), findsOneWidget);
    final name = tester.widget<TextField>(
      find.byKey(const ValueKey('profile-name')),
    );
    expect(name.controller?.text, 'Sam de Vries');
    final email = tester.widget<TextField>(
      find.byKey(const ValueKey('profile-email')),
    );
    expect(email.controller?.text, 'nieuw@example.com');
    expect(find.byKey(const ValueKey('profile-email-pending')), findsOne);
    expect(find.byKey(const ValueKey('profile-email-resend')), findsOne);
    final birthdate = tester.widget<Text>(
      find.byKey(const ValueKey('profile-birthdate')),
    );
    expect(birthdate.data, allOf(startsWith('05 apr'), endsWith('2001')));
    expect(find.byKey(const ValueKey('profile-injury-switch')), findsOne);
    expect(find.byKey(const ValueKey('profile-vacation-5')), findsOne);
    expect(find.byKey(const ValueKey('profile-standing-2')), findsOne);
    expect(find.byKey(const ValueKey('profile-standing-4')), findsOne);
    expect(find.byKey(const ValueKey('profile-player')), findsOne);
    expect(find.byKey(const Key('profile-team-name')), findsOne);
    expect(find.byKey(const Key('logout')), findsOne);
    expect(find.byKey(const ValueKey('profile-delete')), findsOne);
  });

  testWidgets('zonder features geen blessure/vakantie/vaste dagen', (
    tester,
  ) async {
    await _open(
      tester,
      features: const {},
      setup: (http) => http.on(_profile, 200, ProfileFixtures.profile()),
    );
    expect(find.byKey(const ValueKey('profile-injury')), findsNothing);
    expect(find.byKey(const ValueKey('profile-vacations')), findsNothing);
    expect(find.byKey(const ValueKey('profile-standing')), findsNothing);
  });

  testWidgets('laadfout: retry, en uitloggen kan nog steeds', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_profile, 500, {'message': 'Kapot.'}),
    );
    expect(find.byKey(const ValueKey('profile-error')), findsOne);
    expect(find.byKey(const Key('logout')), findsOne);
    expect(find.byKey(const Key('profile-team-name')), findsOne);
  });

  testWidgets('opslaan: PATCH en toast voor het nieuwe adres', (tester) async {
    late FakeHttpAdapter api;
    await _open(
      tester,
      setup: (http) {
        api = http;
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
      },
    );

    await tester.enterText(
      find.byKey(const ValueKey('profile-name')),
      'Sam Jansen',
    );
    await tester.enterText(
      find.byKey(const ValueKey('profile-email')),
      'nieuw@example.com',
    );
    await _tap(tester, find.byKey(const ValueKey('profile-save')));

    expect(api.requestsTo('PATCH /profile').single.body, {
      'name': 'Sam Jansen',
      'email': 'nieuw@example.com',
      'birthdate': '2001-04-05',
    });
    expect(find.text('Bevestig je nieuwe e-mailadres'), findsOneWidget);
    expect(find.byKey(const ValueKey('profile-email-pending')), findsOne);
  });

  testWidgets('opslaan: 422 staat bij het veld', (tester) async {
    await _open(
      tester,
      setup: (http) => http
        ..on(_profile, 200, ProfileFixtures.profile())
        ..on(
          'PATCH /profile',
          422,
          ProfileFixtures.validation('email', 'Dit adres is al in gebruik.'),
        ),
    );
    await _tap(tester, find.byKey(const ValueKey('profile-save')));
    expect(find.text('Dit adres is al in gebruik.'), findsWidgets);
  });

  testWidgets('lege naam wordt niet verstuurd', (tester) async {
    late FakeHttpAdapter api;
    await _open(
      tester,
      setup: (http) {
        api = http;
        http.on(_profile, 200, ProfileFixtures.profile());
      },
    );
    await tester.enterText(find.byKey(const ValueKey('profile-name')), '  ');
    await _tap(tester, find.byKey(const ValueKey('profile-save')));
    expect(find.text('Vul je naam in.'), findsOneWidget);
    expect(api.requestsTo('PATCH /profile'), isEmpty);
  });

  testWidgets('blessure: demo-403 toont de melding en springt terug', (
    tester,
  ) async {
    await _open(
      tester,
      setup: (http) => http
        ..on(_profile, 200, ProfileFixtures.profile())
        ..on('PATCH /teams/3/profile/injury', 403, ProfileFixtures.demo403()),
    );
    await _tap(tester, find.byKey(const ValueKey('profile-injury-switch')));
    expect(find.text(ProfileFixtures.demoMessage), findsOneWidget);
    final toggle = tester.widget<Switch>(
      find.byKey(const ValueKey('profile-injury-switch')),
    );
    expect(toggle.value, isFalse);
  });

  testWidgets('nieuwe foto uit de galerij wordt geüpload', (tester) async {
    late FakeHttpAdapter api;
    final (_, _, picker) = await _open(
      tester,
      setup: (http) {
        api = http;
        http
          ..on(_profile, 200, ProfileFixtures.profile())
          ..on('POST /profile/avatar', 200, {
            'data': {'avatar_url': 'https://assistje.nl/avatars/thumb/x.jpg'},
          });
      },
    );
    picker.result = FakeAvatarPicker.jpeg();
    await _tap(tester, find.byKey(const ValueKey('profile-avatar-new')));
    await _tap(tester, find.byKey(const ValueKey('profile-avatar-gallery')));
    expect(picker.calls, [AvatarSource.gallery]);
    final body =
        api.requestsTo('POST /profile/avatar').single.body!
            as Map<String, dynamic>;
    expect(body['avatar_base64'], startsWith('data:image/jpeg;base64,'));
    expect(find.text('Profielfoto opgeslagen'), findsOneWidget);
  });

  testWidgets('speler-profiel aanmaken via de sheet', (tester) async {
    late FakeHttpAdapter api;
    await _open(
      tester,
      setup: (http) {
        api = http;
        http
          ..on(_profile, 200, ProfileFixtures.profile(withPlayer: false))
          ..on('POST /teams/3/profile/player', 200, ProfileFixtures.profile());
      },
    );
    await _tap(tester, find.byKey(const ValueKey('profile-player-activate')));
    // Het testsportprofiel heeft geen posities: een vrij veld.
    await tester.enterText(
      find.byKey(const ValueKey('profile-player-position-free')),
      'st',
    );
    await tester.enterText(
      find.byKey(const ValueKey('profile-player-shirt')),
      '9',
    );
    await _tap(tester, find.byKey(const ValueKey('profile-player-save')));
    expect(api.requestsTo('POST /teams/3/profile/player').single.body, {
      'position': 'ST',
      'shirt_number': 9,
    });
    expect(find.byKey(const ValueKey('profile-player')), findsOne);
  });

  testWidgets('toeschouwer zonder speler ziet geen "speel je mee"', (
    tester,
  ) async {
    await _open(
      tester,
      role: 'spectator',
      setup: (http) =>
          http.on(_profile, 200, ProfileFixtures.profile(withPlayer: false)),
    );
    expect(find.byKey(const ValueKey('profile-player-join')), findsNothing);
  });

  testWidgets('account verwijderen na VERWIJDER typen logt uit', (
    tester,
  ) async {
    late FakeHttpAdapter api;
    final (_, backend, _) = await _open(
      tester,
      setup: (http) {
        api = http;
        http
          ..on(_profile, 200, ProfileFixtures.profile())
          ..on('DELETE /profile', 204);
      },
    );
    await _tap(tester, find.byKey(const ValueKey('profile-delete-open')));
    final submit = find.byKey(const ValueKey('profile-delete-submit'));
    await tester.enterText(
      find.byKey(const ValueKey('profile-delete-confirm')),
      'verwijder',
    );
    await _tap(tester, submit);
    await pumpUntilFound(tester, find.text('Log in bij je team'));
    expect(api.requestsTo('DELETE /profile').single.body, {
      'confirm': 'VERWIJDER',
    });
    expect(backend.tokens.token, isNull);
  });
}
