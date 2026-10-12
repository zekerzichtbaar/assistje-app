import 'dart:async';

import 'package:assistje/app.dart';
import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/features/player_management/application/share_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/test_app.dart';
import 'live_fixtures.dart';

/// Vangt het deelmenu op in plaats van het te openen.
class _FakeShare extends ShareService {
  final List<String> shared = [];
  final List<Rect?> origins = [];

  @override
  Future<void> share(String text, {String? subject, Rect? origin}) async {
    shared.add(text);
    origins.add(origin);
  }
}

/// Als `pumpSignedIn`, maar met een nep-[ShareService].
Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  required Map<String, dynamic> live,
  required _FakeShare share,
  bool manager = false,
}) async {
  tester.view
    ..physicalSize = const Size(1800, 4200)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final backend = TestBackend(token: '12|abc');
  await backend.init();
  final membership = LiveFixtures.membership(manager: manager);
  final team = membership['team'] as Map<String, dynamic>;
  backend.http
    ..on('GET /me', 200, ApiFixtures.meResponse(teams: [membership]))
    ..on(
      'GET /teams/${team['id']}/agenda',
      200,
      ApiFixtures.emptyAgendaResponse(),
    )
    ..on(LiveFixtures.get, 200, live);
  final container = ProviderContainer(
    overrides: [
      ...backend.overrides,
      shareServiceProvider.overrideWithValue(share),
    ],
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const AssistjeApp()),
  );
  await pumpUntilFound(tester, find.byKey(const Key('glass-tab-bar')));
  unawaited(container.read(routerProvider).push('/events/412/live'));
  await pumpUntilFound(tester, find.byKey(const ValueKey('live-screen')));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Finder _key(String key) => find.byKey(ValueKey(key));

Future<void> _close(WidgetTester tester, ProviderContainer container) async {
  container.read(routerProvider).pop();
  await tester.pumpAndSettle();
}

Map<String, dynamic> _withoutShareUrl(Map<String, dynamic> response) {
  final data = response['data'] as Map<String, dynamic>;
  (data['event'] as Map<String, dynamic>)['share_url'] = null;
  return response;
}

void main() {
  const url = 'https://test-team.assistje.nl/live/Xk3';

  testWidgets('speler (geen trainer) deelt een lopende wedstrijd', (
    tester,
  ) async {
    final share = _FakeShare();
    final (container, _) = await _open(
      tester,
      live: LiveFixtures.response(),
      share: share,
    );

    expect(_key('live-controls'), findsNothing, reason: 'geen trainer');
    expect(_key('live-share-row'), findsOneWidget);
    expect(find.text('Laat het team live meekijken'), findsOneWidget);

    await tester.ensureVisible(_key('live-share'));
    await tester.pumpAndSettle();
    await tester.tap(_key('live-share'));
    await tester.pumpAndSettle();

    expect(share.shared, [
      'Volg Test Team - De Buren live!\n\n'
          'Bekijk de stand en het verloop realtime (geen app nodig):\n$url',
    ]);
    expect(share.origins.single, isNotNull, reason: 'iPad-anker');

    await _close(tester, container);
  });

  testWidgets('afgelopen wedstrijd: de uitslag delen', (tester) async {
    final share = _FakeShare();
    final (container, _) = await _open(
      tester,
      live: LiveFixtures.response(
        homeScore: 3,
        awayScore: 1,
        live: LiveFixtures.clock(endedAt: '2026-10-11T16:15:00+02:00'),
      ),
      share: share,
    );

    expect(find.text('Deel de uitslag met het team'), findsOneWidget);
    await tester.ensureVisible(_key('live-share'));
    await tester.pumpAndSettle();
    await tester.tap(_key('live-share'));
    await tester.pumpAndSettle();

    expect(share.shared, [
      'Test Team - De Buren\n3 - 1\n\n'
          'Bekijk het wedstrijdverslag (geen app nodig):\n$url',
    ]);

    await _close(tester, container);
  });

  testWidgets('trainer ziet de rij ook', (tester) async {
    final share = _FakeShare();
    final (container, _) = await _open(
      tester,
      manager: true,
      live: LiveFixtures.response(canManage: true),
      share: share,
    );
    expect(_key('live-share-row'), findsOneWidget);
    await _close(tester, container);
  });

  testWidgets('nog niet begonnen: geen deelrij', (tester) async {
    final (container, _) = await _open(
      tester,
      live: LiveFixtures.response(
        live: LiveFixtures.clock(isLive: false, seconds: 0),
        homeScore: null,
        awayScore: null,
        goals: const [],
        subs: const [],
        cards: const [],
        moments: const [],
        reactions: const <String, dynamic>{},
      ),
      share: _FakeShare(),
    );
    expect(_key('live-share-row'), findsNothing);
    await _close(tester, container);
  });

  testWidgets('zonder deellink: geen deelrij', (tester) async {
    final (container, _) = await _open(
      tester,
      live: _withoutShareUrl(LiveFixtures.response()),
      share: _FakeShare(),
    );
    expect(_key('live-share-row'), findsNothing);
    await _close(tester, container);
  });
}
