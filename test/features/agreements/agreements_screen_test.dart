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
import 'agreements_fixtures.dart';

const _index = 'GET /teams/3/agreements';

final Map<String, dynamic> _player = ApiFixtures.membership(
  features: {'agreements': true},
);
final Map<String, dynamic> _trainer = ApiFixtures.membership(
  role: 'trainer',
  features: {'agreements': true},
);

Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  required Map<String, dynamic> membership,
  Map<String, dynamic>? overview,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [membership],
    setup: (http) {
      http.on(_index, 200, overview ?? AgreementsFixtures.overview());
      setup?.call(http);
    },
  );
  unawaited(container.read(routerProvider).push(AppRoutes.agreements));
  await pumpUntilFound(tester, find.byKey(const ValueKey('agreements-screen')));
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
  testWidgets('lid: intro en groepen, geen bewerkknoppen', (tester) async {
    await _open(tester, membership: _player);

    expect(currentTitle(tester), 'Afspraken');
    expect(find.text('Zo doen we het bij Vogels 3.'), findsOneWidget);
    expect(find.text('TRAININGEN'), findsOneWidget);
    expect(find.text('GELD'), findsOneWidget);
    expect(find.text('Ballen opruimen'), findsOneWidget);
    expect(find.text('Omgekleed op het veld.'), findsOneWidget);
    expect(find.byKey(const ValueKey('agreements-add')), findsNothing);
    expect(find.byKey(const ValueKey('agreements-intro-edit')), findsNothing);

    await tester.tap(find.byKey(const ValueKey('agreement-3')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('agreement-form-title')), findsNothing);
  });

  testWidgets('lid: lege staat zonder knop', (tester) async {
    await _open(
      tester,
      membership: _player,
      overview: AgreementsFixtures.overview(empty: true, intro: null),
    );
    expect(find.byKey(const ValueKey('agreements-empty')), findsOneWidget);
    expect(
      find.text('De trainer heeft nog geen afspraken vastgelegd.'),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('agreements-add-first')), findsNothing);
  });

  testWidgets('laadfout met opnieuw proberen', (tester) async {
    final (_, http) = await _open(
      tester,
      membership: _player,
      setup: (http) => http.on(_index, 500, {'message': 'Kapot.'}),
    );
    expect(find.byKey(const ValueKey('agreements-error')), findsOneWidget);

    http.on(_index, 200, AgreementsFixtures.overview());
    await _tap(tester, find.byKey(const ValueKey('agreements-retry')));
    expect(find.text('Ballen opruimen'), findsOneWidget);
  });

  group('trainer', () {
    testWidgets('afspraak toevoegen met categorie', (tester) async {
      final (_, http) = await _open(
        tester,
        membership: _trainer,
        overview: AgreementsFixtures.overview(canManage: true),
        setup: (http) => http.on(
          'POST /teams/3/agreements',
          201,
          AgreementsFixtures.saved(),
        ),
      );

      await _tap(tester, find.byKey(const ValueKey('agreements-add')));
      // Zonder titel: inline melding, geen verzoek.
      await _tap(tester, find.byKey(const ValueKey('agreement-form-save')));
      expect(find.text('Vul de afspraak in.'), findsOneWidget);
      expect(http.requestsTo('POST /teams/3/agreements'), isEmpty);

      await _tap(
        tester,
        find.byKey(const ValueKey('agreement-form-category-money')),
      );
      await tester.enterText(
        find.byKey(const ValueKey('agreement-form-title')),
        'Contributie op tijd',
      );
      await tester.enterText(
        find.byKey(const ValueKey('agreement-form-body')),
        'Voor 1 oktober.',
      );
      await _tap(tester, find.byKey(const ValueKey('agreement-form-save')));

      expect(http.requestsTo('POST /teams/3/agreements').single.body, {
        'category': 'money',
        'title': 'Contributie op tijd',
        'body': 'Voor 1 oktober.',
      });
      expect(http.requestsTo(_index), hasLength(2));
      expect(find.byKey(const ValueKey('agreement-form-title')), findsNothing);
      expect(find.text('Afspraak toegevoegd'), findsOneWidget);
    });

    testWidgets('422 blijft inline in het formulier', (tester) async {
      await _open(
        tester,
        membership: _trainer,
        overview: AgreementsFixtures.overview(canManage: true),
        setup: (http) => http.on('PATCH /teams/3/agreements/1', 422, {
          'message': 'De titel is te lang.',
          'errors': {
            'title': ['De titel is te lang.'],
          },
        }),
      );

      await _tap(tester, find.byKey(const ValueKey('agreement-1')));
      expect(find.text('Afspraak wijzigen'), findsOneWidget);
      await _tap(tester, find.byKey(const ValueKey('agreement-form-save')));

      expect(find.text('De titel is te lang.'), findsOneWidget);
      expect(find.byKey(const ValueKey('agreement-form-error')), findsNothing);
      expect(
        find.byKey(const ValueKey('agreement-form-title')),
        findsOneWidget,
      );
    });

    testWidgets('afspraak verwijderen na bevestiging', (tester) async {
      final (_, http) = await _open(
        tester,
        membership: _trainer,
        overview: AgreementsFixtures.overview(canManage: true),
        setup: (http) => http.on('DELETE /teams/3/agreements/5', 204),
      );

      await _tap(tester, find.byKey(const ValueKey('agreement-5')));
      await _tap(tester, find.byKey(const ValueKey('agreement-form-delete')));
      expect(
        find.text("Afspraak 'Contributie voor 1 oktober' verwijderen?"),
        findsOneWidget,
      );
      await _tap(
        tester,
        find.byKey(const ValueKey('agreements-delete-confirm')),
      );

      expect(http.requestsTo('DELETE /teams/3/agreements/5'), hasLength(1));
      expect(find.text('Afspraak verwijderd'), findsOneWidget);
    });

    testWidgets('intro wijzigen; zonder intro een toevoegknop', (tester) async {
      final (_, http) = await _open(
        tester,
        membership: _trainer,
        overview: AgreementsFixtures.overview(canManage: true, intro: null),
        setup: (http) => http.on('PATCH /teams/3/agreements/intro', 200, {
          'data': {'intro': 'Nieuw seizoen.'},
        }),
      );

      expect(find.byKey(const ValueKey('agreements-intro')), findsNothing);
      http.on(
        _index,
        200,
        AgreementsFixtures.overview(canManage: true, intro: 'Nieuw seizoen.'),
      );
      await _tap(tester, find.byKey(const ValueKey('agreements-intro-add')));
      await tester.enterText(
        find.byKey(const ValueKey('intro-form-text')),
        'Nieuw seizoen.',
      );
      await _tap(tester, find.byKey(const ValueKey('intro-form-save')));

      expect(http.requestsTo('PATCH /teams/3/agreements/intro').single.body, {
        'intro': 'Nieuw seizoen.',
      });
      expect(find.byKey(const ValueKey('agreements-intro')), findsOneWidget);
      expect(
        find.byKey(const ValueKey('agreements-intro-edit')),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('agreements-intro-add')), findsNothing);
    });

    testWidgets('lege lijst: eerste afspraak toevoegen', (tester) async {
      await _open(
        tester,
        membership: _trainer,
        overview: AgreementsFixtures.overview(
          canManage: true,
          empty: true,
          intro: null,
        ),
      );
      expect(
        find.byKey(const ValueKey('agreements-add-first')),
        findsOneWidget,
      );
      await _tap(tester, find.byKey(const ValueKey('agreements-add-first')));
      expect(
        find.byKey(const ValueKey('agreement-form-title')),
        findsOneWidget,
      );
    });

    testWidgets('403 bij opslaan geeft een melding in het formulier', (
      tester,
    ) async {
      await _open(
        tester,
        membership: _trainer,
        overview: AgreementsFixtures.overview(canManage: true),
        setup: (http) => http.on('PATCH /teams/3/agreements/3', 403, {
          'message': 'Alleen de trainer.',
        }),
      );
      await _tap(tester, find.byKey(const ValueKey('agreement-3')));
      await _tap(tester, find.byKey(const ValueKey('agreement-form-save')));
      expect(
        find.byKey(const ValueKey('agreement-form-error')),
        findsOneWidget,
      );
      expect(find.text('Alleen de trainer.'), findsOneWidget);
    });
  });
}
