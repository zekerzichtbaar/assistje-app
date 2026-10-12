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
import 'attendance_fixtures.dart';

const _base = '/teams/3/events/412';
const _index = 'GET $_base/attendance';
const _options = 'GET $_base/guests/options';
const _guests = 'POST $_base/guests';

/// Trainer met posities in het sportprofiel (nooit een sport hardcoden: de
/// namen komen uit het profiel).
Map<String, dynamic> _trainer() => {
  ...ApiFixtures.membership(role: 'trainer'),
  'sport': {
    'key': 'football',
    'positions': {'K': 'Keeper', 'A': 'Aanvaller', 'MF': 'Middenvelder'},
  },
};

Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [_trainer()],
    setup: setup,
  );
  unawaited(
    container.read(routerProvider).push('${AppRoutes.event(412)}/attendance'),
  );
  await pumpUntilFound(tester, find.byKey(const ValueKey('attendance-screen')));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('toont opkomst, spelers per antwoord, staf en gasten', (
    tester,
  ) async {
    await _open(
      tester,
      setup: (http) => http.on(_index, 200, AttendanceFixtures.attendance()),
    );

    expect(currentTitle(tester), 'Aanwezigheid');
    expect(
      find.byKey(const ValueKey('attendance-event-title')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('event-responses')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('attendance-group-present')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('attendance-group-absent')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('attendance-group-pending')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('attendance-group-nonplay')),
      findsNothing,
    );
    expect(find.text('Kees Jansen'), findsOneWidget);
    // Positienaam uit het sportprofiel.
    expect(find.text('Keeper'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('attendance-vacation-player-42')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('attendance-standing-player-43')),
      findsOneWidget,
    );
    await tester.ensureVisible(
      find.byKey(const ValueKey('attendance-group-guests')),
    );
    expect(
      find.byKey(const ValueKey('attendance-group-staff')),
      findsOneWidget,
    );
    expect(find.text('Trainer Tom'), findsOneWidget);
    expect(find.text('Gerrit Gast'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('attendance-remove-player-88')),
      findsOneWidget,
    );
    // Alleen gasten hebben een prullenbak.
    expect(
      find.byKey(const ValueKey('attendance-remove-player-37')),
      findsNothing,
    );
  });

  testWidgets('skeleton tijdens laden', (tester) async {
    final (container, _) = await pumpSignedIn(
      tester,
      teams: [_trainer()],
      setup: (http) => http.on(_index, 200, AttendanceFixtures.attendance()),
    );
    unawaited(
      container.read(routerProvider).push('${AppRoutes.event(412)}/attendance'),
    );
    await tester.pump();
    await tester.pump();
    expect(find.byKey(const ValueKey('attendance-loading')), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('attendance-loading')), findsNothing);
    expect(find.text('Kees Jansen'), findsOneWidget);
  });

  testWidgets('403: alleen voor de trainer', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_index, 403, {'message': 'Nee.'}),
    );
    expect(find.byKey(const ValueKey('attendance-forbidden')), findsOneWidget);
    expect(currentTitle(tester), 'Aanwezigheid');
  });

  testWidgets('404: event niet gevonden', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_index, 404, {'message': 'Weg.'}),
    );
    expect(find.byKey(const ValueKey('attendance-not-found')), findsOneWidget);
  });

  testWidgets('500: fout met opnieuw proberen', (tester) async {
    var calls = 0;
    await _open(
      tester,
      setup: (http) => http.routes[_index] = (_) {
        calls++;
        return calls == 1
            ? const FakeResponse(500, {'message': 'Kapot.'})
            : FakeResponse(200, AttendanceFixtures.attendance());
      },
    );
    expect(find.byKey(const ValueKey('attendance-error')), findsOneWidget);

    await _tap(tester, find.byKey(const ValueKey('attendance-retry')));
    expect(find.text('Kees Jansen'), findsOneWidget);
  });

  testWidgets('namens een speler afwezig zetten', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on(_index, 200, AttendanceFixtures.attendance())
        ..on(
          'PATCH $_base/attendance/37',
          200,
          AttendanceFixtures.saved(status: 'absent'),
        ),
    );

    await _tap(tester, find.byKey(const ValueKey('attendance-row-player-37')));
    expect(find.text('Aanwezigheid van Kees Jansen'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('attendance-set-nonplay')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('attendance-set-pending')),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const ValueKey('attendance-set-absent')));
    await tester.pumpAndSettle();

    expect(http.requestsTo('PATCH $_base/attendance/37').single.body, {
      'status': 'absent',
    });
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('attendance-group-absent')),
        matching: find.text('Kees Jansen'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('namens staf: mislukt → toast en terug', (tester) async {
    await _open(
      tester,
      setup: (http) => http
        ..on(_index, 200, AttendanceFixtures.attendance())
        ..on('PATCH $_base/attendance/staff/51', 403, {
          'message': 'De aanvang is geweest.',
        }),
    );

    await _tap(tester, find.byKey(const ValueKey('attendance-row-staff-51')));
    await tester.tap(find.byKey(const ValueKey('attendance-set-present')));
    await tester.pumpAndSettle();

    expect(find.text('Opslaan lukte niet'), findsOneWidget);
    expect(find.text('De aanvang is geweest.'), findsOneWidget);
    final pill = tester.widget<Text>(
      find.descendant(
        of: find.byKey(const ValueKey('attendance-status-staff-51')),
        matching: find.byType(Text),
      ),
    );
    expect(pill.data, 'Open');
  });

  testWidgets('afgelast: melding, niets te tikken, geen gast toevoegen', (
    tester,
  ) async {
    await _open(
      tester,
      setup: (http) => http.on(
        _index,
        200,
        AttendanceFixtures.attendance(
          canEdit: false,
          cancelledAt: '2026-10-12T10:00:00+02:00',
        ),
      ),
    );

    expect(find.byKey(const ValueKey('attendance-locked')), findsOneWidget);
    expect(find.text('Afgelast. Aanwezigheid staat vast.'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('attendance-row-player-37')));
    await tester.pumpAndSettle();
    expect(find.text('Aanwezigheid van Kees Jansen'), findsNothing);
    expect(find.byKey(const ValueKey('attendance-add-guest')), findsNothing);
    expect(
      find.byKey(const ValueKey('attendance-remove-player-88')),
      findsNothing,
    );
  });

  testWidgets('bestaande gast toevoegen', (tester) async {
    var added = false;
    final (_, http) = await _open(
      tester,
      setup: (http) {
        http.routes[_index] = (_) => FakeResponse(
          200,
          AttendanceFixtures.attendance(
            rows: [
              AttendanceFixtures.row(playerId: 37, name: 'Kees Jansen'),
              if (added)
                AttendanceFixtures.row(
                  playerId: 89,
                  name: 'Gijs Gast',
                  isGuest: true,
                  status: 'present',
                ),
            ],
          ),
        );
        http.routes[_guests] = (_) {
          added = true;
          return FakeResponse(201, AttendanceFixtures.guest());
        };
        http.on(_options, 200, AttendanceFixtures.options());
      },
    );

    expect(find.byKey(const ValueKey('attendance-no-guests')), findsOneWidget);
    await _tap(tester, find.byKey(const ValueKey('attendance-add-guest')));
    expect(find.byKey(const ValueKey('guest-options')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('guest-option-89')));
    await tester.pumpAndSettle();

    expect(http.requestsTo(_guests).single.body, {'existing_player_id': 89});
    expect(find.text('Gast toegevoegd'), findsOneWidget);
    expect(find.byKey(const ValueKey('guest-options')), findsNothing);
    expect(find.text('Gijs Gast'), findsOneWidget);
  });

  testWidgets('nieuwe gast: 422 inline, daarna toegevoegd', (tester) async {
    var calls = 0;
    final (_, http) = await _open(
      tester,
      setup: (http) {
        http
          ..on(_index, 200, AttendanceFixtures.attendance())
          ..on(_options, 200, AttendanceFixtures.options(list: []));
        http.routes[_guests] = (_) {
          calls++;
          return calls == 1
              ? const FakeResponse(422, {
                  'message': 'Ongeldig rugnummer.',
                  'errors': {
                    'shirt_number': ['Kies een rugnummer van 1 tot 99.'],
                  },
                })
              : FakeResponse(201, AttendanceFixtures.guest(name: 'Nina'));
        };
      },
    );

    await _tap(tester, find.byKey(const ValueKey('attendance-add-guest')));
    expect(find.byKey(const ValueKey('guest-options-empty')), findsOneWidget);
    await tester.enterText(find.byKey(const ValueKey('guest-name')), 'Nina');
    await tester.enterText(find.byKey(const ValueKey('guest-shirt')), '0');
    await tester.pumpAndSettle();
    await _tap(tester, find.byKey(const ValueKey('guest-submit')));

    expect(find.text('Kies een rugnummer van 1 tot 99.'), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('guest-shirt')), '44');
    await _tap(tester, find.byKey(const ValueKey('guest-position')));
    await tester.tap(find.text('MF · Middenvelder').last);
    await tester.pumpAndSettle();
    await _tap(tester, find.byKey(const ValueKey('guest-submit')));

    expect(http.requestsTo(_guests).last.body, {
      'name': 'Nina',
      'shirt_number': 44,
      'position': 'MF',
    });
    expect(find.text('Gast toegevoegd'), findsOneWidget);
  });

  testWidgets('gast weghalen na bevestiging', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on(_index, 200, AttendanceFixtures.attendance())
        ..on('DELETE $_base/guests/88', 200, AttendanceFixtures.options()),
    );

    await _tap(
      tester,
      find.byKey(const ValueKey('attendance-remove-player-88')),
    );
    expect(find.text('Gerrit Gast verwijderen uit dit event?'), findsOneWidget);
    await _tap(tester, find.byKey(const ValueKey('attendance-confirm-cancel')));
    expect(http.requestsTo('DELETE $_base/guests/88'), isEmpty);

    await _tap(
      tester,
      find.byKey(const ValueKey('attendance-remove-player-88')),
    );
    await _tap(tester, find.byKey(const ValueKey('attendance-confirm-ok')));

    expect(http.requestsTo('DELETE $_base/guests/88'), hasLength(1));
    expect(find.text('Gast verwijderd'), findsOneWidget);
  });
}
