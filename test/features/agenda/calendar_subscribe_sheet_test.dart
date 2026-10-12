import 'package:assistje/app.dart';
import 'package:assistje/features/agenda/application/calendar_feed.dart';
import 'package:assistje/features/player_management/application/share_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/pump.dart';
import '../../helpers/test_app.dart';

const _feed = 'https://vogels-3.assistje.nl/calendar/AbC…48/agenda.ics';

class _FakeLauncher implements ExternalUrlLauncher {
  _FakeLauncher({this.result = true, this.throws = false});

  final bool result;
  final bool throws;
  final List<Uri> opened = [];

  @override
  Future<bool> open(Uri uri) async {
    opened.add(uri);
    if (throws) throw Exception('geen app');
    return result;
  }
}

class _FakeShare extends ShareService {
  final List<String> copied = [];

  @override
  Future<void> copy(String text) async => copied.add(text);
}

Map<String, dynamic> _agenda({
  String? feedUrl = _feed,
  bool hasMatches = true,
  bool hasTrainings = true,
  List<Map<String, dynamic>>? dutyTypes,
}) {
  final response = ApiFixtures.emptyAgendaResponse();
  final data = response['data'] as Map<String, dynamic>;
  data['agenda_feed_url'] = feedUrl;
  data['has_matches'] = hasMatches;
  data['has_trainings'] = hasTrainings;
  if (dutyTypes != null) data['duty_types'] = dutyTypes;
  return response;
}

Future<void> _pump(
  WidgetTester tester, {
  required Map<String, dynamic> agenda,
  _FakeLauncher? launcher,
  _FakeShare? share,
  Map<String, dynamic>? membership,
}) async {
  tester.view
    ..physicalSize = const Size(1800, 4200)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final backend = TestBackend(token: '12|abc');
  await backend.init();
  final team = membership ?? ApiFixtures.membership();
  backend.http.on('GET /me', 200, ApiFixtures.meResponse(teams: [team]));
  final teamId = (team['team'] as Map<String, dynamic>)['id'];
  backend.http.on('GET /teams/$teamId/agenda', 200, agenda);
  final container = ProviderContainer(
    overrides: [
      ...backend.overrides,
      externalUrlLauncherProvider.overrideWithValue(
        launcher ?? _FakeLauncher(),
      ),
      shareServiceProvider.overrideWithValue(share ?? _FakeShare()),
    ],
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const AssistjeApp()),
  );
  await pumpUntilFound(tester, find.byKey(const Key('glass-tab-bar')));
  await tester.pumpAndSettle();
}

Future<void> _openSheet(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('agenda-calendar')));
  await tester.pumpAndSettle();
}

