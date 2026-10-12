import 'dart:async';

import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import 'event_fixtures.dart';

const _detail = 'GET /teams/3/events/412';
const _rsvp = 'PATCH /teams/3/events/412/attendance';
const _agenda = 'GET /teams/3/agenda';
const _future = '2099-10-11T14:30:00+02:00';
const _past = '2020-10-11T14:30:00+02:00';

const Map<String, bool> _features = {
  'motm': true,
  'carpool': true,
  'absence_reason': true,
};

/// Start ingelogd met [membership], zet het event-detail klaar en opent
/// `/events/412`. Geeft de backend terug.
Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  required Map<String, dynamic> detail,
  Map<String, dynamic>? membership,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [membership ?? ApiFixtures.membership(features: _features)],
    setup: (http) {
      http.on(_detail, 200, detail);
      setup?.call(http);
    },
  );
  unawaited(container.read(routerProvider).push(AppRoutes.event(412)));
  await pumpUntilFound(
    tester,
    find.byKey(const ValueKey('event-detail-screen')),
  );
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Finder _inScreen(Finder finder) => find.descendant(
  of: find.byKey(const ValueKey('event-detail-screen')),
  matching: finder,
);

Future<void> _scrollTo(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    300,
    scrollable: _inScreen(find.byType(Scrollable)).first,
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('toont info, RSVP, opkomst, carpool en de lijst', (tester) async {
    await _open(
      tester,
      detail: EventFixtures.withMe({
        'starts_at': _future,
        'meet_at': '2099-10-11T13:15:00+02:00',
        'ends_at': '2099-10-11T16:15:00+02:00',
      }),
    );

    expect(find.text('Arnhemia 2 - Vogels 3'), findsOneWidget);
    expect(find.text('COMPETITIE'), findsOneWidget);
    expect(find.text('Uit'), findsOneWidget);
    expect(find.text('Sportpark Arnhemia'), findsOneWidget);
    expect(find.text('Witte sokken mee.'), findsOneWidget);
    expect(find.text('Veld 2'), findsOneWidget);
    expect(find.text('Kleedkamer 4'), findsOneWidget);
    expect(find.text('J. de Vries'), findsOneWidget);
    // Eigen RSVP: afwezig gekozen, met reden.
    expect(find.byKey(const ValueKey('event-rsvp-present')), findsOneWidget);
    expect(find.byKey(const ValueKey('event-rsvp-nonplay')), findsOneWidget);
    expect(find.text('Reden: Ziek'), findsOneWidget);
    expect(find.byKey(const ValueKey('event-rsvp-locked')), findsNothing);
    // Geen trainer: geen knop naar de aanwezigheid.
    expect(find.byKey(const ValueKey('event-action-attendance')), findsNothing);
    // Wedstrijd nog niet gespeeld: geen MOTM.
    expect(find.byKey(const ValueKey('event-motm')), findsNothing);

    await _scrollTo(tester, find.byKey(const ValueKey('event-responses')));
    expect(find.text('12 van 16 gereageerd'), findsOneWidget);

    await _scrollTo(tester, find.byKey(const ValueKey('event-carpool')));
    expect(find.text('Trainer Tom'), findsWidgets);
    expect(find.text('3 plekken'), findsOneWidget);
    expect(find.text('+ Ik rijd'), findsOneWidget);

    await _scrollTo(tester, find.byKey(const ValueKey('event-group-staff')));
    expect(find.byKey(const ValueKey('event-group-present')), findsOneWidget);
    // (Kees staat ook op de vlaggersregel in de dienstenkaart.)
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('event-group-present')),
        matching: find.text('Kees Jansen'),
      ),
      findsOneWidget,
    );
    expect(find.text('keeper'), findsOneWidget);
    expect(find.text('1/1'), findsOneWidget);
    await _scrollTo(tester, find.byKey(const ValueKey('event-group-absent')));
    // Jouw rij heet "Jij" (de dienstenkaart heeft een eigen Jij-badge).
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('event-group-absent')),
        matching: find.text('Jij'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('RSVP met reden-sheet: PATCH en de agenda ververst', (
    tester,
  ) async {
    var answered = false;
    final (container, http) = await _open(
      tester,
      detail: EventFixtures.withMe({
        'starts_at': _future,
        'my_status': 'present',
        'my_reason': null,
      }),
      setup: (http) {
        http.routes[_rsvp] = (_) {
          answered = true;
          return FakeResponse(200, ApiFixtures.attendanceResponse());
        };
        http.routes[_detail] = (_) => FakeResponse(
          200,
          EventFixtures.withMe({
            'starts_at': _future,
            'my_status': answered ? 'absent' : 'present',
            'my_reason': answered ? 'Ziek' : null,
          }),
        );
      },
    );
    final agendaBefore = http.requestsTo(_agenda).length;

    await tester.tap(find.byKey(const ValueKey('event-rsvp-absent')));
    await tester.pumpAndSettle();
    // Team vraagt een reden: eerst de sheet, nog niets verstuurd.
    expect(find.byKey(const ValueKey('reason-input')), findsOneWidget);
    expect(http.requestsTo(_rsvp), isEmpty);

    await tester.tap(find.byKey(const ValueKey('reason-quick-Ziek')));
    await tester.pumpAndSettle();

    expect(http.requestsTo(_rsvp).single.body, {
      'status': 'absent',
      'reason': 'Ziek',
    });
    expect(find.text('Reden: Ziek'), findsOneWidget);

    // Terug naar de agenda: die haalt het nieuwe antwoord op.
    container.read(routerProvider).pop();
    await tester.pumpAndSettle();
    expect(http.requestsTo(_agenda).length, greaterThan(agendaBefore));
  });

  testWidgets('RSVP vast als can_change uit staat', (tester) async {
    final (_, http) = await _open(
      tester,
      detail: EventFixtures.withMe({'starts_at': _past, 'can_change': false}),
    );

    expect(find.byKey(const ValueKey('event-rsvp-locked')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('event-rsvp-present')));
    await tester.pumpAndSettle();
    expect(http.requestsTo(_rsvp), isEmpty);
  });

  testWidgets('MOTM: stemmen op een ander, niet op jezelf', (tester) async {
    final (_, http) = await _open(
      tester,
      detail: EventFixtures.withMe({
        'starts_at': _past,
        'can_change': false,
        'motm': EventFixtures.openMotm(),
      }),
      setup: (http) => http.on(
        'POST /teams/3/events/412/motm',
        200,
        EventFixtures.motmVote(),
      ),
    );

    expect(find.byKey(const ValueKey('event-motm')), findsOneWidget);
    expect(find.text('Stem op je uitblinker (niet jezelf):'), findsOneWidget);
    expect(find.byKey(const ValueKey('motm-candidate-42')), findsNothing);
    expect(find.byKey(const ValueKey('motm-my-vote')), findsNothing);

    await tester.tap(find.byKey(const ValueKey('motm-candidate-37')));
    await tester.pumpAndSettle();

    expect(http.requestsTo('POST /teams/3/events/412/motm').single.body, {
      'voted_player_id': 37,
    });
    expect(find.byKey(const ValueKey('motm-my-vote')), findsOneWidget);
  });

  testWidgets('MOTM dicht: winnaar en stand', (tester) async {
    await _open(
      tester,
      detail: EventFixtures.eventDetail({
        'starts_at': _past,
        'can_change': false,
        'motm': {
          ...EventFixtures.openMotm(),
          'is_open': false,
          'tally': [
            {'player_id': 44, 'votes': 3},
            {'player_id': 37, 'votes': 1},
          ],
        },
      }),
    );

    expect(find.byKey(const ValueKey('motm-winner')), findsOneWidget);
    expect(find.text('Joris Smit'), findsWidgets);
    expect(find.text('3 stemmen'), findsOneWidget);
  });

  testWidgets('carpool: aanmelden met plekken', (tester) async {
    final (_, http) = await _open(
      tester,
      detail: EventFixtures.eventDetail({'starts_at': _future}),
      setup: (http) => http.on(
        'POST /teams/3/events/412/carpool',
        201,
        EventFixtures.carpoolOffer(),
      ),
    );

    await _scrollTo(tester, find.byKey(const ValueKey('carpool-open')));
    await tester.tap(find.byKey(const ValueKey('carpool-open')));
    await tester.pumpAndSettle();
    expect(find.text('Hoe ga je naar de wedstrijd?'), findsOneWidget);
    expect(find.byKey(const ValueKey('carpool-seats')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('carpool-seats-less')));
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('carpool-submit')));
    await tester.pumpAndSettle();

    expect(http.requestsTo('POST /teams/3/events/412/carpool').single.body, {
      'mode': 'from_club',
      'seats': 3,
    });
    expect(find.text('Ruud de Rijder'), findsOneWidget);
    expect(find.text('Mijn aanmelding wijzigen'), findsOneWidget);
  });

  testWidgets('carpool alleen met de feature', (tester) async {
    await _open(
      tester,
      membership: ApiFixtures.membership(),
      detail: EventFixtures.eventDetail({'starts_at': _future}),
    );

    expect(find.byKey(const ValueKey('event-carpool')), findsNothing);
  });

  testWidgets('trainer ziet de knop naar de aanwezigheid', (tester) async {
    await _open(
      tester,
      membership: ApiFixtures.membership(role: 'trainer', features: _features),
      detail: EventFixtures.eventDetail({
        'starts_at': _future,
        'is_trainer': true,
      }),
    );

    expect(find.byKey(const ValueKey('event-action-lineup')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('event-action-attendance')),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const ValueKey('event-action-attendance')));
    await tester.pumpAndSettle();
    expect(currentTitle(tester), 'Aanwezigheid');
    // Het echte aanwezigheidsscherm, geen placeholder meer.
    expect(find.byKey(const ValueKey('attendance-screen')), findsOneWidget);
  });

  testWidgets('toeschouwer: geen RSVP en geen beheerknoppen', (tester) async {
    await _open(
      tester,
      membership: ApiFixtures.membership(
        role: 'spectator',
        features: _features,
      ),
      detail: EventFixtures.eventDetail({
        'starts_at': _future,
        'my_status': null,
        'my_reason': null,
        'can_rsvp': false,
        'can_change': false,
      }),
    );

    expect(find.byKey(const ValueKey('event-info')), findsOneWidget);
    expect(find.byKey(const ValueKey('event-rsvp')), findsNothing);
    expect(find.byKey(const ValueKey('event-actions')), findsNothing);
  });

  testWidgets('afgelast: melding en geen RSVP', (tester) async {
    await _open(
      tester,
      detail: EventFixtures.withMe({
        'starts_at': _future,
        'cancelled_at': '2099-10-01T10:00:00+02:00',
      }),
    );

    expect(find.byKey(const ValueKey('event-cancelled')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('event-cancelled-notice')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('event-rsvp')), findsNothing);
  });

  testWidgets('fout bij laden: melding en opnieuw proberen', (tester) async {
    final (_, http) = await _open(
      tester,
      detail: EventFixtures.eventDetail(),
      setup: (http) => http.on(_detail, 404, {'message': 'Niet gevonden.'}),
    );

    expect(find.byKey(const ValueKey('event-error')), findsOneWidget);
    expect(currentTitle(tester), 'Activiteit');

    http.on(_detail, 200, EventFixtures.eventDetail({'starts_at': _future}));
    await tester.tap(find.byKey(const ValueKey('event-retry')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('event-error')), findsNothing);
    expect(find.text('Arnhemia 2 - Vogels 3'), findsOneWidget);
  });

  group('trainer: bewerken, afgelasten, verwijderen', () {
    final trainer = ApiFixtures.membership(
      role: 'trainer',
      features: _features,
    );
    final detail = EventFixtures.eventDetail({
      'starts_at': _future,
      'is_trainer': true,
      'can_cancel': true,
    });

    testWidgets('trainer ziet bewerken, afgelasten en verwijderen', (
      tester,
    ) async {
      await _open(tester, membership: trainer, detail: detail);
      expect(
        find.byKey(const ValueKey('event-trainer-actions')),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('event-trainer-edit')), findsOneWidget);
      expect(
        find.byKey(const ValueKey('event-trainer-cancel')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('event-trainer-delete')),
        findsOneWidget,
      );
    });

    testWidgets('bondsevent: geen afgelasten-knop', (tester) async {
      await _open(
        tester,
        membership: trainer,
        detail: EventFixtures.eventDetail({
          'starts_at': _future,
          'is_trainer': true,
        }),
      );
      expect(find.byKey(const ValueKey('event-trainer-edit')), findsOneWidget);
      expect(find.byKey(const ValueKey('event-trainer-cancel')), findsNothing);
    });

    testWidgets('speler ziet geen beheerknoppen', (tester) async {
      await _open(tester, detail: detail);
      expect(find.byKey(const ValueKey('event-trainer-actions')), findsNothing);
    });

    testWidgets('demo-trainer ziet geen beheerknoppen', (tester) async {
      final demo = {
        ...trainer,
        'team': {...trainer['team'] as Map<String, dynamic>, 'is_demo': true},
      };
      await _open(tester, membership: demo, detail: detail);
      expect(find.byKey(const ValueKey('event-trainer-actions')), findsNothing);
    });

    testWidgets('afgelasten: eerst bevestigen, dan POST en verversen', (
      tester,
    ) async {
      const cancel = 'POST /teams/3/schedule/412/cancel';
      final (_, http) = await _open(
        tester,
        membership: trainer,
        detail: detail,
        setup: (http) => http.on(
          cancel,
          200,
          EventFixtures.eventDetail({
            'starts_at': _future,
            'can_cancel': true,
            'cancelled_at': '2099-10-01T10:00:00+02:00',
          }),
        ),
      );

      await tester.tap(find.byKey(const ValueKey('event-trainer-cancel')));
      await tester.pumpAndSettle();
      expect(find.text('Afgelasten?'), findsOneWidget);

      // Terug: er gebeurt niets.
      await tester.tap(find.byKey(const ValueKey('schedule-confirm-back')));
      await tester.pumpAndSettle();
      expect(http.requestsTo(cancel), isEmpty);

      final detailsBefore = http.requestsTo(_detail).length;
      // Het detail komt na het afgelasten terug als afgelast.
      http.on(
        _detail,
        200,
        EventFixtures.eventDetail({
          'starts_at': _future,
          'is_trainer': true,
          'can_cancel': true,
          'cancelled_at': '2099-10-01T10:00:00+02:00',
        }),
      );
      await tester.tap(find.byKey(const ValueKey('event-trainer-cancel')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('schedule-confirm-ok')));
      await tester.pumpAndSettle();

      expect(http.requestsTo(cancel), hasLength(1));
      expect(http.requestsTo(_detail).length, greaterThan(detailsBefore));
      expect(
        find.byKey(const ValueKey('event-cancelled-notice')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('event-trainer-uncancel')),
        findsOneWidget,
      );
    });

    testWidgets('gaat toch door: DELETE …/cancel', (tester) async {
      const uncancel = 'DELETE /teams/3/schedule/412/cancel';
      final (_, http) = await _open(
        tester,
        membership: trainer,
        detail: EventFixtures.eventDetail({
          'starts_at': _future,
          'is_trainer': true,
          'can_cancel': true,
          'cancelled_at': '2099-10-01T10:00:00+02:00',
        }),
        setup: (http) => http.on(
          uncancel,
          200,
          EventFixtures.eventDetail({'starts_at': _future}),
        ),
      );

      await tester.tap(find.byKey(const ValueKey('event-trainer-uncancel')));
      await tester.pumpAndSettle();
      expect(find.text('Afgelasting intrekken?'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('schedule-confirm-ok')));
      await tester.pumpAndSettle();

      expect(http.requestsTo(uncancel), hasLength(1));
    });

    testWidgets('verwijderen: bevestigen, DELETE en terug naar de agenda', (
      tester,
    ) async {
      const delete = 'DELETE /teams/3/schedule/412';
      final (container, http) = await _open(
        tester,
        membership: trainer,
        detail: detail,
        setup: (http) => http.on(delete, 204),
      );
      final agendaBefore = http.requestsTo(_agenda).length;

      await tester.tap(find.byKey(const ValueKey('event-trainer-delete')));
      await tester.pumpAndSettle();
      expect(find.text('Event verwijderen?'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('schedule-confirm-ok')));
      await tester.pumpAndSettle();

      expect(http.requestsTo(delete), hasLength(1));
      expect(container.read(routerProvider).state.uri.path, AppRoutes.agenda);
      expect(http.requestsTo(_agenda).length, greaterThan(agendaBefore));
      expect(find.text('Event verwijderd'), findsOneWidget);
    });

    testWidgets('verwijderen mislukt: toast, blijft staan', (tester) async {
      final (container, _) = await _open(
        tester,
        membership: trainer,
        detail: detail,
        setup: (http) => http.on('DELETE /teams/3/schedule/412', 403, {
          'message': 'Dit kan niet in het demoteam.',
        }),
      );

      await tester.tap(find.byKey(const ValueKey('event-trainer-delete')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('schedule-confirm-ok')));
      await tester.pumpAndSettle();

      expect(find.text('Verwijderen lukte niet'), findsOneWidget);
      expect(find.text('Dit kan niet in het demoteam.'), findsOneWidget);
      expect(container.read(routerProvider).state.uri.path, '/events/412');
    });

    testWidgets('bewerken opent het formulier met dit event', (tester) async {
      final (container, _) = await _open(
        tester,
        membership: trainer,
        detail: detail,
        setup: (http) => http.on('GET /teams/3/schedule/options', 200, {
          'data': {'team_name': 'Vogels 3'},
        }),
      );

      await tester.tap(find.byKey(const ValueKey('event-trainer-edit')));
      await pumpUntilFound(tester, find.byKey(const ValueKey('schedule-form')));

      final uri = container.read(routerProvider).state.uri;
      expect(uri.path, AppRoutes.schedule);
      expect(uri.queryParameters['event'], '412');
      expect(currentTitle(tester), 'Event bewerken');
      expect(find.text('Sportpark Arnhemia'), findsOneWidget);
    });
  });
}
