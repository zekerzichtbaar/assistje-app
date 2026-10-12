import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/shell.dart';
import '../profile/profile_fixtures.dart';
import 'absences_fixtures.dart';
import 'absences_screen_harness.dart';

const _post = 'POST /teams/3/standing-absences';

Future<FakeHttpAdapter> _open(
  WidgetTester tester, {
  bool featureOn = true,
  Map<String, dynamic>? profile,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (_, http) = await openAbsencesScreen(
    tester,
    path: AppRoutes.standingAbsences,
    screenKey: 'standing-screen',
    features: {'standing_absences': featureOn},
    setup: (http) {
      http.on(absencesProfileRoute, 200, profile ?? ProfileFixtures.profile());
      setup?.call(http);
    },
  );
  return http;
}

String _subtitle(WidgetTester tester, int weekday) {
  final tile = tester.widget<ListTile>(
    find.byKey(ValueKey('standing-day-$weekday')),
  );
  return ((tile.subtitle! as Text).data) ?? '';
}

void main() {
  testWidgets('toont de trainingsdagen met de gekozen dag aan', (tester) async {
    await _open(tester);
    expect(currentTitle(tester), 'Vaste afwezigheid');
    expect(find.text('Dinsdag'), findsOneWidget);
    expect(find.text('Donderdag'), findsOneWidget);
    expect(_subtitle(tester, 2), 'Afwezig');
    expect(_subtitle(tester, 4), 'Kan wel');
  });

  testWidgets('aanzetten (POST) en uitzetten (DELETE)', (tester) async {
    // De nep-API onthoudt de dagen (het profiel wordt na elke wijziging
    // opnieuw opgehaald).
    final days = <Map<String, dynamic>>[
      {'id': 1, 'weekday': 2},
    ];
    final http = await _open(
      tester,
      setup: (http) {
        http.routes[absencesProfileRoute] = (_) => FakeResponse(
          200,
          ProfileFixtures.profile(
            standingAbsences: {
              'days': days,
              'choices': [2, 4],
            },
          ),
        );
        http.routes[_post] = (_) {
          days.add({'id': 20, 'weekday': 4});
          return FakeResponse(
            201,
            AbsencesFixtures.standingDay(id: 20, weekday: 4),
          );
        };
        http.routes['DELETE /teams/3/standing-absences/1'] = (_) {
          days.removeWhere((d) => d['id'] == 1);
          return const FakeResponse(204);
        };
      },
    );

    await tapAndSettle(tester, find.byKey(const ValueKey('standing-switch-4')));
    expect(http.requestsTo(_post).single.body, {'weekday': 4});
    expect(find.text('Op donderdag sta je voortaan afwezig'), findsOneWidget);
    expect(_subtitle(tester, 4), 'Afwezig');

    await tapAndSettle(tester, find.byKey(const ValueKey('standing-switch-2')));
    expect(
      http.requestsTo('DELETE /teams/3/standing-absences/1'),
      hasLength(1),
    );
    expect(find.text('Op dinsdag kun je weer'), findsOneWidget);
    expect(_subtitle(tester, 2), 'Kan wel');
  });

  testWidgets('fout → toast met de melding, schakelaar blijft', (tester) async {
    await _open(
      tester,
      setup: (http) =>
          http.on(_post, 403, {'message': ProfileFixtures.demoMessage}),
    );
    await tapAndSettle(tester, find.byKey(const ValueKey('standing-switch-4')));
    expect(find.text('Opslaan mislukt'), findsOneWidget);
    expect(find.text(ProfileFixtures.demoMessage), findsOneWidget);
    expect(_subtitle(tester, 4), 'Kan wel');
  });

  testWidgets('feature uit: lege staat', (tester) async {
    await _open(tester, featureOn: false);
    expect(find.byKey(const ValueKey('standing-feature-off')), findsOneWidget);
  });

  testWidgets('geen spelersprofiel: uitleg', (tester) async {
    await _open(tester, profile: ProfileFixtures.profile(withPlayer: false));
    expect(find.byKey(const ValueKey('standing-no-player')), findsOneWidget);
  });

  testWidgets('geen trainingsdagen: uitleg', (tester) async {
    await _open(
      tester,
      profile: ProfileFixtures.profile(
        standingAbsences: {'days': <Object>[], 'choices': <Object>[]},
      ),
    );
    expect(find.byKey(const ValueKey('standing-no-choices')), findsOneWidget);
  });
}
