import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/features/seasons/presentation/seasons_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import 'settings_fixtures.dart';

const _index = 'GET /teams/3/settings';

/// Start ingelogd als trainer van team 3 en opent `/settings`.
Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  Map<String, dynamic>? membership,
  void Function(FakeHttpAdapter http)? setup,
  String waitFor = 'settings-team-card',
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [membership ?? SettingsFixtures.trainerMembership()],
    setup: (http) {
      http.on(_index, 200, SettingsFixtures.response());
      setup?.call(http);
    },
  );
  container.read(routerProvider).go(AppRoutes.settings);
  await pumpUntilFound(tester, find.byKey(ValueKey(waitFor)));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Finder _key(String key) => find.byKey(ValueKey(key));

Future<void> _tap(WidgetTester tester, Finder finder) async {
  // Midden in beeld: bovenaan ligt de zwevende kop van de shell eroverheen.
  await Scrollable.ensureVisible(tester.element(finder), alignment: 0.5);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _tab(WidgetTester tester, String label) => _tap(
  tester,
  find.descendant(of: _key('settings-tabs'), matching: find.text(label)),
);

/// Laat een toast uitlopen (4 s) zodat er geen timer blijft hangen.
Future<void> _settleToast(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
}

bool _switchValue(WidgetTester tester, String key) =>
    tester.widget<Switch>(find.byKey(ValueKey(key))).value;

void main() {
  testWidgets('laadt: titel, tabs, team en agenda-links', (tester) async {
    await _open(tester);

    expect(currentTitle(tester), 'Instellingen');
    for (final label in [
      'Team',
      'Seizoen',
      'Deadlines',
      'Functies',
      'Diensten',
    ]) {
      expect(
        find.descendant(of: _key('settings-tabs'), matching: find.text(label)),
        findsOneWidget,
      );
    }
    expect(
      tester.widget<TextField>(_key('settings-team-name')).controller!.text,
      'Vogels 3',
    );
    expect(_key('settings-formation-4-3-3'), findsOneWidget);
    expect(_key('settings-ical-events'), findsOneWidget);
    expect(_key('settings-ical-trainings'), findsOneWidget);
    expect(_key('settings-read-only'), findsNothing);
    expect(_key('settings-team-save'), findsOneWidget);
    // Geen logo: geen "verwijderen" en geen "tot de rand".
    expect(_key('settings-logo-remove'), findsNothing);
    expect(_key('settings-logo-fills'), findsNothing);
  });

  testWidgets('team opslaan stuurt naam, kleur en opstelling', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        'PATCH /teams/3/settings/team',
        200,
        SettingsFixtures.response(
          SettingsFixtures.settings(
            team: SettingsFixtures.team(name: 'Vogels 4', formation: '4-4-2'),
          ),
        ),
      ),
    );

    await tester.enterText(_key('settings-team-name'), 'Vogels 4');
    await _tap(tester, _key('settings-swatch-#C8102E'));
    await _tap(tester, _key('settings-formation-4-4-2'));
    await _tap(tester, _key('settings-team-save'));

    expect(http.requestsTo('PATCH /teams/3/settings/team').single.body, {
      'name': 'Vogels 4',
      'primary_color': '#C8102E',
      'formation': '4-4-2',
    });
    expect(find.text('Opgeslagen'), findsOneWidget);
    await _settleToast(tester);
  });

  testWidgets('ongeldige kleur wordt niet verstuurd', (tester) async {
    final (_, http) = await _open(tester);

    await tester.enterText(_key('settings-team-color'), '#12');
    await _tap(tester, _key('settings-team-save'));

    expect(find.text('Gebruik een kleurcode als #006837.'), findsOneWidget);
    expect(http.requestsTo('PATCH /teams/3/settings/team'), isEmpty);
  });

  testWidgets('nieuwe agenda-link vraagt eerst bevestiging', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        'POST /teams/3/settings/ical/rotate',
        200,
        SettingsFixtures.response(
          SettingsFixtures.settings(
            ical: {
              'events_url': 'https://assistje.nl/calendar/XyZ48/events.ics',
              'trainings_url':
                  'https://assistje.nl/calendar/XyZ48/trainings.ics',
            },
          ),
        ),
      ),
    );

    await _tap(tester, _key('settings-ical-rotate'));
    await _tap(tester, _key('settings-confirm-cancel'));
    expect(http.requestsTo('POST /teams/3/settings/ical/rotate'), isEmpty);

    await _tap(tester, _key('settings-ical-rotate'));
    await _tap(tester, _key('settings-confirm-ok'));
    expect(http.requestsTo('POST /teams/3/settings/ical/rotate'), hasLength(1));
    expect(
      find.text('https://assistje.nl/calendar/XyZ48/events.ics'),
      findsOneWidget,
    );
    await _settleToast(tester);
  });

  testWidgets('functie uitzetten slaat meteen op (optimistisch)', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        'PATCH /teams/3/settings/features/fines',
        200,
        SettingsFixtures.response(
          SettingsFixtures.settings(
            features: SettingsFixtures.features(fines: false),
          ),
        ),
      ),
    );
    await _tab(tester, 'Functies');

    expect(_switchValue(tester, 'settings-feature-switch-fines'), isTrue);
    // Boetepot aan: staf-boetes en gasten in de boetepot zichtbaar.
    expect(_key('settings-staff-in-fines'), findsOneWidget);
    expect(_key('settings-guest-in-fines'), findsOneWidget);
    expect(_key('settings-carpool-hours'), findsOneWidget);

    await _tap(tester, _key('settings-feature-switch-fines'));

    expect(
      http.requestsTo('PATCH /teams/3/settings/features/fines').single.body,
      {'enabled': false},
    );
    expect(_switchValue(tester, 'settings-feature-switch-fines'), isFalse);
    expect(_key('settings-staff-in-fines'), findsNothing);
    expect(_key('settings-guest-in-fines'), findsNothing);
  });

  testWidgets('functie: fout draait terug en toont een melding', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on('PATCH /teams/3/settings/features/stats', 500, {
        'message': 'Kapot.',
      }),
    );
    await _tab(tester, 'Functies');

    await _tap(tester, _key('settings-feature-switch-stats'));

    expect(
      http.requestsTo('PATCH /teams/3/settings/features/stats'),
      hasLength(1),
    );
    expect(_switchValue(tester, 'settings-feature-switch-stats'), isTrue);
    expect(find.text('Opslaan mislukt'), findsOneWidget);
    await _settleToast(tester);
  });

  testWidgets('gasten en carpool-uren', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on(
          'PATCH /teams/3/settings/guests',
          200,
          SettingsFixtures.response(
            SettingsFixtures.settings(
              guests: {
                'attendance': 'none',
                'in_fines': false,
                'in_stats': true,
                'staff_in_fines': false,
              },
            ),
          ),
        )
        ..on(
          'PATCH /teams/3/settings/carpool-hours',
          200,
          SettingsFixtures.response(
            SettingsFixtures.settings(
              carpoolHours: 6,
              guests: {
                'attendance': 'none',
                'in_fines': false,
                'in_stats': true,
                'staff_in_fines': false,
              },
            ),
          ),
        ),
    );
    await _tab(tester, 'Functies');

    await _tap(tester, _key('settings-guests-none'));
    expect(http.requestsTo('PATCH /teams/3/settings/guests').single.body, {
      'guest_attendance': 'none',
    });
    // Gasten doen nergens aan mee: de schakelaars verdwijnen.
    expect(_key('settings-guest-in-stats'), findsNothing);

    await _tap(tester, _key('settings-carpool-6'));
    expect(
      http.requestsTo('PATCH /teams/3/settings/carpool-hours').single.body,
      {'hours': 6},
    );
  });

  testWidgets('deadlines: wekelijks opslaan', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        'PATCH /teams/3/settings/rsvp',
        200,
        SettingsFixtures.response(),
      ),
    );
    await _tab(tester, 'Deadlines');

    expect(_key('settings-rsvp-matches'), findsOneWidget);
    expect(
      find.text(
        '24 uur vooraf. Begint de wedstrijd om 14:30, dan is dat de dag '
        'ervoor om 14:30.',
      ),
      findsOneWidget,
    );

    await _tap(tester, _key('settings-rsvp-weekly'));
    expect(_key('settings-rsvp-matches'), findsNothing);
    await _tap(tester, _key('settings-rsvp-day-4'));
    await _tap(tester, _key('settings-rsvp-save'));

    expect(http.requestsTo('PATCH /teams/3/settings/rsvp').single.body, {
      'rsvp_deadline_mode': 'weekly',
      'rsvp_weekly_day': 4,
      'rsvp_weekly_time': '00:00',
    });
    await _settleToast(tester);
  });

  testWidgets('seizoen: alleen-lezen en door naar /seasons', (tester) async {
    final (container, _) = await _open(tester);
    await _tab(tester, 'Seizoen');

    expect(find.text('2026/2027'), findsOneWidget);
    expect(_key('settings-period-5'), findsOneWidget);
    expect(_key('settings-season-expired'), findsNothing);

    await _tap(tester, _key('settings-open-seasons'));
    expect(container.read(routerProvider).state.uri.path, AppRoutes.seasons);
    expect(find.byType(SeasonsScreen), findsOneWidget);
  });

  testWidgets('diensttype aanmaken via de sheet', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        'POST /teams/3/settings/duty-types',
        201,
        SettingsFixtures.response(
          SettingsFixtures.settings(
            dutyTypes: [
              SettingsFixtures.wash(),
              SettingsFixtures.canteen(),
              {
                ...SettingsFixtures.wash(),
                'id': 31,
                'name': 'Rijden',
                'icon': 'Car',
                'auto_rotate': false,
              },
            ],
          ),
        ),
      ),
    );
    expect(_key('settings-duty-add'), findsNothing);
    await _tab(tester, 'Diensten');

    expect(_key('settings-duty-12'), findsOneWidget);
    expect(_key('settings-duty-13'), findsOneWidget);
    await _tap(tester, _key('settings-duty-add'));
    expect(_key('settings-duty-form'), findsOneWidget);

    // Lege naam: niets verstuurd.
    await _tap(tester, _key('settings-duty-submit'));
    expect(find.text('Vul een naam in.'), findsOneWidget);
    expect(http.requestsTo('POST /teams/3/settings/duty-types'), isEmpty);

    await tester.enterText(_key('settings-duty-name'), 'Rijden');
    await _tap(tester, _key('settings-duty-icon-Car'));
    await _tap(tester, _key('settings-duty-mode-individual'));
    await _tap(tester, _key('settings-duty-scope-match'));
    expect(_key('settings-duty-auto-rotate'), findsOneWidget);
    await _tap(tester, _key('settings-duty-guests'));
    await _tap(tester, _key('settings-duty-submit'));

    expect(http.requestsTo('POST /teams/3/settings/duty-types').single.body, {
      'name': 'Rijden',
      'icon': 'Car',
      'mode': 'individual',
      'scope': 'match',
      'auto_rotate': false,
      'on_unavailable': 'reassign',
      'pool': ['players', 'guests'],
      'pool_members': <String>[],
    });
    expect(_key('settings-duty-form'), findsNothing);
    expect(_key('settings-duty-31'), findsOneWidget);
    expect(find.text('Diensttype toegevoegd'), findsOneWidget);
    await _settleToast(tester);
  });

  testWidgets('diensttype: 422 op naam blijft in de sheet', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on('POST /teams/3/settings/duty-types', 422, {
        'message': 'Ongeldig.',
        'errors': {
          'name': ['Deze naam bestaat al.'],
        },
      }),
    );
    await _tab(tester, 'Diensten');
    await _tap(tester, _key('settings-duty-add'));
    await tester.enterText(_key('settings-duty-name'), 'Wassen');
    await _tap(tester, _key('settings-duty-submit'));

    expect(find.text('Deze naam bestaat al.'), findsOneWidget);
    expect(_key('settings-duty-form'), findsOneWidget);
  });

  testWidgets('diensttype wijzigen en verwijderen', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on(
          'PATCH /teams/3/settings/duty-types/13',
          200,
          SettingsFixtures.response(),
        )
        ..on(
          'DELETE /teams/3/settings/duty-types/13',
          200,
          SettingsFixtures.response(
            SettingsFixtures.settings(dutyTypes: [SettingsFixtures.wash()]),
          ),
        ),
    );
    await _tab(tester, 'Diensten');

    await _tap(tester, _key('settings-duty-13'));
    // Groepsdienst: geen "zelf kiezen" in de pool.
    expect(_key('settings-duty-pool-custom'), findsNothing);
    await _tap(tester, _key('settings-duty-pool-staff'));
    await _tap(tester, _key('settings-duty-submit'));
    final sent =
        http.requestsTo('PATCH /teams/3/settings/duty-types/13').single.body!
            as Map;
    expect(sent['name'], 'Kantine');
    expect(sent['mode'], 'group');
    expect(sent['pool'], ['players', 'staff']);
    await _settleToast(tester);

    await _tap(tester, _key('settings-duty-delete-13'));
    await _tap(tester, _key('settings-confirm-ok'));
    expect(
      http.requestsTo('DELETE /teams/3/settings/duty-types/13'),
      hasLength(1),
    );
    expect(_key('settings-duty-13'), findsNothing);
    await _settleToast(tester);
  });

  testWidgets('demo-team: alleen-lezen', (tester) async {
    await _open(
      tester,
      membership: SettingsFixtures.trainerMembership(demo: true),
    );

    expect(_key('settings-read-only'), findsOneWidget);
    expect(
      find.text(
        'Dit is een demoteam: je kunt rondkijken, maar niets wijzigen.',
      ),
      findsOneWidget,
    );
    expect(_key('settings-team-save'), findsNothing);
    expect(_key('settings-ical-rotate'), findsNothing);
    expect(_key('settings-logo-upload'), findsNothing);
    // Agenda-links kopiëren mag wel.
    expect(_key('settings-ical-copy-events'), findsOneWidget);

    await _tab(tester, 'Functies');
    expect(
      tester.widget<Switch>(_key('settings-feature-switch-fines')).onChanged,
      isNull,
    );

    await _tab(tester, 'Diensten');
    expect(_key('settings-duty-add'), findsNothing);
    expect(_key('settings-duty-delete-12'), findsNothing);
  });

  testWidgets('403 op laden: alleen voor de trainer', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_index, 403, {'message': 'Nee.'}),
      waitFor: 'settings-forbidden',
    );

    expect(find.text('Alleen voor de trainer'), findsOneWidget);
    expect(_key('settings-tabs'), findsNothing);
  });

  testWidgets('403 bij schrijven: valt terug op alleen-lezen', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on('PATCH /teams/3/settings/features/fines', 403, {
        'message': 'Demo.',
      }),
    );
    await _tab(tester, 'Functies');

    await _tap(tester, _key('settings-feature-switch-fines'));

    expect(_key('settings-read-only'), findsOneWidget);
    expect(_switchValue(tester, 'settings-feature-switch-fines'), isTrue);
    expect(
      tester.widget<Switch>(_key('settings-feature-switch-fines')).onChanged,
      isNull,
    );
    await _settleToast(tester);
  });

  testWidgets('laadfout toont opnieuw proberen', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(_index, 500, {'message': 'Kapot.'}),
      waitFor: 'settings-error',
    );

    http.on(_index, 200, SettingsFixtures.response());
    await _tap(tester, _key('settings-retry'));
    await pumpUntilFound(tester, _key('settings-team-card'));
    expect(_key('settings-error'), findsNothing);
  });
}
