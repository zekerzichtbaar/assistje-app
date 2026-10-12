import 'dart:async';

import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/core/widgets/widgets.dart';
import 'package:assistje/features/wheel/presentation/widgets/wheel_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import 'wheel_fixtures.dart';

const _index = 'GET /teams/3/wheel';
const _spin = 'POST /teams/3/wheel/spin';

final Map<String, dynamic> _player = ApiFixtures.membership(
  features: {'wheel': true},
);

const _names = {17: 'Sam de Vries', 18: 'Kim Bakker', 21: 'Joep Smit'};

Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  Map<String, dynamic>? overview,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [_player],
    setup: (http) {
      http.on(_index, 200, overview ?? WheelFixtures.overview());
      setup?.call(http);
    },
  );
  unawaited(container.read(routerProvider).push(AppRoutes.wheel));
  await pumpUntilFound(tester, find.byKey(const ValueKey('wheel-screen')));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Draait met "minder beweging" aan: een korte draai (600 ms) en geen
/// confetti. (De confetti-engine rekent met de echte klok, dus onder de
/// testklok valt hij nooit uit en komt `pumpAndSettle` niet tot rust.)
Future<void> _spinWheel(WidgetTester tester) async {
  tester.platformDispatcher.accessibilityFeaturesTestValue =
      const FakeAccessibilityFeatures(disableAnimations: true);
  addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
  await tester.pump();
  await _tap(tester, find.byKey(const ValueKey('wheel-spin')));
}

WheelPainter _painter(WidgetTester tester) =>
    tester
            .widget<CustomPaint>(find.byKey(const ValueKey('wheel-canvas')))
            .painter!
        as WheelPainter;

/// De POST-handler: legt de draai vast als id 32 en zet hem daarna bovenaan
/// de recente draaien (zonder koppeling).
void _recordAs32(FakeHttpAdapter http, {bool withMatch = true}) {
  http.routes[_spin] = (request) {
    final body = request.body! as Map<String, dynamic>;
    final winner = body['winner_player_id'] as int;
    http.on(
      _index,
      200,
      WheelFixtures.overview(
        withMatch: withMatch,
        spins: [
          WheelFixtures.spin(id: 32, winner: _names[winner]!, eventId: null),
          WheelFixtures.spin(),
        ],
      ),
    );
    return FakeResponse(201, {
      'data': WheelFixtures.spin(
        id: 32,
        winner: _names[winner]!,
        eventId: null,
        winnerPlayerId: winner,
      ),
    });
  };
}