Future<void> _tap(WidgetTester tester, String key) async {
  await tester.tap(find.byKey(ValueKey(key)));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('knop staat er met feed, ook voor spelers', (tester) async {
    await _pump(tester, agenda: _agenda());
    expect(find.byKey(const ValueKey('agenda-calendar')), findsOneWidget);
    expect(find.text('Zet in agenda'), findsOneWidget);
  });

  testWidgets('geen agenda_feed_url → geen knop', (tester) async {
    await _pump(tester, agenda: _agenda(feedUrl: null));
    expect(find.byKey(const ValueKey('agenda-calendar')), findsNothing);
  });

  testWidgets('rijen: wedstrijden, trainingen en diensttypes', (tester) async {
    await _pump(
      tester,
      agenda: _agenda(
        dutyTypes: [
          {'id': 1, 'name': 'Kantinedienst', 'slug': 'canteen', 'icon': null},
          {'id': 2, 'name': 'Wasbeurt', 'slug': 'wash', 'icon': 't-shirt'},
        ],
      ),
    );
    await _openSheet(tester);
    expect(find.text('Wedstrijden'), findsOneWidget);
    expect(find.text('Trainingen'), findsOneWidget);
    expect(find.text('Alleen jouw kantinedienst-beurten'), findsOneWidget);
    expect(find.text('Alleen jouw wasbeurt-beurten'), findsOneWidget);
    expect(find.text('Alleen waar ik bij ben'), findsOneWidget);
    expect(
      find.text('Je agenda werkt vanzelf bij als er iets verandert.'),
      findsOneWidget,
    );
  });

  testWidgets('verborgen rijen zonder wedstrijden/trainingen', (tester) async {
    await _pump(
      tester,
      agenda: _agenda(hasMatches: false, hasTrainings: false),
    );
    await _openSheet(tester);
    expect(find.byKey(const ValueKey('calendar-matches')), findsNothing);
    expect(find.byKey(const ValueKey('calendar-trainings')), findsNothing);
    expect(find.byKey(const ValueKey('calendar-duty-canteen')), findsOneWidget);
  });

  testWidgets('abonneren opent webcal:// met de gekozen onderdelen', (
    tester,
  ) async {
    final launcher = _FakeLauncher();
    final share = _FakeShare();
    await _pump(tester, agenda: _agenda(), launcher: launcher, share: share);
    await _openSheet(tester);

    await _tap(tester, 'calendar-trainings');
    await _tap(tester, 'calendar-only-mine');
    await _tap(tester, 'calendar-subscribe');

    expect(launcher.opened, [
      Uri.parse(
        'webcal://vogels-3.assistje.nl/calendar/AbC…48/agenda.ics'
        '?matches=1&duties=canteen&mine=1',
      ),
    ]);
    expect(share.copied, isEmpty);
    // De sheet is dicht.
    expect(find.byKey(const ValueKey('calendar-subscribe')), findsNothing);
  });

  testWidgets('kopiëren zet de https-link op het klembord', (tester) async {
    final launcher = _FakeLauncher();
    final share = _FakeShare();
    await _pump(tester, agenda: _agenda(), launcher: launcher, share: share);
    await _openSheet(tester);

    await _tap(tester, 'calendar-duty-canteen');
    await tester.tap(find.byKey(const ValueKey('calendar-copy')));
    await tester.pump();

    expect(share.copied, ['$_feed?matches=1&trainings=1']);
    expect(launcher.opened, isEmpty);
    expect(find.text('Link gekopieerd'), findsWidgets);
    await tester.pumpAndSettle(const Duration(seconds: 5));
  });

  testWidgets('niets gekozen → knoppen uit', (tester) async {
    final launcher = _FakeLauncher();
    final share = _FakeShare();
    await _pump(tester, agenda: _agenda(), launcher: launcher, share: share);
    await _openSheet(tester);

    await _tap(tester, 'calendar-matches');
    await _tap(tester, 'calendar-trainings');
    await _tap(tester, 'calendar-duty-canteen');
    // Zonder wedstrijden/trainingen valt er niets te filteren.
    expect(find.byKey(const ValueKey('calendar-only-mine')), findsNothing);

    await _tap(tester, 'calendar-subscribe');
    await _tap(tester, 'calendar-copy');
    expect(launcher.opened, isEmpty);
    expect(share.copied, isEmpty);
    expect(
      tester
          .widget<TextButton>(find.byKey(const ValueKey('calendar-copy')))
          .onPressed,
      isNull,
    );
  });

  for (final throws in [false, true]) {
    testWidgets('openen mislukt (throws: $throws) → link gekopieerd + toast', (
      tester,
    ) async {
      final launcher = _FakeLauncher(result: false, throws: throws);
      final share = _FakeShare();
      await _pump(tester, agenda: _agenda(), launcher: launcher, share: share);
      await _openSheet(tester);

      await tester.tap(find.byKey(const ValueKey('calendar-subscribe')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(launcher.opened, hasLength(1));
      expect(share.copied, ['$_feed?matches=1&trainings=1&duties=canteen']);
      expect(
        find.text('Agenda-app niet geopend — de link staat op je klembord'),
        findsOneWidget,
      );
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });
  }
}
