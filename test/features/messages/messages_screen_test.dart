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
import 'messages_fixtures.dart';

const _index = 'GET /teams/3/messages';
const _store = 'POST /teams/3/messages';
const _settings = 'PATCH /teams/3/messages/settings';

final Map<String, dynamic> _trainer = ApiFixtures.membership(
  role: 'trainer',
  features: {'messages': true},
);

Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  Map<String, dynamic>? overview,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [_trainer],
    setup: (http) {
      http.on(_index, 200, overview ?? MessagesFixtures.overview());
      setup?.call(http);
    },
  );
  unawaited(container.read(routerProvider).push(AppRoutes.messages));
  await pumpUntilFound(tester, find.byKey(const ValueKey('messages-screen')));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _fill(WidgetTester tester, {String title = 'Bal mee'}) async {
  await tester.enterText(
    find.byKey(const ValueKey('messages-compose-title')),
    title,
  );
  await tester.enterText(
    find.byKey(const ValueKey('messages-compose-body')),
    'Iedereen een bal mee zaterdag.',
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('toont geschiedenis, instellingen en automatische pushes', (
    tester,
  ) async {
    await _open(tester);

    expect(currentTitle(tester), 'Berichten');
    expect(find.text('Training afgelast'), findsOneWidget);
    expect(
      find.text('Veld onbespeelbaar, we zien elkaar zaterdag.'),
      findsOneWidget,
    );
    expect(find.text('door Coach Ronald · 18 ontvangers'), findsOneWidget);
    // Link-label uit link_targets in plaats van het kale pad.
    expect(find.text('za 11 okt 14:30 · Vogels 3'), findsOneWidget);
    expect(find.text('Verjaardag'), findsNWidgets(2));
    expect(
      find.text('Late afmelding (naar trainers & penningmeester)'),
      findsOneWidget,
    );
    expect(find.text('Gefeliciteerd Sam!'), findsOneWidget);
    // Alleen-aan/uit-meldingen hebben geen "tekst aanpassen".
    expect(find.text('Tekst aanpassen'), findsOneWidget);
  });

  testWidgets('lege geschiedenis', (tester) async {
    await _open(tester, overview: MessagesFixtures.overview(empty: true));
    expect(
      find.byKey(const ValueKey('messages-history-empty')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('messages-auto-history-empty')),
      findsOneWidget,
    );
  });

  testWidgets('403: alleen voor de trainer', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_index, 403, {'message': 'Geen toegang.'}),
    );
    expect(find.byKey(const ValueKey('messages-forbidden')), findsOneWidget);
    expect(find.text('Alleen voor de trainer'), findsOneWidget);
    expect(find.byKey(const ValueKey('messages-compose')), findsNothing);
  });

  testWidgets('laadfout met opnieuw proberen', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(_index, 500, {'message': 'Kapot.'}),
    );
    expect(find.byKey(const ValueKey('messages-error')), findsOneWidget);

    http.on(_index, 200, MessagesFixtures.overview());
    await _tap(tester, find.byKey(const ValueKey('messages-retry')));
    expect(find.text('Training afgelast'), findsOneWidget);
  });

  testWidgets('versturen: validatie, bevestiging, link en verversen', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(_store, 201, MessagesFixtures.sent()),
    );

    await _tap(tester, find.byKey(const ValueKey('messages-compose')));
    // Leeg: inline meldingen, geen verzoek.
    await _tap(tester, find.byKey(const ValueKey('messages-compose-send')));
    expect(find.text('Vul een titel in.'), findsOneWidget);
    expect(find.text('Vul een bericht in.'), findsOneWidget);
    expect(http.requestsTo(_store), isEmpty);

    await _fill(tester);
    await _tap(tester, find.byKey(const ValueKey('messages-compose-link')));
    await _tap(tester, find.text('Agenda').last);

    // Annuleren in de bevestiging verstuurt niets.
    await _tap(tester, find.byKey(const ValueKey('messages-compose-send')));
    expect(
      find.text('Verstuur dit bericht als push naar alle teamgenoten?'),
      findsOneWidget,
    );
    await _tap(tester, find.byKey(const ValueKey('messages-confirm-cancel')));
    expect(http.requestsTo(_store), isEmpty);

    http.on(
      _index,
      200,
      MessagesFixtures.overview(
        messages: [
          MessagesFixtures.sent()['data'] as Map<String, dynamic>,
          MessagesFixtures.message(),
        ],
      ),
    );
    await _tap(tester, find.byKey(const ValueKey('messages-compose-send')));
    await _tap(tester, find.byKey(const ValueKey('messages-confirm-send')));

    expect(http.requestsTo(_store).single.body, {
      'title': 'Bal mee',
      'body': 'Iedereen een bal mee zaterdag.',
      'url': '/agenda',
    });
    expect(http.requestsTo(_index), hasLength(2));
    expect(find.byKey(const ValueKey('messages-compose-title')), findsNothing);
    expect(find.text('Bericht verstuurd'), findsOneWidget);
    expect(find.text('Naar 18 teamgenoten'), findsOneWidget);
    expect(find.byKey(const ValueKey('messages-message-32')), findsOneWidget);
  });

  testWidgets('eigen link wordt meegestuurd', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(_store, 201, MessagesFixtures.sent()),
    );
    await _tap(tester, find.byKey(const ValueKey('messages-compose')));
    await _fill(tester);
    await _tap(tester, find.byKey(const ValueKey('messages-compose-link')));
    await _tap(tester, find.text('Eigen link…').last);
    await tester.enterText(
      find.byKey(const ValueKey('messages-compose-own-url')),
      '/events/9',
    );
    await _tap(tester, find.byKey(const ValueKey('messages-compose-send')));
    await _tap(tester, find.byKey(const ValueKey('messages-confirm-send')));
    expect(
      (http.requestsTo(_store).single.body! as Map<String, dynamic>)['url'],
      '/events/9',
    );
  });

  testWidgets('422 blijft inline in het formulier', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_store, 422, {
        'message': 'De titel is te lang.',
        'errors': {
          'title': ['De titel is te lang.'],
        },
      }),
    );
    await _tap(tester, find.byKey(const ValueKey('messages-compose')));
    await _fill(tester);
    await _tap(tester, find.byKey(const ValueKey('messages-compose-send')));
    await _tap(tester, find.byKey(const ValueKey('messages-confirm-send')));

    expect(find.text('De titel is te lang.'), findsOneWidget);
    expect(find.byKey(const ValueKey('messages-compose-error')), findsNothing);
    expect(
      find.byKey(const ValueKey('messages-compose-title')),
      findsOneWidget,
    );
  });

  testWidgets('403 (demo) bij versturen: melding in het formulier', (
    tester,
  ) async {
    await _open(
      tester,
      setup: (http) =>
          http.on(_store, 403, {'message': 'Demo-team: alleen kijken.'}),
    );
    await _tap(tester, find.byKey(const ValueKey('messages-compose')));
    await _fill(tester);
    await _tap(tester, find.byKey(const ValueKey('messages-compose-send')));
    await _tap(tester, find.byKey(const ValueKey('messages-confirm-send')));

    expect(
      find.byKey(const ValueKey('messages-compose-error')),
      findsOneWidget,
    );
    expect(find.text('Demo-team: alleen kijken.'), findsOneWidget);
  });

  testWidgets('instelling omzetten: PATCH, daarna verversen', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(_settings, 200, MessagesFixtures.settingRow()),
    );
    Switch toggle() => tester.widget<Switch>(
      find.byKey(const ValueKey('messages-toggle-birthday')),
    );
    expect(toggle().value, isTrue);

    http.on(_index, 200, MessagesFixtures.overview(birthdayEnabled: false));
    await _tap(tester, find.byKey(const ValueKey('messages-toggle-birthday')));

    expect(http.requestsTo(_settings).single.body, {
      'key': 'birthday',
      'enabled': false,
    });
    expect(toggle().value, isFalse);
  });

  testWidgets('instelling omzetten mislukt: toast, schakelaar blijft', (
    tester,
  ) async {
    await _open(
      tester,
      setup: (http) => http.on(_settings, 403, {'message': 'Demo.'}),
    );
    await _tap(tester, find.byKey(const ValueKey('messages-toggle-birthday')));

    expect(find.text('Wijzigen mislukt'), findsOneWidget);
    expect(
      tester
          .widget<Switch>(
            find.byKey(const ValueKey('messages-toggle-birthday')),
          )
          .value,
      isTrue,
    );
  });

  testWidgets('tekst aanpassen met placeholder', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        _settings,
        200,
        MessagesFixtures.settingRow(
          enabled: true,
          titleTemplate: 'Hoera {name}',
        ),
      ),
    );
    await _tap(tester, find.byKey(const ValueKey('messages-setting-birthday')));
    await tester.enterText(
      find.byKey(const ValueKey('messages-template-title')),
      'Hoera ',
    );
    await _tap(
      tester,
      find.byKey(const ValueKey('messages-template-token-{name}')),
    );
    await _tap(tester, find.byKey(const ValueKey('messages-template-save')));

    expect(http.requestsTo(_settings).single.body, {
      'key': 'birthday',
      'title_template': 'Hoera {name}',
      'body_template': null,
    });
    expect(find.text('Tekst bewaard'), findsOneWidget);
  });
}