void main() {
  testWidgets('deelnemers kiezen met de vulknoppen', (tester) async {
    await _open(tester);

    expect(currentTitle(tester), 'Radje');
    expect(_painter(tester).names, isEmpty);
    expect(find.byKey(const ValueKey('wheel-min-hint')), findsOneWidget);
    expect(find.text('Aanwezig 3'), findsOneWidget);
    expect(find.text('Bank 1'), findsOneWidget);
    expect(find.text('za 11 okt · Training'), findsOneWidget);
    expect(find.text('GASTEN'), findsOneWidget);
    expect(find.text('STAF'), findsOneWidget);

    await _tap(tester, find.byKey(const ValueKey('wheel-fill-team')));
    expect(_painter(tester).names, ['Sam de Vries', 'Kim Bakker', 'Joep Smit']);
    expect(find.byKey(const ValueKey('wheel-min-hint')), findsNothing);

    await _tap(tester, find.byKey(const ValueKey('wheel-fill-present')));
    expect(_painter(tester).names, [
      'Sam de Vries',
      'Kim Bakker',
      'Coach Ronald',
    ]);

    await _tap(tester, find.byKey(const ValueKey('wheel-player-p30')));
    expect(_painter(tester).names, contains('Gast Gerrit'));

    await _tap(tester, find.byKey(const ValueKey('wheel-fill-clear')));
    expect(_painter(tester).names, isEmpty);
  });

  testWidgets('draaien: winnaar, vastleggen en koppelen aan de wedstrijd', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      setup: (http) {
        _recordAs32(http);
        http.routes['POST /teams/3/wheel/spin/32/assign'] = (_) {
          http.on(
            _index,
            200,
            WheelFixtures.overview(
              spins: [WheelFixtures.spin(id: 32), WheelFixtures.spin()],
            ),
          );
          return FakeResponse(200, {'data': WheelFixtures.spin(id: 32)});
        };
      },
    );

    await _tap(tester, find.byKey(const ValueKey('wheel-fill-team')));
    await _spinWheel(tester);

    final posted = http.requestsTo(_spin).single.body! as Map<String, dynamic>;
    expect(posted['candidate_player_ids'], [17, 18, 21]);
    expect(posted.containsKey('candidate_user_ids'), isFalse);
    final winner = _names[posted['winner_player_id']]!;
    final name = tester.widget<Text>(
      find.byKey(const ValueKey('wheel-winner-name')),
    );
    expect(name.data, winner);
    expect(find.text('ONFORTUINLIJKE WINNAAR'), findsOneWidget);
    expect(
      find.text('+ Voeg toe aan Vogels 3 - Kraaien 1 (12 okt)'),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('wheel-spin-32')), findsOneWidget);

    await _tap(tester, find.byKey(const ValueKey('wheel-winner-assign')));
    expect(http.requestsTo('POST /teams/3/wheel/spin/32/assign'), hasLength(1));
    expect(find.byKey(const ValueKey('wheel-winner-assigned')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('wheel-spin-32-unassign')),
      findsOneWidget,
    );
  });

  testWidgets('geen wedstrijd: melding in de winnaarskaart; foutje ongedaan', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      overview: WheelFixtures.overview(withMatch: false),
      setup: (http) {
        _recordAs32(http, withMatch: false);
        http.on('DELETE /teams/3/wheel/spin/32', 204);
      },
    );

    await _tap(tester, find.byKey(const ValueKey('wheel-fill-team')));
    await _spinWheel(tester);
    expect(find.byKey(const ValueKey('wheel-winner')), findsOneWidget);
    expect(find.byKey(const ValueKey('wheel-winner-no-match')), findsOneWidget);
    expect(find.byKey(const ValueKey('wheel-winner-assign')), findsNothing);

    await _tap(tester, find.byKey(const ValueKey('wheel-winner-undo')));
    expect(find.text('Laatste draai verwijderen?'), findsOneWidget);
    await _tap(tester, find.byKey(const ValueKey('wheel-delete-confirm')));

    expect(http.requestsTo('DELETE /teams/3/wheel/spin/32'), hasLength(1));
    expect(find.byKey(const ValueKey('wheel-winner')), findsNothing);
    expect(find.text('Draai verwijderd'), findsOneWidget);
  });

  testWidgets('koppelen zonder wedstrijd (422) staat inline', (tester) async {
    final (_, http) = await _open(
      tester,
      overview: WheelFixtures.overview(
        spins: [WheelFixtures.spin(eventId: null)],
      ),
      setup: (http) => http.on('POST /teams/3/wheel/spin/31/assign', 422, {
        'message': 'Geen aankomende wedstrijd binnen 7 dagen.',
        'errors': {
          'wheel': ['Geen aankomende wedstrijd binnen 7 dagen.'],
        },
      }),
    );

    await _tap(tester, find.byKey(const ValueKey('wheel-spin-31-assign')));

    expect(http.requestsTo('POST /teams/3/wheel/spin/31/assign'), hasLength(1));
    final inline = tester.widget<Text>(
      find.byKey(const ValueKey('wheel-inline-error')),
    );
    expect(inline.data, 'Geen aankomende wedstrijd binnen 7 dagen.');
  });

  testWidgets('recente draaien: zonder can_delete geen acties', (tester) async {
    await _open(
      tester,
      overview: WheelFixtures.overview(
        spins: [
          WheelFixtures.spin(canDelete: false),
          WheelFixtures.spin(id: 30, canDelete: false, eventId: null),
          WheelFixtures.spin(id: 29, eventId: 700),
        ],
      ),
    );

    expect(find.text('LAATSTE 10 DRAAIEN'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('wheel-spin-31-unassign')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('wheel-spin-31-delete')), findsNothing);
    expect(find.byKey(const ValueKey('wheel-spin-30-assign')), findsNothing);
    expect(find.byKey(const ValueKey('wheel-spin-30-delete')), findsNothing);
    expect(
      find.byKey(const ValueKey('wheel-spin-29-elsewhere')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('wheel-spin-29-delete')), findsOneWidget);
  });

  testWidgets('draai ontkoppelen en verwijderen uit de lijst', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on('DELETE /teams/3/wheel/spin/31/assign', 200, {
          'data': WheelFixtures.spin(eventId: null),
        })
        ..on('DELETE /teams/3/wheel/spin/31', 403, {
          'message': 'Dit mag alleen de trainer.',
        }),
    );

    await _tap(tester, find.byKey(const ValueKey('wheel-spin-31-unassign')));
    expect(
      http.requestsTo('DELETE /teams/3/wheel/spin/31/assign'),
      hasLength(1),
    );
    expect(find.text('Koppeling verwijderd'), findsOneWidget);

    await _tap(tester, find.byKey(const ValueKey('wheel-spin-31-delete')));
    await _tap(tester, find.byKey(const ValueKey('wheel-delete-confirm')));
    // 403 → toast, niet inline.
    expect(find.text('Dit mag alleen de trainer.'), findsOneWidget);
    expect(find.byKey(const ValueKey('wheel-inline-error')), findsNothing);
  });

  testWidgets('laadfout met opnieuw proberen', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(_index, 500, {'message': 'Kapot.'}),
    );
    expect(find.byKey(const ValueKey('wheel-error')), findsOneWidget);

    http.on(_index, 200, WheelFixtures.overview());
    await _tap(tester, find.byKey(const ValueKey('wheel-retry')));
    expect(find.byKey(const ValueKey('wheel-card')), findsOneWidget);
  });

  testWidgets('volledige draai: tikjes, uitloop en confetti', (tester) async {
    await _open(tester, setup: _recordAs32);
    await _tap(tester, find.byKey(const ValueKey('wheel-fill-team')));
    final haptics = <String?>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'HapticFeedback.vibrate') {
          haptics.add(call.arguments as String?);
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    final button = find.byKey(const ValueKey('wheel-spin'));
    await tester.ensureVisible(button);
    await tester.pumpAndSettle();
    await tester.tap(button);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Draaien…'), findsOneWidget);
    expect(find.byKey(const ValueKey('wheel-winner')), findsNothing);
    // De animatie start pas op het frame na de tik: nog ruim 4 s.
    for (var i = 0; i < 45; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.byKey(const ValueKey('wheel-winner')), findsOneWidget);
    final confetti = tester.state<ConfettiBurstState>(
      find.byType(ConfettiBurst),
    );
    expect(confetti.isPlaying, isTrue);
    // Een tik per gepasseerd segment (bij 100 ms-frames vallen er een paar weg) en een succes-tik.
    expect(
      haptics.where((h) => h == 'HapticFeedbackType.selectionClick').length,
      greaterThanOrEqualTo(10),
    );
    expect(haptics, contains('HapticFeedbackType.mediumImpact'));
    expect(find.text('Draai!'), findsOneWidget);
  });
}
