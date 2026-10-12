import 'package:assistje/app.dart';
import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/test_app.dart';
import 'signup_fixtures.dart';

const _options = 'GET /signup';
const _clubs = 'GET /signup/clubs';
const _existing = 'GET /signup/existing';
const _submit = 'POST /signup';
const _other = 'POST /signup/other-sport';

/// Start de app (uitgelogd, of ingelogd met [token] en [teams]) en wacht
/// op [ready]; [setup] zet de nep-API klaar.
Future<(ProviderContainer, FakeHttpAdapter)> _start(
  WidgetTester tester, {
  String? token,
  List<Map<String, dynamic>> teams = const [],
  required Finder ready,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  tester.view
    ..physicalSize = const Size(1800, 4200)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final backend = TestBackend(token: token);
  await backend.init();
  backend.http.on('GET /me', 200, ApiFixtures.meResponse(teams: teams));
  setup?.call(backend.http);
  final container = ProviderContainer(
    overrides: backend.overrides,
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const AssistjeApp()),
  );
  await pumpUntilFound(tester, ready);
  return (container, backend.http);
}

/// Uitgelogd, meteen naar [location].
Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester,
  String location, {
  required Finder until,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, http) = await _start(
    tester,
    ready: find.byKey(const Key('login-email')),
    setup: setup,
  );
  container.read(routerProvider).go(location);
  await pumpUntilFound(tester, until);
  return (container, http);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _type(WidgetTester tester, Key key, String text) async {
  await tester.enterText(find.byKey(key), text);
  await tester.pump();
}

String _location(ProviderContainer container) =>
    container.read(routerProvider).state.uri.toString();

/// Vanaf de clubstap: zoeken, club 412 kiezen, elftal 3 (nog niet bezet),
/// naam en adres.
Future<void> _clubTeamYou(WidgetTester tester) async {
  await _type(tester, const Key('signup-club-search'), 'vogel');
  await tester.pump(const Duration(milliseconds: 300));
  await pumpUntilFound(tester, find.byKey(const ValueKey('signup-club-412')));
  expect(find.text('Scherpenzeel'), findsOneWidget);
  await _tap(tester, find.byKey(const ValueKey('signup-club-412')));

  expect(find.text('Welk elftal?'), findsOneWidget);
  expect(find.text('Valleivogels'), findsOneWidget);
  await _type(tester, const Key('signup-designation'), '3');
  await _tap(tester, find.byKey(const Key('signup-next')));

  expect(find.text('Wie ben jij?'), findsOneWidget);
  await _type(tester, const Key('signup-name'), 'Patrick van Setten');
  await _type(tester, const Key('signup-email'), 'patrick@example.com');
  await _tap(tester, find.byKey(const Key('signup-next')));
  expect(find.text('Wanneer trainen jullie?'), findsOneWidget);
}

