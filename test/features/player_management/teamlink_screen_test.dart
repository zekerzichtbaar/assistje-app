import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import 'pm_fixtures.dart';

const _link = 'GET /teams/3/teamlink';

Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  Map<String, dynamic>? membership,
  void Function(FakeHttpAdapter http)? setup,
  String waitFor = 'tl-joined',
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [membership ?? PmFixtures.trainerMembership()],
    setup: (http) {
      http.on(_link, 200, PmFixtures.teamLink());
      setup?.call(http);
    },
  );
  container.read(routerProvider).go(AppRoutes.teamlink);
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

Future<void> _settleToast(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('actieve link: url, verloopdatum en wie er binnenkwam', (
    tester,
  ) async {
    await _open(tester);

    expect(currentTitle(tester), 'Teamlink');
    expect(_key('tl-active'), findsOneWidget);
    expect(
      find.text('https://vogels3.assistje.nl/meedoen/Xk3abc'),
      findsOneWidget,
    );
    expect(
      tester.widget<Text>(_key('tl-expires')).data,
      startsWith('Deze link werkt tot 8 januari.'),
    );
    expect(_key('tl-joined-40'), findsOneWidget);
    expect(find.textContaining('Toeschouwer · 8 oktober'), findsOneWidget);
    expect(_key('tl-rotate'), findsOneWidget);
    expect(_key('tl-revoke'), findsOneWidget);
  });

  testWidgets('kopiëren zet het uitnodigingsbericht op het klembord', (
    tester,
  ) async {
    final calls = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        calls.add(call);
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    await _open(tester);

    await _tap(tester, 'tl-copy');

    final copy = calls.lastWhere((c) => c.method == 'Clipboard.setData');
    final text = (copy.arguments as Map)['text'] as String;
    expect(text, contains('Vogels 3'));
    expect(text, endsWith('https://vogels3.assistje.nl/meedoen/Xk3abc'));
    expect(find.text('Gekopieerd'), findsOneWidget);
    await _settleToast(tester);
  });

  testWidgets('delen opent het deelmenu met het bericht', (tester) async {
    final calls = <MethodCall>[];
    const channel = MethodChannel('dev.fluttercommunity.plus/share');
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, (
      call,
    ) async {
      calls.add(call);
      return 'dev.fluttercommunity.plus/share/unavailable';
    });
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        null,
      ),
    );
    await _open(tester);

    await _tap(tester, 'tl-share');

    final args = calls.single.arguments as Map;
    expect(args['text'] as String, contains('/meedoen/Xk3abc'));
    expect(args['subject'], 'Doe mee met Vogels 3');
  });

  testWidgets('QR-code in een sheet', (tester) async {
    await _open(tester);

    await _tap(tester, 'tl-show-qr');

    final qr = tester.widget<QrImageView>(_key('tl-qr'));
    expect(qr.semanticsLabel, 'QR-code naar de teamlink van Vogels 3');
  });

  testWidgets('intrekken na bevestiging, daarna een nieuwe maken', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on(
          'DELETE /teams/3/teamlink',
          200,
          PmFixtures.teamLink(state: 'revoked'),
        )
        ..on('POST /teams/3/teamlink', 201, PmFixtures.teamLink()),
    );

    await _tap(tester, 'tl-revoke');
    expect(find.text('Teamlink intrekken?'), findsOneWidget);
    await tester.tap(_key('pm-confirm-ok'));
    await tester.pumpAndSettle();

    expect(http.requestsTo('DELETE /teams/3/teamlink'), hasLength(1));
    expect(_key('tl-revoked'), findsOneWidget);
    expect(_key('tl-active'), findsNothing);
    await _settleToast(tester);

    await _tap(tester, 'tl-create');

    expect(http.requestsTo('POST /teams/3/teamlink'), hasLength(1));
    expect(_key('tl-active'), findsOneWidget);
    await _settleToast(tester);
  });

  testWidgets('nieuwe link maken vraagt eerst bevestiging', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) =>
          http.on('POST /teams/3/teamlink', 201, PmFixtures.teamLink()),
    );

    await _tap(tester, 'tl-rotate');
    await tester.tap(_key('pm-confirm-cancel'));
    await tester.pumpAndSettle();
    expect(http.requestsTo('POST /teams/3/teamlink'), isEmpty);

    await _tap(tester, 'tl-rotate');
    await tester.tap(_key('pm-confirm-ok'));
    await tester.pumpAndSettle();
    expect(http.requestsTo('POST /teams/3/teamlink'), hasLength(1));
    await _settleToast(tester);
  });

  testWidgets('verlopen link: uitleg en nieuwe maken', (tester) async {
    await _open(
      tester,
      setup: (http) =>
          http.on(_link, 200, PmFixtures.teamLink(state: 'expired')),
    );

    expect(_key('tl-expired'), findsOneWidget);
    expect(find.textContaining('werkt 90 dagen'), findsOneWidget);
    expect(_key('tl-create'), findsOneWidget);
  });

  testWidgets('demo-team: geen intrekken of vernieuwen', (tester) async {
    await _open(tester, membership: PmFixtures.trainerMembership(demo: true));

    expect(_key('tl-read-only'), findsOneWidget);
    expect(_key('tl-rotate'), findsNothing);
    expect(_key('tl-revoke'), findsNothing);
    expect(_key('tl-copy'), findsOneWidget);
  });

  testWidgets('een fout bij intrekken laat de link staan', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on('DELETE /teams/3/teamlink', 403, {
        'message': 'Dit is een demoteam.',
      }),
    );

    await _tap(tester, 'tl-revoke');
    await tester.tap(_key('pm-confirm-ok'));
    await tester.pumpAndSettle();

    expect(find.text('Dit is een demoteam.'), findsOneWidget);
    expect(_key('tl-active'), findsOneWidget);
    await _settleToast(tester);
  });

  testWidgets('geen trainer (403): melding', (tester) async {
    await _open(
      tester,
      waitFor: 'tl-forbidden',
      setup: (http) => http.on(_link, 403, {'message': 'Nee.'}),
    );

    expect(_key('tl-forbidden'), findsOneWidget);
  });
}
