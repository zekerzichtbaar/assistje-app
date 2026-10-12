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
import 'duties_fixtures.dart';

const _index = 'GET /teams/3/duties';
const _store = 'POST /teams/3/duties/assignments';

final Map<String, dynamic> _trainer = ApiFixtures.membership(role: 'trainer');

/// Antwoordt per `?type=`: `wassen` → groepen, anders het individuele type.
FakeResponse _byType(RecordedRequest r) => FakeResponse(
  200,
  r.options.uri.queryParameters['type'] == 'wassen'
      ? DutiesFixtures.groups()
      : DutiesFixtures.individual(),
);

Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [_trainer],
    setup: (http) {
      http.routes[_index] = _byType;
      setup?.call(http);
    },
  );
  unawaited(container.read(routerProvider).push(AppRoutes.duties));
  await pumpUntilFound(tester, find.byKey(const ValueKey('duties-screen')));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Finder _inScreen(Finder finder) => find.descendant(
  of: find.byKey(const ValueKey('duties-screen')),
  matching: finder,
);

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('trainer: individueel wedstrijdtype met beurten en tellers', (
    tester,
  ) async {
    await _open(tester);

    expect(currentTitle(tester), 'Diensten');
    expect(find.byKey(const ValueKey('duties-types')), findsOneWidget);
    expect(_inScreen(find.text('Wassen')), findsOneWidget);
    expect(find.text('GEPLANDE BEURTEN  1'), findsOneWidget);
    expect(_inScreen(find.text('Vogels 3 – Kraaien 1')), findsOneWidget);
    expect(find.textContaining('Sam de Vries'), findsWidgets);
    expect(find.byKey(const ValueKey('duties-auto-assign')), findsOneWidget);
    await tester.ensureVisible(
      find.byKey(const ValueKey('duties-season-counts')),
    );
    expect(find.text('BEURTEN DIT SEIZOEN'), findsOneWidget);
    expect(find.text('Kim Jansen'), findsOneWidget);
    // Individueel: geen groepenkaart.
    expect(find.byKey(const ValueKey('duties-groups')), findsNothing);
  });

  testWidgets('nieuwe beurt: verplicht veld, 422 inline, dan opgeslagen', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(_store, 422, {
        'message': 'Kies wie de dienst doet.',
        'errors': {
          'member_key': ['Deze persoon zit niet in de pool.'],
          'player_id': ['Deze persoon zit niet in de pool.'],
        },
      }),
    );

    await _tap(tester, find.byKey(const ValueKey('duties-plan')));
    expect(find.text('Beurt toewijzen'), findsOneWidget);

    // Zonder wedstrijd: inline melding, geen verzoek.
    await _tap(tester, find.byKey(const ValueKey('duty-plan-form-save')));
    expect(find.text('Kies een wedstrijd.'), findsOneWidget);
    expect(http.requestsTo(_store), isEmpty);

    await _tap(
      tester,
      find.byKey(const ValueKey('duty-plan-form-row-0-match')),
    );
    await _tap(tester, find.textContaining('Merels 2').last);
    await _tap(tester, find.byKey(const ValueKey('duty-plan-form-save')));

    // Kim (minste beurten) staat voorgesteld.
    expect(http.requestsTo(_store).single.body, {
      'duty_type_id': 3,
      'mode': 'individual',
      'member_key': 'p_18',
      'dates': [
        {'event_id': 815},
      ],
    });
    expect(find.text('Deze persoon zit niet in de pool.'), findsOneWidget);

    http.on(_store, 201, DutiesFixtures.stored());
    final before = http.requestsTo(_index).length;
    await _tap(tester, find.byKey(const ValueKey('duty-plan-form-save')));
    expect(find.byKey(const ValueKey('duty-plan-form-save')), findsNothing);
    expect(find.text('Ingepland'), findsOneWidget);
    expect(http.requestsTo(_index).length, before + 1);
  });

  testWidgets('afvinken, wijzigen en verwijderen van een beurt', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on(
          'POST /teams/3/duties/assignments/120/done',
          200,
          DutiesFixtures.savedAssignment(),
        )
        ..on(
          'PATCH /teams/3/duties/assignments/120',
          200,
          DutiesFixtures.savedAssignment(),
        )
        ..on('DELETE /teams/3/duties/assignments/120', 204),
    );

    await _tap(
      tester,
      find.byKey(const ValueKey('duties-assignment-120-done')),
    );
    expect(
      http.requestsTo('POST /teams/3/duties/assignments/120/done'),
      hasLength(1),
    );

    await _tap(
      tester,
      find.byKey(const ValueKey('duties-assignment-120-edit')),
    );
    expect(find.text('Beurt wijzigen'), findsOneWidget);
    await tester.enterText(
      find.byKey(const ValueKey('duty-edit-form-notes')),
      'Vlag meenemen',
    );
    await _tap(tester, find.byKey(const ValueKey('duty-edit-form-save')));
    expect(
      http.requestsTo('PATCH /teams/3/duties/assignments/120').single.body,
      {
        'member_key': 'p_17',
        'event_id': 812,
        'starts_at': null,
        'ends_at': null,
        'notes': 'Vlag meenemen',
      },
    );

    await _tap(
      tester,
      find.byKey(const ValueKey('duties-assignment-120-delete')),
    );
    await _tap(tester, find.byKey(const ValueKey('duties-confirm-ok')));
    expect(
      http.requestsTo('DELETE /teams/3/duties/assignments/120'),
      hasLength(1),
    );
  });

  testWidgets('groepsdienst: wisselen, volgorde en groep aanmaken', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on('POST /teams/3/duties/groups/reorder', 204)
        ..on('POST /teams/3/duties/groups', 201, DutiesFixtures.savedGroup()),
    );

    await _tap(tester, _inScreen(find.text('Wassen')));
    expect(http.requestsTo(_index).last.options.uri.queryParameters, {
      'type': 'wassen',
    });
    expect(find.byKey(const ValueKey('duties-groups')), findsOneWidget);
    expect(find.text('GROEPEN  2'), findsOneWidget);
    expect(find.text('Coach Ronald, Sam de Vries'), findsOneWidget);
    expect(find.text('Geen leden'), findsOneWidget);
    expect(find.text('GEPLANDE DATUMS  1'), findsOneWidget);
    // Geen wedstrijddienst: niet automatisch verdelen.
    expect(find.byKey(const ValueKey('duties-auto-assign')), findsNothing);

    await _tap(tester, find.byKey(const ValueKey('duties-group-8-up')));
    expect(http.requestsTo('POST /teams/3/duties/groups/reorder').single.body, {
      'ids': [8, 7],
    });

    await _tap(tester, find.byKey(const ValueKey('duties-group-add')));
    expect(find.text('Nieuwe groep'), findsWidgets);
    await _tap(tester, find.byKey(const ValueKey('duty-group-form-save')));
    expect(find.text('Geef de groep een naam.'), findsOneWidget);
    expect(http.requestsTo('POST /teams/3/duties/groups'), isEmpty);

    await tester.enterText(
      find.byKey(const ValueKey('duty-group-form-name')),
      'Groep C',
    );
    await _tap(
      tester,
      find.byKey(const ValueKey('duty-group-form-member-u_4')),
    );
    await _tap(tester, find.byKey(const ValueKey('duty-group-form-save')));
    expect(http.requestsTo('POST /teams/3/duties/groups').single.body, {
      'duty_type_id': 1,
      'name': 'Groep C',
      'member_keys': ['u_4'],
    });
    expect(find.byKey(const ValueKey('duty-group-form-save')), findsNothing);
  });

  testWidgets('groep verwijderen vanuit het formulier', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on('DELETE /teams/3/duties/groups/7', 204),
    );
    await _tap(tester, _inScreen(find.text('Wassen')));

    await _tap(tester, find.byKey(const ValueKey('duties-group-7')));
    expect(find.text('Groep bewerken'), findsOneWidget);
    await _tap(tester, find.byKey(const ValueKey('duty-group-form-delete')));
    expect(find.text('Verwijder groep Groep A?'), findsOneWidget);
    await _tap(tester, find.byKey(const ValueKey('duties-confirm-ok')));
    expect(http.requestsTo('DELETE /teams/3/duties/groups/7'), hasLength(1));
    expect(find.text('Verwijderd'), findsOneWidget);
  });

  testWidgets('een fout bij afvinken geeft een toast', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        'POST /teams/3/duties/assignments/120/done',
        403,
        {'message': 'Geen toegang.'},
      ),
    );
    await _tap(
      tester,
      find.byKey(const ValueKey('duties-assignment-120-done')),
    );
    expect(find.text('Dat lukte niet'), findsOneWidget);
    expect(find.text('Geen toegang.'), findsOneWidget);
    expect(http.requestsTo(_index).length, greaterThanOrEqualTo(1));
  });

  testWidgets('403: alleen voor de trainer', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_index, 403, {'message': 'Geen toegang.'}),
    );
    expect(currentTitle(tester), 'Diensten');
    expect(find.byKey(const ValueKey('duties-forbidden')), findsOneWidget);
    expect(find.text('Alleen voor de trainer'), findsOneWidget);
  });

  testWidgets('404: nog geen diensten, opnieuw proberen', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(_index, 404, {'message': 'Not found.'}),
    );
    expect(find.byKey(const ValueKey('duties-not-found')), findsOneWidget);

    http.routes[_index] = _byType;
    await _tap(tester, find.byKey(const ValueKey('duties-retry')));
    expect(_inScreen(find.text('Vogels 3 – Kraaien 1')), findsOneWidget);
  });
}
