import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import 'seasons_fixtures.dart';

const _index = 'GET /teams/3/seasons';

/// Start ingelogd als trainer van team 3 en opent `/seasons`.
Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  Map<String, dynamic>? membership,
  Map<String, dynamic>? data,
  void Function(FakeHttpAdapter http)? setup,
  String waitFor = 'seasons-current-card',
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [membership ?? SeasonsFixtures.trainerMembership()],
    setup: (http) {
      http.on(_index, 200, SeasonsFixtures.response(data));
      setup?.call(http);
    },
  );
  container.read(routerProvider).go(AppRoutes.seasons);
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

/// Laat een toast uitlopen (4 s) zodat er geen timer blijft hangen.
Future<void> _settleToast(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('laadt: seizoen, modus, verdeling, periodes en afsluiten', (
    tester,
  ) async {
    await _open(tester);

    expect(currentTitle(tester), 'Seizoenen');
    expect(find.text('26/27'), findsOneWidget);
    expect(
      tester.widget<Text>(_key('seasons-range')).data,
      '1 jul. – 30 jun. · 22 wedstrijden',
    );
    expect(_key('seasons-active-pill'), findsOneWidget);
    expect(_key('seasons-expired'), findsNothing);
    expect(_key('seasons-mode-matches'), findsOneWidget);
    expect(_key('seasons-split-card'), findsOneWidget);
    expect(_key('seasons-period-41'), findsOneWidget);
    expect(_key('seasons-period-closed-41'), findsOneWidget);
    expect(_key('seasons-period-42'), findsOneWidget);
    expect(_key('seasons-period-closed-42'), findsNothing);
    // Op wedstrijden voeg je niet los toe: alleen het voorstel.
    expect(_key('seasons-period-add'), findsNothing);
    expect(_key('seasons-close'), findsOneWidget);
    expect(_key('seasons-reopen'), findsOneWidget);
    expect(_key('seasons-read-only'), findsNothing);
  });

  testWidgets('verlopen seizoen toont de waarschuwing', (tester) async {
    await _open(
      tester,
      data: SeasonsFixtures.data(
        season: SeasonsFixtures.season(endsOn: '2026-06-30', expired: true),
      ),
    );
    expect(_key('seasons-expired'), findsOneWidget);
    expect(_key('seasons-expired-pill'), findsOneWidget);
  });

  testWidgets('seizoen afsluiten vraagt eerst bevestiging', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        'POST /teams/3/seasons/close',
        200,
        SeasonsFixtures.response(
          SeasonsFixtures.data(
            season: SeasonsFixtures.season(
              label: '27/28',
              startsOn: '2027-07-01',
              endsOn: '2028-06-30',
              matchCount: 0,
            ),
            closedSeason: {
              'label': '26/27',
              'closed_at': '2027-07-02T10:00:00+02:00',
            },
            periods: const [],
          ),
        ),
      ),
    );

    // Annuleren: niets verstuurd.
    await _tap(tester, _key('seasons-close'));
    expect(
      find.text(
        'Huidig seizoen afsluiten? Stats en boetes komen in archief, '
        'alles start weer op 0.',
      ),
      findsOneWidget,
    );
    await tester.tap(_key('seasons-confirm-cancel'));
    await tester.pumpAndSettle();
    expect(http.requestsTo('POST /teams/3/seasons/close'), isEmpty);

    // Bevestigen: afgesloten, de opvolger staat in beeld.
    await _tap(tester, _key('seasons-close'));
    await tester.tap(_key('seasons-confirm-ok'));
    await tester.pumpAndSettle();

    expect(http.requestsTo('POST /teams/3/seasons/close'), hasLength(1));
    expect(find.text('Seizoen afgesloten'), findsOneWidget);
    expect(find.text('Seizoen 27/28 is gestart.'), findsOneWidget);
    expect(find.text('Heropen 26/27'), findsOneWidget);
    await _settleToast(tester);
  });

  testWidgets('periode toevoegen: 422 blijft in de sheet, daarna gelukt', (
    tester,
  ) async {
    var fail = true;
    final (_, http) = await _open(
      tester,
      data: SeasonsFixtures.data(
        mode: 'dates',
        periods: [
          SeasonsFixtures.period(
            id: 41,
            name: 'Periode 1',
            startsOn: '2026-07-01',
            endsOn: '2026-10-26',
            targetMatches: null,
          ),
        ],
      ),
      setup: (http) => http.routes['POST /teams/3/periods'] = (_) => fail
          ? const FakeResponse(422, {
              'message': 'De naam mag niet langer zijn dan 40 tekens.',
              'errors': {
                'name': ['De naam mag niet langer zijn dan 40 tekens.'],
              },
            })
          : FakeResponse(
              201,
              SeasonsFixtures.response(
                SeasonsFixtures.data(
                  mode: 'dates',
                  periods: [
                    SeasonsFixtures.period(
                      id: 41,
                      name: 'Periode 1',
                      startsOn: '2026-07-01',
                      endsOn: '2026-10-26',
                      targetMatches: null,
                    ),
                    SeasonsFixtures.period(
                      id: 43,
                      name: 'Najaar',
                      endsOn: '2027-06-30',
                      targetMatches: null,
                      played: 0,
                    ),
                  ],
                ),
                {'period_id': 43},
              ),
            ),
    );

    await _tap(tester, _key('seasons-period-add'));
    expect(find.text('Periode toevoegen'), findsWidgets);

    // Leeg opslaan: eigen controle, niets verstuurd.
    await tester.tap(_key('period-save'));
    await tester.pumpAndSettle();
    expect(find.text('Vul een naam in.'), findsOneWidget);
    expect(http.requestsTo('POST /teams/3/periods'), isEmpty);

    await tester.enterText(_key('period-name'), 'Najaar');
    await tester.tap(_key('period-save'));
    await tester.pumpAndSettle();

    // De datums stonden al goed: de dag na de vorige periode t/m het
    // seizoenseinde.
    expect(http.requestsTo('POST /teams/3/periods').single.body, {
      'name': 'Najaar',
      'starts_on': '2026-10-27',
      'ends_on': '2027-06-30',
    });
    expect(
      find.text('De naam mag niet langer zijn dan 40 tekens.'),
      findsOneWidget,
    );
    expect(_key('period-save'), findsOneWidget);

    fail = false;
    await tester.tap(_key('period-save'));
    await tester.pumpAndSettle();

    expect(_key('period-save'), findsNothing);
    expect(_key('seasons-period-43'), findsOneWidget);
    expect(find.text('Periode toegevoegd'), findsOneWidget);
    await _settleToast(tester);
  });

  testWidgets('periode verwijderen via het menu, na bevestiging', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        'DELETE /teams/3/periods/42',
        200,
        SeasonsFixtures.response(
          SeasonsFixtures.data(periods: [SeasonsFixtures.periods().first]),
        ),
      ),
    );

    await _tap(tester, _key('seasons-period-menu-42'));
    await tester.tap(_key('seasons-period-delete-42'));
    await tester.pumpAndSettle();
    expect(find.text('Periode 2 verwijderen?'), findsOneWidget);
    await tester.tap(_key('seasons-confirm-ok'));
    await tester.pumpAndSettle();

    expect(http.requestsTo('DELETE /teams/3/periods/42'), hasLength(1));
    expect(_key('seasons-period-42'), findsNothing);
    expect(_key('seasons-period-41'), findsOneWidget);
    expect(find.text('Periode verwijderd'), findsOneWidget);
    await _settleToast(tester);
  });

  testWidgets('afgesloten periode heeft alleen "Heropenen"', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        'POST /teams/3/periods/41/reopen',
        200,
        SeasonsFixtures.response(),
      ),
    );

    await _tap(tester, _key('seasons-period-menu-41'));
    expect(_key('seasons-period-delete-41'), findsNothing);
    await tester.tap(_key('seasons-period-reopen-41'));
    await tester.pumpAndSettle();
    await tester.tap(_key('seasons-confirm-ok'));
    await tester.pumpAndSettle();

    expect(http.requestsTo('POST /teams/3/periods/41/reopen'), hasLength(1));
    expect(find.text('Periode 1 heropend'), findsOneWidget);
    await _settleToast(tester);
  });

  testWidgets('modus wijzigen stuurt badge_period_mode', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        'PATCH /teams/3/periods/mode',
        200,
        SeasonsFixtures.response(SeasonsFixtures.data(mode: 'dates')),
      ),
    );

    await _tap(tester, _key('seasons-mode-dates'));

    expect(http.requestsTo('PATCH /teams/3/periods/mode').single.body, {
      'badge_period_mode': 'dates',
    });
    expect(_key('seasons-split-card'), findsNothing);
    expect(_key('seasons-period-add'), findsOneWidget);
  });

  testWidgets('demo-team: alleen-lezen, geen knoppen', (tester) async {
    await _open(
      tester,
      membership: SeasonsFixtures.trainerMembership(demo: true),
    );

    expect(_key('seasons-read-only'), findsOneWidget);
    expect(
      find.text(
        'Dit is een demoteam: je kunt rondkijken, maar niets wijzigen.',
      ),
      findsOneWidget,
    );
    expect(_key('seasons-edit'), findsNothing);
    expect(_key('seasons-close'), findsNothing);
    expect(_key('seasons-reopen'), findsNothing);
    expect(_key('seasons-generate'), findsNothing);
    expect(_key('seasons-period-menu-42'), findsNothing);
  });

  testWidgets('403 bij laden: leeg scherm voor niet-trainers', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_index, 403, {'message': 'Geen toegang.'}),
      waitFor: 'seasons-forbidden',
    );

    expect(find.text('Alleen voor de trainer'), findsOneWidget);
    expect(_key('seasons-current-card'), findsNothing);
  });

  testWidgets('403 op een schrijfactie: valt terug op alleen-lezen', (
    tester,
  ) async {
    await _open(
      tester,
      setup: (http) =>
          http.on('PATCH /teams/3/periods/mode', 403, {'message': 'Nee.'}),
    );

    await _tap(tester, _key('seasons-mode-off'));

    expect(_key('seasons-read-only'), findsOneWidget);
    expect(_key('seasons-close'), findsNothing);
    await _settleToast(tester);
  });
}