void main() {
  testWidgets(
    'uitgelogd vanaf het loginscherm: sport, club, elftal, jij, trainingen '
    '→ check je mail → inloggen met een code',
    (tester) async {
      final (container, http) = await _start(
        tester,
        ready: find.byKey(const Key('login-email')),
        setup: (http) => http
          ..on(_options, 200, SignupFixtures.options())
          ..on(_clubs, 200, SignupFixtures.clubs(more: 2))
          ..on(_existing, 200, SignupFixtures.existing(found: false))
          ..on(_submit, 202, SignupFixtures.sent())
          ..on('POST /auth/request', 202, ApiFixtures.requestResponse()),
      );

      expect(find.text('Nieuw team aanmelden'), findsOneWidget);
      await _tap(tester, find.byKey(const Key('login-signup')));
      await pumpUntilFound(tester, find.text('Welke sport?'));
      expect(_location(container), AppRoutes.signup);
      expect(find.text('Stap 1 van 5'), findsOneWidget);
      expect(find.text('Volleybal'), findsOneWidget);

      await _tap(tester, find.byKey(const ValueKey('signup-sport-football')));
      expect(find.text('Welke club?'), findsOneWidget);
      expect(find.text('Stap 2 van 5'), findsOneWidget);

      await _clubTeamYou(tester);
      expect(http.requestsTo(_clubs).last.options.uri.queryParameters, {
        'q': 'vogel',
        'sport': 'football',
      });
      expect(http.requestsTo(_existing).single.options.uri.queryParameters, {
        'club_id': '412',
        'sport': 'football',
        'designation': '3',
      });

      // Tweede trainingsdag erbij (donderdag).
      await _tap(tester, find.byKey(const ValueKey('signup-day-4')));
      expect(find.byKey(const ValueKey('signup-slot-4')), findsOneWidget);
      await tester.enterText(
        find.byKey(const ValueKey('signup-venue-2')),
        'Sportpark De Breehoek',
      );
      await tester.pump();
      expect(find.text('Maak mijn omgeving'), findsOneWidget);
      await _tap(tester, find.byKey(const Key('signup-trainings-continue')));

      await pumpUntilFound(tester, find.byKey(const ValueKey('signup-sent')));
      expect(find.text('Valleivogels 3 staat klaar'), findsOneWidget);
      expect(find.text('patrick@example.com'), findsOneWidget);
      expect(find.text('valleivogels-3.assistje.nl'), findsOneWidget);
      expect(http.requestsTo(_submit).single.body, {
        'sport': 'football',
        'club_id': 412,
        'club_name': null,
        'designation': '3',
        'name': 'Patrick van Setten',
        'email': 'patrick@example.com',
        'trainings': [
          {
            'weekday': 2,
            'starts_at': '19:30',
            'ends_at': '21:00',
            'venue': 'Sportpark De Breehoek',
          },
          {
            'weekday': 4,
            'starts_at': '19:30',
            'ends_at': '21:00',
            'venue': null,
          },
        ],
        'schedule_feed_url': null,
        'duplicate_ok': false,
      });

      await _tap(tester, find.byKey(const Key('signup-code-login')));
      expect(http.requestsTo('POST /auth/request').single.body, {
        'email': 'patrick@example.com',
        'team': 'valleivogels-3',
      });
      expect(
        _location(container),
        '${AppRoutes.loginCode}?email=patrick%40example.com',
      );
    },
  );

  testWidgets('deeplink ?sport=volleyball: geen sportstap, club zelf intikken, '
      'programmastap; 422 springt terug naar het veld', (tester) async {
    final (_, http) = await _open(
      tester,
      AppRoutes.signupLink(sport: 'volleyball'),
      until: find.text('Welke club?'),
      setup: (http) => http
        ..on(_options, 200, SignupFixtures.options(sport: 'volleyball'))
        ..on(_clubs, 200, SignupFixtures.noClubs())
        ..on(
          _submit,
          422,
          SignupFixtures.validation({
            'email': ['Dit e-mailadres klopt niet.'],
          }),
        ),
    );

    expect(http.requestsTo(_options).single.options.uri.queryParameters, {
      'sport': 'volleyball',
    });
    expect(find.text('Stap 1 van 5'), findsOneWidget);
    expect(find.byKey(const Key('signup-close')), findsOneWidget);

    await _type(tester, const Key('signup-club-search'), 'proef');
    await tester.pump(const Duration(milliseconds: 300));
    await pumpUntilFound(tester, find.byKey(const Key('signup-club-none')));
    expect(
      find.text(
        'Geen club gevonden voor “proef”. Typ de naam hieronder zelf, '
        'dan maken we hem aan.',
      ),
      findsOneWidget,
    );

    await _tap(tester, find.byKey(const Key('signup-club-not-listed')));
    expect(find.text('Hoe heet je club?'), findsOneWidget);
    await _type(tester, const Key('signup-club-name'), 'HV De Proefclub');
    await _tap(tester, find.byKey(const Key('signup-next')));

    expect(find.text('Welk team?'), findsOneWidget);
    await _type(tester, const Key('signup-designation'), 'DS1');
    await _tap(tester, find.byKey(const Key('signup-next')));
    // Ingetypte club: geen "staat er al"-vraag.
    expect(http.requestsTo(_existing), isEmpty);

    await _type(tester, const Key('signup-name'), 'Patrick');
    await _type(tester, const Key('signup-email'), 'patrick@example.com');
    await _tap(tester, find.byKey(const Key('signup-next')));
    expect(find.text('Verder'), findsOneWidget);
    await _tap(tester, find.byKey(const Key('signup-trainings-continue')));

    expect(find.text('Waar staat jullie programma?'), findsOneWidget);
    expect(find.text('Stap 5 van 5'), findsOneWidget);
    await _type(
      tester,
      const Key('signup-feed'),
      'https://api.nevobo.nl/export/team/x.ics',
    );
    await _tap(tester, find.byKey(const Key('signup-submit')));

    final body = http.requestsTo(_submit).single.body! as Map;
    expect(body['sport'], 'volleyball');
    expect(body['club_id'], isNull);
    expect(body['club_name'], 'HV De Proefclub');
    expect(body['designation'], 'DS1');
    expect(
      body['schedule_feed_url'],
      'https://api.nevobo.nl/export/team/x.ics',
    );

    // Terug op "Wie ben jij?" met de fout bij het adres.
    expect(find.text('Wie ben jij?'), findsOneWidget);
    expect(find.text('Dit e-mailadres klopt niet.'), findsOneWidget);
  });

  testWidgets(
    'elftal staat er al: melding, dan toch een nieuwe → duplicate_ok',
    (tester) async {
      final (container, http) = await _open(
        tester,
        AppRoutes.signupLink(sport: 'football'),
        until: find.text('Welke club?'),
        setup: (http) => http
          ..on(_options, 200, SignupFixtures.options(sport: 'football'))
          ..on(_clubs, 200, SignupFixtures.clubs())
          ..on(_existing, 200, SignupFixtures.existing())
          ..on(_submit, 202, SignupFixtures.sent(already: true)),
      );

      await _type(tester, const Key('signup-club-search'), 'vogel');
      await tester.pump(const Duration(milliseconds: 300));
      await pumpUntilFound(
        tester,
        find.byKey(const ValueKey('signup-club-412')),
      );
      await _tap(tester, find.byKey(const ValueKey('signup-club-412')));
      await _type(tester, const Key('signup-designation'), '3');
      await _tap(tester, find.byKey(const Key('signup-next')));

      expect(find.byKey(const ValueKey('signup-taken')), findsOneWidget);
      expect(find.text('Valleivogels 3 staat er al'), findsOneWidget);
      expect(find.text('Inloggen op Valleivogels 3'), findsOneWidget);

      // Ander team kiezen: terug naar het veld.
      await _tap(tester, find.byKey(const Key('signup-taken-other')));
      expect(find.byKey(const Key('signup-designation')), findsOneWidget);
      await _tap(tester, find.byKey(const Key('signup-next')));
      await _tap(tester, find.byKey(const Key('signup-taken-create')));

      expect(find.text('Wie ben jij?'), findsOneWidget);
      await _type(tester, const Key('signup-name'), 'Patrick');
      await _type(tester, const Key('signup-email'), 'patrick@example.com');
      await _tap(tester, find.byKey(const Key('signup-next')));
      await _tap(tester, find.byKey(const Key('signup-trainings-continue')));

      await pumpUntilFound(tester, find.byKey(const ValueKey('signup-sent')));
      expect(
        (http.requestsTo(_submit).single.body! as Map)['duplicate_ok'],
        true,
      );
      expect(find.text('Je hebt Valleivogels 3 al'), findsOneWidget);

      // Sluiten → loginscherm (uitgelogd).
      await _tap(tester, find.byKey(const Key('join-close')));
      expect(_location(container), AppRoutes.login);
    },
  );

  testWidgets(
    'errors.duplicate van de server toont de melding op de teamstap',
    (tester) async {
      final (_, http) = await _open(
        tester,
        AppRoutes.signupLink(sport: 'hockey'),
        until: find.text('Welke club?'),
        setup: (http) => http
          ..on(_options, 200, SignupFixtures.options(sport: 'hockey'))
          ..on(
            _submit,
            422,
            SignupFixtures.validation({
              'duplicate': [SignupFixtures.duplicateMessage],
            }),
          ),
      );

      await _tap(tester, find.byKey(const Key('signup-club-not-listed')));
      await _type(tester, const Key('signup-club-name'), 'HC Proef');
      await _tap(tester, find.byKey(const Key('signup-next')));
      await _type(tester, const Key('signup-designation'), 'Heren 3');
      await _tap(tester, find.byKey(const Key('signup-next')));
      await _type(tester, const Key('signup-name'), 'Patrick');
      await _type(tester, const Key('signup-email'), 'patrick@example.com');
      await _tap(tester, find.byKey(const Key('signup-next')));
      await _tap(tester, find.byKey(const Key('signup-trainings-continue')));

      expect(find.text('Dit team staat er al'), findsOneWidget);
      expect(find.text(SignupFixtures.duplicateMessage), findsOneWidget);
      expect(find.byKey(const Key('signup-taken-login')), findsNothing);
      expect(http.requestsTo(_submit), hasLength(1));
    },
  );

  testWidgets('429 bij versturen: eigen melding, blijft op de stap', (
    tester,
  ) async {
    await _open(
      tester,
      AppRoutes.signupLink(sport: 'hockey'),
      until: find.text('Welke club?'),
      setup: (http) => http
        ..on(_options, 200, SignupFixtures.options(sport: 'hockey'))
        ..on(_submit, 429, SignupFixtures.throttled()),
    );

    await _tap(tester, find.byKey(const Key('signup-club-not-listed')));
    await _type(tester, const Key('signup-club-name'), 'HC Proef');
    await _tap(tester, find.byKey(const Key('signup-next')));
    await _type(tester, const Key('signup-designation'), 'Heren 3');
    await _tap(tester, find.byKey(const Key('signup-next')));
    await _type(tester, const Key('signup-name'), 'Patrick');
    await _type(tester, const Key('signup-email'), 'patrick@example.com');
    await _tap(tester, find.byKey(const Key('signup-next')));
    await _tap(tester, find.byKey(const Key('signup-trainings-continue')));

    expect(
      find.text(
        'Je hebt het al een paar keer geprobeerd. Wacht even en probeer het '
        'dan opnieuw.',
      ),
      findsOneWidget,
    );
    expect(find.text('Wanneer trainen jullie?'), findsOneWidget);
  });

  testWidgets('terug-knop loopt de stappen terug, sluiten op de eerste', (
    tester,
  ) async {
    final (container, _) = await _open(
      tester,
      AppRoutes.signup,
      until: find.text('Welke sport?'),
      setup: (http) => http..on(_options, 200, SignupFixtures.options()),
    );

    await _tap(tester, find.byKey(const ValueKey('signup-sport-hockey')));
    expect(find.text('Welke club?'), findsOneWidget);
    await _tap(tester, find.byKey(const Key('signup-back')));
    expect(find.text('Welke sport?'), findsOneWidget);
    await _tap(tester, find.byKey(const Key('signup-close')));
    expect(_location(container), AppRoutes.login);
  });

  testWidgets('andere sport → aanvraag → "We hebben het"', (tester) async {
    final (_, http) = await _open(
      tester,
      AppRoutes.signup,
      until: find.text('Welke sport?'),
      setup: (http) => http
        ..on(_options, 200, SignupFixtures.options())
        ..on(_other, 202, SignupFixtures.requested()),
    );

    await _tap(tester, find.byKey(const Key('signup-other-sport-link')));
    expect(find.text('Welke sport doen jullie?'), findsOneWidget);
    expect(
      find.text(
        'Assistje doet voetbal, volleybal en hockey. Laat weten wat jullie '
        'spelen, dan weten wij waar de vraag zit.',
      ),
      findsOneWidget,
    );
    await _type(tester, const Key('signup-other-sport'), 'Handbal');
    await _type(tester, const Key('signup-other-club'), 'HV De Proefclub');
    await _type(tester, const Key('signup-other-name'), 'Patrick van Setten');
    await _type(tester, const Key('signup-other-email'), 'patrick@example.com');
    await _tap(tester, find.byKey(const Key('signup-other-submit')));

    await pumpUntilFound(
      tester,
      find.byKey(const ValueKey('signup-requested')),
    );
    expect(find.text('We hebben het'), findsOneWidget);
    expect(
      find.textContaining('Handbal zit nog niet in Assistje'),
      findsOneWidget,
    );
    expect(http.requestsTo(_other).single.body, {
      'sport': 'Handbal',
      'club_name': 'HV De Proefclub',
      'name': 'Patrick van Setten',
      'email': 'patrick@example.com',
    });
  });

  testWidgets('andere sport: 422 per veld', (tester) async {
    await _open(
      tester,
      AppRoutes.signup,
      until: find.text('Welke sport?'),
      setup: (http) => http
        ..on(_options, 200, SignupFixtures.options())
        ..on(
          _other,
          422,
          SignupFixtures.validation({
            'club_name': ['Deze clubnaam kunnen we niet gebruiken.'],
          }),
        ),
    );

    await _tap(tester, find.byKey(const Key('signup-other-sport-link')));
    await _type(tester, const Key('signup-other-sport'), 'Handbal');
    await _type(tester, const Key('signup-other-club'), '???');
    await _type(tester, const Key('signup-other-name'), 'Patrick');
    await _type(tester, const Key('signup-other-email'), 'patrick@example.com');
    await _tap(tester, find.byKey(const Key('signup-other-submit')));

    expect(
      find.text('Deze clubnaam kunnen we niet gebruiken.'),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('signup-requested')), findsNothing);
  });

  testWidgets('laadfout → opnieuw', (tester) async {
    late FakeHttpAdapter api;
    await _open(
      tester,
      AppRoutes.signup,
      until: find.byKey(const ValueKey('signup-load-error')),
      setup: (http) {
        api = http..on(_options, 500, {'message': 'Server Error'});
      },
    );
    expect(find.text('Aanmelden lukt nu niet'), findsOneWidget);

    api.on(_options, 200, SignupFixtures.options());
    await _tap(tester, find.text('Opnieuw'));
    await pumpUntilFound(tester, find.text('Welke sport?'));
  });

  testWidgets('ingelogd zonder team: knop op het geen-teamscherm, na aanmelden '
      '"Naar de app" en /me opnieuw geladen', (tester) async {
    final (container, http) = await _start(
      tester,
      token: '12|abc',
      ready: find.byKey(const Key('no-team-signup')),
      setup: (http) => http
        ..on(_options, 200, SignupFixtures.options(sport: 'hockey'))
        ..on(_submit, 202, SignupFixtures.sent()),
    );
    expect(find.text('Team aanmelden'), findsOneWidget);
    await _tap(tester, find.byKey(const Key('no-team-signup')));
    await pumpUntilFound(tester, find.text('Welke club?'));
    expect(_location(container), AppRoutes.signup);

    await _tap(tester, find.byKey(const Key('signup-club-not-listed')));
    await _type(tester, const Key('signup-club-name'), 'HC Proef');
    await _tap(tester, find.byKey(const Key('signup-next')));
    await _type(tester, const Key('signup-designation'), 'Heren 3');
    await _tap(tester, find.byKey(const Key('signup-next')));
    await _type(tester, const Key('signup-name'), 'Sam de Vries');
    await _type(tester, const Key('signup-email'), 'sam@example.com');
    await _tap(tester, find.byKey(const Key('signup-next')));

    final meCalls = http.requestsTo('GET /me').length;
    await _tap(tester, find.byKey(const Key('signup-trainings-continue')));
    await pumpUntilFound(tester, find.byKey(const ValueKey('signup-sent')));
    expect(find.byKey(const Key('signup-code-login')), findsNothing);
    expect(find.byKey(const Key('signup-to-app')), findsOneWidget);
    expect(http.requestsTo('GET /me').length, greaterThan(meCalls));
    expect(container.read(currentMembershipProvider), isNull);
  });
}
