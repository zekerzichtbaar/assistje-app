import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import 'pm_fixtures.dart';

const _index = 'GET /teams/3/players';

/// Start ingelogd als trainer van team 3 en opent `/players`.
Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  Map<String, dynamic>? membership,
  void Function(FakeHttpAdapter http)? setup,
  String waitFor = 'pm-teamlink-card',
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [membership ?? PmFixtures.trainerMembership()],
    setup: (http) {
      http.on(_index, 200, PmFixtures.overview());
      setup?.call(http);
    },
  );
  container.read(routerProvider).go(AppRoutes.players);
  await pumpUntilFound(tester, find.byKey(ValueKey(waitFor)));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Finder _key(String key) => find.byKey(ValueKey(key));

Future<void> _tap(WidgetTester tester, String key) async {
  await tester.ensureVisible(_key(key));
  await tester.pumpAndSettle();
  await tester.tap(_key(key));
  await tester.pumpAndSettle();
}

/// Laat een toast uitlopen (4 s) zodat er geen timer blijft hangen.
Future<void> _settleToast(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('overzicht: trainers, linies, Overig, Gasten, toeschouwers', (
    tester,
  ) async {
    await _open(tester);

    expect(currentTitle(tester), 'Spelers');
    expect(_key('pm-add'), findsOneWidget);
    expect(
      find.descendant(
        of: _key('pm-section-trainers'),
        matching: _key('pm-trainer-60'),
      ),
      findsOneWidget,
    );
    // Jezelf kun je niet weghalen, een ander wel.
    expect(_key('pm-trainer-remove-3'), findsNothing);
    expect(_key('pm-trainer-remove-60'), findsOneWidget);
    expect(
      find.descendant(
        of: _key('pm-section-group-mid'),
        matching: _key('pm-player-12'),
      ),
      findsOneWidget,
    );
    expect(find.text('MIDDENVELDERS'), findsOneWidget);
    expect(_key('pm-captain-12'), findsOneWidget);
    expect(
      find.descendant(
        of: _key('pm-section-other'),
        matching: _key('pm-player-13'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: _key('pm-section-guests'),
        matching: _key('pm-player-31'),
      ),
      findsOneWidget,
    );
    expect(_key('pm-spectator-51'), findsOneWidget);
    expect(_key('pm-spectator-resend-51'), findsOneWidget);
    expect(_key('pm-read-only'), findsNothing);
  });

  testWidgets('speler toevoegen: validatie, 422 en gelukt', (tester) async {
    final (_, http) = await _open(tester);
    http.on('POST /teams/3/players', 422, {
      'message': 'Ongeldig.',
      'errors': {
        'shirt_number': ['Rugnummer 7 is al bezet.'],
      },
    });

    await _tap(tester, 'pm-add');
    expect(
      find.descendant(of: _key('pm-add-tabs'), matching: find.text('CSV')),
      findsOneWidget,
    );

    // Lege naam: niets verstuurd.
    await _tap(tester, 'pm-add-submit');
    expect(find.text('Vul een naam in.'), findsOneWidget);
    expect(http.requestsTo('POST /teams/3/players'), isEmpty);

    await tester.enterText(_key('pm-add-name'), 'Nina Nieuw');
    await tester.enterText(_key('pm-add-shirt'), '7');
    await _tap(tester, 'pm-add-submit');
    expect(find.text('Rugnummer 7 is al bezet.'), findsOneWidget);

    http.on(
      'POST /teams/3/players',
      201,
      PmFixtures.data({...PmFixtures.kees(), 'id': 14, 'name': 'Nina Nieuw'}),
    );
    await _tap(tester, 'pm-add-submit');

    expect(http.requestsTo('POST /teams/3/players').last.body, {
      'name': 'Nina Nieuw',
      'shirt_number': 7,
      'is_guest': false,
      'send_invite': false,
    });
    expect(_key('pm-add-submit'), findsNothing);
    expect(find.text('Speler toegevoegd'), findsOneWidget);
    await _settleToast(tester);
  });

  testWidgets('trainer toevoegen vraagt een e-mailadres', (tester) async {
    final (_, http) = await _open(tester);
    http.on('POST /teams/3/trainers', 201, PmFixtures.data(PmFixtures.anja()));

    await _tap(tester, 'pm-add');
    await tester.tap(find.text('Trainer').last);
    await tester.pumpAndSettle();
    await tester.enterText(_key('pm-add-name'), 'Anja');
    await _tap(tester, 'pm-add-submit');
    expect(find.text('Vul een e-mailadres in.'), findsOneWidget);

    await tester.enterText(_key('pm-add-email'), 'anja@example.com');
    await _tap(tester, 'pm-add-submit');

    expect(http.requestsTo('POST /teams/3/trainers').single.body, {
      'name': 'Anja',
      'email': 'anja@example.com',
    });
    await _settleToast(tester);
  });

  testWidgets('beheer: aanvoerder en bevoegdheid omzetten', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on(
          'PATCH /teams/3/players/12/captain',
          200,
          PmFixtures.data(PmFixtures.linda(isCaptain: false)),
        )
        ..on(
          'PATCH /teams/3/players/12/abilities',
          200,
          PmFixtures.data(
            PmFixtures.linda(isCaptain: false, abilities: ['lineup', 'fines']),
          ),
        ),
    );

    await _tap(tester, 'pm-player-12');
    expect(_key('pm-manage-12'), findsOneWidget);
    // Account geaccepteerd: geen uitnodiging.
    expect(_key('pm-invite-form'), findsNothing);
    expect(_key('pm-invite-pending'), findsNothing);

    await tester.tap(
      find.descendant(
        of: _key('pm-toggle-captain'),
        matching: find.byType(Switch),
      ),
    );
    await tester.pumpAndSettle();
    expect(http.requestsTo('PATCH /teams/3/players/12/captain').single.body, {
      'captain': false,
    });

    final fines = find.descendant(
      of: _key('pm-toggle-ability-fines'),
      matching: find.byType(Switch),
    );
    await tester.ensureVisible(fines);
    await tester.tap(fines);
    await tester.pumpAndSettle();
    // Eerst bevestigen.
    expect(http.requestsTo('PATCH /teams/3/players/12/abilities'), isEmpty);
    await tester.tap(_key('pm-confirm-ok'));
    await tester.pumpAndSettle();
    expect(http.requestsTo('PATCH /teams/3/players/12/abilities').single.body, {
      'ability': 'fines',
      'granted': true,
    });
    expect(
      tester
          .widget<Switch>(
            find.descendant(
              of: _key('pm-toggle-ability-fines'),
              matching: find.byType(Switch),
            ),
          )
          .value,
      isTrue,
    );
  });

  testWidgets('bevoegdheid van een uitgeschakelde functie is verborgen', (
    tester,
  ) async {
    await _open(
      tester,
      membership: PmFixtures.trainerMembership(features: {'fines': false}),
    );

    await _tap(tester, 'pm-player-12');

    expect(_key('pm-toggle-ability-lineup'), findsOneWidget);
    expect(_key('pm-toggle-ability-training_points'), findsOneWidget);
    expect(_key('pm-toggle-ability-fines'), findsNothing);
  });

  testWidgets('speler zonder account: uitnodigen, geen rol', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        'POST /teams/3/players/13/invite',
        200,
        PmFixtures.data(
          PmFixtures.kees(inviteStatus: 'pending', email: 'kees@example.com'),
        ),
      ),
    );

    await _tap(tester, 'pm-player-13');
    expect(_key('pm-trainer-no-account'), findsOneWidget);
    expect(_key('pm-toggle-trainer'), findsNothing);

    await tester.enterText(_key('pm-invite-email'), 'geen-adres');
    await _tap(tester, 'pm-invite-send');
    expect(find.text('Dit is geen geldig e-mailadres.'), findsOneWidget);

    await tester.enterText(_key('pm-invite-email'), 'kees@example.com');
    await _tap(tester, 'pm-invite-send');

    expect(http.requestsTo('POST /teams/3/players/13/invite').single.body, {
      'email': 'kees@example.com',
    });
    // De sheet volgt de controller: nu "nog niet geaccepteerd".
    expect(_key('pm-invite-pending'), findsOneWidget);
    expect(_key('pm-invite-form'), findsNothing);
    await _settleToast(tester);
  });

  testWidgets('speler verwijderen na bevestiging', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on('DELETE /teams/3/players/13', 204),
    );

    await _tap(tester, 'pm-player-13');
    await _tap(tester, 'pm-manage-delete');
    expect(find.text('Kees Kaal verwijderen?'), findsOneWidget);

    http.on(
      _index,
      200,
      PmFixtures.overview(players: [PmFixtures.linda(), PmFixtures.guest()]),
    );
    await tester.tap(_key('pm-confirm-ok'));
    await tester.pumpAndSettle();

    expect(http.requestsTo('DELETE /teams/3/players/13'), hasLength(1));
    expect(_key('pm-manage-13'), findsNothing);
    expect(_key('pm-player-13'), findsNothing);
    expect(find.text('Speler verwijderd'), findsOneWidget);
    await _settleToast(tester);
  });

  testWidgets('trainer en toeschouwer weghalen, toeschouwer herinneren', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on('DELETE /teams/3/trainers/60', 204)
        ..on('DELETE /teams/3/spectators/51', 204)
        ..on(
          'POST /teams/3/spectators/51/invite/resend',
          200,
          PmFixtures.data(PmFixtures.opa()),
        ),
    );

    await _tap(tester, 'pm-spectator-resend-51');
    expect(
      http.requestsTo('POST /teams/3/spectators/51/invite/resend'),
      hasLength(1),
    );
    await _settleToast(tester);

    await _tap(tester, 'pm-trainer-remove-60');
    await tester.tap(_key('pm-confirm-ok'));
    await tester.pumpAndSettle();
    expect(http.requestsTo('DELETE /teams/3/trainers/60'), hasLength(1));
    await _settleToast(tester);

    await _tap(tester, 'pm-spectator-remove-51');
    await tester.tap(_key('pm-confirm-cancel'));
    await tester.pumpAndSettle();
    expect(http.requestsTo('DELETE /teams/3/spectators/51'), isEmpty);
  });

  testWidgets('beheer opent de spelerpagina', (tester) async {
    final (container, _) = await _open(tester);

    await _tap(tester, 'pm-player-12');
    await tester.tap(_key('pm-manage-profile'));
    await tester.pumpAndSettle();

    expect(container.read(routerProvider).state.uri.path, '/players/12');
  });

  testWidgets('de teamlink-kaart opent /teamlink', (tester) async {
    final (container, _) = await _open(
      tester,
      setup: (http) =>
          http.on('GET /teams/3/teamlink', 200, PmFixtures.teamLink()),
    );

    await _tap(tester, 'pm-teamlink-card');

    expect(container.read(routerProvider).state.uri.path, '/teamlink');
  });

  testWidgets('demo-team: alleen-lezen', (tester) async {
    await _open(tester, membership: PmFixtures.trainerMembership(demo: true));

    expect(_key('pm-read-only'), findsOneWidget);
    expect(_key('pm-add'), findsNothing);
    expect(_key('pm-trainer-remove-60'), findsNothing);
    expect(_key('pm-spectator-remove-51'), findsNothing);

    await _tap(tester, 'pm-player-12');
    expect(_key('pm-manage-edit'), findsNothing);
    expect(_key('pm-manage-delete'), findsNothing);
    expect(
      tester
          .widget<Switch>(
            find.descendant(
              of: _key('pm-toggle-captain'),
              matching: find.byType(Switch),
            ),
          )
          .onChanged,
      isNull,
    );
  });

  testWidgets('403 bij schrijven valt terug op alleen-lezen', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on('PATCH /teams/3/players/12/captain', 403, {
        'message': 'Dit is een demoteam.',
      }),
    );

    await _tap(tester, 'pm-player-12');
    await tester.tap(
      find.descendant(
        of: _key('pm-toggle-captain'),
        matching: find.byType(Switch),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Dit is een demoteam.'), findsOneWidget);
    expect(_key('pm-manage-edit'), findsNothing);
    await _settleToast(tester);
  });

  testWidgets('bewerken stuurt de velden en toont de rij', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        'PATCH /teams/3/players/12',
        200,
        PmFixtures.data({...PmFixtures.linda(), 'name': 'Linda Langer'}),
      ),
    );

    await _tap(tester, 'pm-player-12');
    await _tap(tester, 'pm-manage-edit');
    await tester.enterText(_key('pm-edit-name'), 'Linda Langer');
    await _tap(tester, 'pm-edit-save');

    expect(http.requestsTo('PATCH /teams/3/players/12').single.body, {
      'name': 'Linda Langer',
      'shirt_number': 7,
      'position': 'CM',
      'birthdate': '2001-02-03',
      'email': 'linda@example.com',
      'strength': 4,
      'is_guest': false,
    });
    expect(find.text('Linda Langer'), findsOneWidget);
    await _settleToast(tester);
  });

  testWidgets('geen trainer (403): melding', (tester) async {
    await _open(
      tester,
      waitFor: 'pm-forbidden',
      setup: (http) => http.on(_index, 403, {'message': 'Nee.'}),
    );

    expect(_key('pm-forbidden'), findsOneWidget);
    expect(_key('pm-add'), findsNothing);
  });

  testWidgets('laadfout: opnieuw proberen', (tester) async {
    final (_, http) = await _open(
      tester,
      waitFor: 'pm-error',
      setup: (http) => http.on(_index, 500, {'message': 'Kapot.'}),
    );

    http.on(_index, 200, PmFixtures.overview());
    await _tap(tester, 'pm-retry');

    expect(_key('pm-player-12'), findsOneWidget);
  });
}
