import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/core/theme/theme_providers.dart';
import 'package:assistje/features/agenda/presentation/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/shell.dart';

const _agendaRoute = 'GET /teams/3/agenda';
const _rsvpRoute = 'PATCH /teams/3/events/412/attendance';

RsvpButton _button(WidgetTester tester, String status, {int id = 412}) =>
    tester.widget<RsvpButton>(find.byKey(ValueKey('rsvp-$id-$status')));

Future<void> _tapRsvp(
  WidgetTester tester,
  String status, {
  int id = 412,
}) async {
  await tester.tap(find.byKey(ValueKey('rsvp-$id-$status')));
  await tester.pumpAndSettle();
}

void main() {
  final player = ApiFixtures.membership();

  testWidgets('toont aankomend: event, gevouwen dienst, jarige, tellers', (
    tester,
  ) async {
    await pumpSignedIn(
      tester,
      teams: [player],
      agenda: ApiFixtures.agendaResponse(),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('event-412')), findsOneWidget);
    expect(find.text('Vogels 3 - Arnhemia 2'), findsOneWidget);
    expect(find.text('WEDSTRIJD'), findsOneWidget);
    // De wasdienst hangt onder de wedstrijd, met voornaam.
    expect(find.text('Sam'), findsOneWidget);
    expect(find.text('Joris'), findsOneWidget);
    expect(find.text('wordt 24 jaar'), findsOneWidget);
    // 11 van 16 gereageerd.
    expect(find.text('11/16'), findsOneWidget);
    // Knop-tellers: spelers + gasten.
    expect(_button(tester, 'present').count, 8);
    expect(_button(tester, 'absent').count, 2);
    expect(_button(tester, 'nonplay').count, 0);
    expect(_button(tester, 'present').selected, isFalse);
  });

  testWidgets('Verleden en Mijn taken', (tester) async {
    await pumpSignedIn(
      tester,
      teams: [player],
      agenda: ApiFixtures.agendaResponse(
        past: [
          ApiFixtures.agendaEvent(
            id: 300,
            type: 'training',
            title: 'Training',
            year: 2025,
            myStatus: 'present',
          ),
        ],
        myTasks: [
          ApiFixtures.agendaDuty(
            dutyId: 77,
            eventId: null,
            matchBound: false,
            title: 'Kantinedienst',
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Verleden'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('event-300')), findsOneWidget);
    expect(find.byKey(const ValueKey('event-412')), findsNothing);
    // In Verleden is je antwoord alleen nog de stand.
    expect(_button(tester, 'present', id: 300).selected, isTrue);
    expect(_button(tester, 'present', id: 300).onTap, isNull);

    await tester.tap(find.text('Mijn taken'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('task-duty-77')), findsOneWidget);
    expect(find.text('KANTINEDIENST'), findsOneWidget);
  });

  testWidgets('afgelast en live krijgen hun badge; geen RSVP-knoppen', (
    tester,
  ) async {
    await pumpSignedIn(
      tester,
      teams: [player],
      agenda: ApiFixtures.agendaResponse(
        upcoming: [
          ApiFixtures.agendaEvent(isLive: true),
          ApiFixtures.agendaEvent(
            id: 413,
            type: 'training',
            title: 'Training',
            cancelledAt: '2099-10-01T10:00:00+02:00',
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('live-badge')), findsOneWidget);
    expect(find.text("LIVE · 38'"), findsOneWidget);
    expect(find.text('1 - 0'), findsOneWidget);
    // Live = aanwezigheid staat vast.
    expect(_button(tester, 'present').onTap, isNull);
    expect(find.byKey(const ValueKey('event-413-cancelled')), findsOneWidget);
    expect(find.byKey(const ValueKey('rsvp-413-present')), findsNothing);
  });

  testWidgets('RSVP: tik stuurt PATCH en zet de stand meteen', (tester) async {
    await pumpSignedIn(
      tester,
      teams: [player],
      agenda: ApiFixtures.agendaResponse(),
      setup: (http) => http.on(
        _rsvpRoute,
        200,
        ApiFixtures.attendanceResponse(status: 'present', reason: null),
      ),
    );
    await tester.pumpAndSettle();

    await _tapRsvp(tester, 'present');

    expect(_button(tester, 'present').selected, isTrue);
    expect(_button(tester, 'present').count, 9);
    expect(find.text('12/16'), findsOneWidget);
  });

  testWidgets('RSVP: verzoek-body en terug naar openstaand', (tester) async {
    late FakeHttpAdapter api;
    await pumpSignedIn(
      tester,
      teams: [player],
      agenda: ApiFixtures.agendaResponse(),
      setup: (http) {
        api = http;
        http.on(
          _rsvpRoute,
          200,
          ApiFixtures.attendanceResponse(status: 'present', reason: null),
        );
      },
    );
    await tester.pumpAndSettle();

    await _tapRsvp(tester, 'present');
    await _tapRsvp(tester, 'present');

    final bodies = [for (final r in api.requestsTo(_rsvpRoute)) r.body];
    expect(bodies, [
      {'status': 'present'},
      {'status': 'pending'},
    ]);
    expect(_button(tester, 'present').selected, isFalse);
    expect(_button(tester, 'present').count, 8);
  });

  testWidgets('RSVP mislukt: terugdraaien en een toast', (tester) async {
    await pumpSignedIn(
      tester,
      teams: [player],
      agenda: ApiFixtures.agendaResponse(),
      setup: (http) => http.on(_rsvpRoute, 500, {'message': 'Server Error'}),
    );
    await tester.pumpAndSettle();

    await _tapRsvp(tester, 'present');

    expect(_button(tester, 'present').selected, isFalse);
    expect(_button(tester, 'present').count, 8);
    expect(find.text('Opslaan mislukt. Probeer opnieuw.'), findsOneWidget);
    // Toast laten verlopen.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
  });

  testWidgets('422 met errors.reason: reden vragen en opnieuw versturen', (
    tester,
  ) async {
    late FakeHttpAdapter api;
    await pumpSignedIn(
      tester,
      teams: [player],
      agenda: ApiFixtures.agendaResponse(),
      setup: (http) {
        api = http;
        http.routes[_rsvpRoute] = (request) {
          final body = request.body! as Map<String, dynamic>;
          if (body['reason'] == null) {
            return const FakeResponse(422, {
              'message': 'Geef een reden op.',
              'errors': {
                'reason': ['Geef een reden op.'],
              },
            });
          }
          return FakeResponse(200, ApiFixtures.attendanceResponse());
        };
      },
    );
    await tester.pumpAndSettle();

    await _tapRsvp(tester, 'absent');

    // Teruggedraaid, en de sheet vraagt waarom.
    expect(find.text('Waarom ben je er niet?'), findsOneWidget);
    expect(find.byKey(const ValueKey('reason-error')), findsOneWidget);
    expect(_button(tester, 'absent').selected, isFalse);

    await tester.tap(find.byKey(const ValueKey('reason-quick-Ziek')));
    await tester.pumpAndSettle();

    final bodies = [for (final r in api.requestsTo(_rsvpRoute)) r.body];
    expect(bodies, [
      {'status': 'absent'},
      {'status': 'absent', 'reason': 'Ziek'},
    ]);
    expect(find.text('Waarom ben je er niet?'), findsNothing);
    expect(_button(tester, 'absent').selected, isTrue);
    expect(_button(tester, 'absent').count, 3);
  });

  testWidgets('feature absence_reason: eerst de sheet, eigen reden typen', (
    tester,
  ) async {
    late FakeHttpAdapter api;
    await pumpSignedIn(
      tester,
      teams: [
        ApiFixtures.membership(features: {'absence_reason': true}),
      ],
      agenda: ApiFixtures.agendaResponse(),
      setup: (http) {
        api = http;
        http.on(
          _rsvpRoute,
          200,
          ApiFixtures.attendanceResponse(status: 'nonplay', reason: 'Knie'),
        );
      },
    );
    await tester.pumpAndSettle();

    await _tapRsvp(tester, 'nonplay');
    expect(find.text('Waarom speel je niet mee?'), findsOneWidget);
    expect(api.requestsTo(_rsvpRoute), isEmpty);

    // Wegvegen = niets versturen.
    await tester.tapAt(const Offset(20, 20));
    await tester.pumpAndSettle();
    expect(api.requestsTo(_rsvpRoute), isEmpty);
    expect(_button(tester, 'nonplay').selected, isFalse);

    await _tapRsvp(tester, 'nonplay');
    await tester.enterText(find.byKey(const ValueKey('reason-input')), 'Knie');
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('reason-submit')));
    await tester.pumpAndSettle();

    expect(api.requestsTo(_rsvpRoute).single.body, {
      'status': 'nonplay',
      'reason': 'Knie',
    });
    expect(_button(tester, 'nonplay').selected, isTrue);
  });

  testWidgets('lege agenda toont de lege staat', (tester) async {
    await pumpSignedIn(tester, teams: [player]);
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('agenda-empty')), findsOneWidget);
    expect(find.text('Nog niets gepland'), findsOneWidget);
    expect(
      find.text(
        'Zodra je trainer wedstrijden of trainingen inplant, staan ze hier.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('fout bij laden: foutstaat met opnieuw proberen', (tester) async {
    late FakeHttpAdapter api;
    await pumpSignedIn(
      tester,
      teams: [player],
      setup: (http) {
        api = http;
        http.on(_agendaRoute, 500, {'message': 'Server Error'});
      },
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('agenda-error')), findsOneWidget);
    expect(find.text('De agenda kon niet geladen worden.'), findsOneWidget);

    api.on(_agendaRoute, 200, ApiFixtures.agendaResponse());
    await tester.tap(find.byKey(const ValueKey('agenda-retry')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('agenda-error')), findsNothing);
    expect(find.byKey(const ValueKey('event-412')), findsOneWidget);
  });

  testWidgets('Nog 30 tonen haalt een groter venster op', (tester) async {
    late FakeHttpAdapter api;
    List<Map<String, dynamic>> events(int count) => [
      for (var i = 0; i < count; i++)
        ApiFixtures.agendaEvent(
          id: 1000 + i,
          startsAt:
              '2099-${(1 + i ~/ 28).toString().padLeft(2, '0')}-'
              '${(1 + i % 28).toString().padLeft(2, '0')}T19:00:00+02:00',
        ),
    ];
    await pumpSignedIn(
      tester,
      teams: [player],
      setup: (http) {
        api = http;
        http.routes[_agendaRoute] = (request) {
          final limit =
              int.tryParse(
                request.options.uri.queryParameters['limit'] ?? '',
              ) ??
              30;
          return FakeResponse(
            200,
            ApiFixtures.agendaResponse(
              upcoming: events(limit >= 60 ? 35 : 30),
              upcomingDuties: const [],
              birthdays: const [],
              upcomingTotal: 35,
              limit: limit,
            ),
          );
        };
      },
    );
    await tester.pumpAndSettle();

    final list = find.descendant(
      of: find.byKey(const ValueKey('agenda-screen')),
      matching: find.byType(Scrollable),
    );
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('event-1029')),
      600,
      scrollable: list.first,
    );
    await tester.pumpAndSettle();
    final more = find.byKey(const ValueKey('agenda-more'));
    if (more.evaluate().isNotEmpty) {
      expect(find.text('Nog 5 tonen'), findsOneWidget);
      await tester.ensureVisible(more);
      await tester.tap(more);
      await tester.pumpAndSettle();
    }

    final windows = [
      for (final r in api.requestsTo(_agendaRoute))
        r.options.uri.queryParameters['limit'],
    ];
    expect(windows, [null, '60']);
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('event-1034')),
      600,
      scrollable: list.first,
    );
    expect(find.byKey(const ValueKey('agenda-more')), findsNothing);
  });

  testWidgets('trekken om te verversen laadt opnieuw', (tester) async {
    late FakeHttpAdapter api;
    await pumpSignedIn(
      tester,
      teams: [player],
      agenda: ApiFixtures.agendaResponse(),
      setup: (http) => api = http,
    );
    await tester.pumpAndSettle();
    expect(api.requestsTo(_agendaRoute), hasLength(1));

    await tester.fling(
      find.byKey(const ValueKey('agenda-title')),
      const Offset(0, 400),
      1000,
    );
    await tester.pumpAndSettle();

    expect(api.requestsTo(_agendaRoute), hasLength(2));
  });

  testWidgets('tik op een event opent het event', (tester) async {
    final (container, _) = await pumpSignedIn(
      tester,
      teams: [player],
      agenda: ApiFixtures.agendaResponse(),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Vogels 3 - Arnhemia 2'));
    await tester.pumpAndSettle();

    expect(container.read(routerProvider).state.uri.path, '/events/412');
  });

  testWidgets('donker thema rendert zonder fouten', (tester) async {
    await pumpSignedIn(
      tester,
      teams: [player],
      prefs: {ThemeModeNotifier.storageKey: 'dark'},
      agenda: ApiFixtures.agendaResponse(
        upcoming: [
          ApiFixtures.agendaEvent(myStatus: 'absent'),
          ApiFixtures.agendaEvent(id: 500, isLive: true),
        ],
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(_button(tester, 'absent').selected, isTrue);
  });

  testWidgets('trainer: + Nieuw opent het event-formulier', (tester) async {
    final (container, _) = await pumpSignedIn(
      tester,
      teams: [ApiFixtures.membership(role: 'trainer')],
      setup: (http) => http.on('GET /teams/3/schedule/options', 200, {
        'data': {'team_name': 'Vogels 3'},
      }),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('agenda-new-event')));
    await tester.pumpAndSettle();

    final uri = container.read(routerProvider).state.uri;
    expect(uri.path, AppRoutes.schedule);
    expect(uri.queryParameters, isEmpty);
    expect(find.byKey(const ValueKey('schedule-form')), findsOneWidget);
  });

  testWidgets('speler ziet geen + Nieuw', (tester) async {
    await pumpSignedIn(tester, teams: [player]);
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('agenda-new-event')), findsNothing);
  });

  testWidgets('demo-trainer ziet geen + Nieuw', (tester) async {
    final trainer = ApiFixtures.membership(role: 'trainer');
    await pumpSignedIn(
      tester,
      teams: [
        {
          ...trainer,
          'team': {...trainer['team'] as Map<String, dynamic>, 'is_demo': true},
        },
      ],
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('agenda-new-event')), findsNothing);
  });
}
