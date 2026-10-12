import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/features/absences/presentation/widgets/absences_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/shell.dart';
import '../profile/profile_fixtures.dart';
import 'absences_fixtures.dart';
import 'absences_screen_harness.dart';

const _post = 'POST /teams/3/vacations';

final Map<String, dynamic> _wintersport = {
  'id': 5,
  'starts_on': '2026-12-20',
  'ends_on': '2027-01-03',
  'note': 'Wintersport',
};

Future<FakeHttpAdapter> _open(
  WidgetTester tester, {
  bool featureOn = true,
  Map<String, dynamic>? profile,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (_, http) = await openAbsencesScreen(
    tester,
    path: AppRoutes.vacations,
    screenKey: 'vacations-screen',
    features: {'vacations': featureOn},
    setup: (http) {
      http.on(absencesProfileRoute, 200, profile ?? ProfileFixtures.profile());
      setup?.call(http);
    },
  );
  return http;
}

/// Kiest in de datumkiezer achter [field] de voorgestelde datum (vandaag).
Future<void> _pickToday(WidgetTester tester, String field) async {
  await tapAndSettle(tester, find.byKey(ValueKey(field)));
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();
}

void main() {
  final now = DateTime.now();
  final today = isoAbsenceDate(DateTime(now.year, now.month, now.day));

  testWidgets('toont de vakanties uit het profiel', (tester) async {
    await _open(tester);
    expect(currentTitle(tester), 'Vakanties');
    expect(find.byKey(const ValueKey('vacation-5')), findsOneWidget);
    expect(find.text('Wintersport'), findsOneWidget);
    expect(find.byKey(const ValueKey('vacations-add')), findsOneWidget);
  });

  testWidgets('toevoegen: datums verplicht, dan POST en in de lijst', (
    tester,
  ) async {
    // De nep-API onthoudt de nieuwe vakantie (het profiel wordt daarna
    // opnieuw opgehaald).
    final vacations = [_wintersport];
    final http = await _open(
      tester,
      setup: (http) {
        http.routes[absencesProfileRoute] = (_) =>
            FakeResponse(200, ProfileFixtures.profile(vacations: vacations));
        http.routes[_post] = (_) {
          vacations.add(
            AbsencesFixtures.vacation()['data'] as Map<String, dynamic>,
          );
          return FakeResponse(201, AbsencesFixtures.vacation());
        };
      },
    );

    await tapAndSettle(tester, find.byKey(const ValueKey('vacations-add')));
    await tapAndSettle(tester, find.byKey(const ValueKey('vacation-save')));
    expect(find.byKey(const ValueKey('vacation-dates-error')), findsOneWidget);
    expect(http.requestsTo(_post), isEmpty);

    await _pickToday(tester, 'vacation-from');
    await _pickToday(tester, 'vacation-to');
    await tester.enterText(
      find.byKey(const ValueKey('vacation-note')),
      'Wintersport',
    );
    await tapAndSettle(tester, find.byKey(const ValueKey('vacation-save')));

    expect(http.requestsTo(_post).single.body, {
      'starts_on': today,
      'ends_on': today,
      'note': 'Wintersport',
    });
    expect(find.byKey(const ValueKey('vacation-save')), findsNothing);
    expect(find.byKey(const ValueKey('vacation-412')), findsOneWidget);
    expect(find.text('Vakantie toegevoegd'), findsOneWidget);
  });

  testWidgets('422 met veldfout blijft in de sheet', (tester) async {
    final http = await _open(
      tester,
      setup: (http) => http.on(
        _post,
        422,
        AbsencesFixtures.validation('ends_on', 'Einddatum klopt niet.'),
      ),
    );
    await tapAndSettle(tester, find.byKey(const ValueKey('vacations-add')));
    await _pickToday(tester, 'vacation-from');
    await _pickToday(tester, 'vacation-to');
    await tapAndSettle(tester, find.byKey(const ValueKey('vacation-save')));

    expect(http.requestsTo(_post), hasLength(1));
    expect(find.text('Einddatum klopt niet.'), findsOneWidget);
    expect(find.byKey(const ValueKey('vacation-save')), findsOneWidget);
    expect(find.text('Opslaan mislukt'), findsNothing);
  });

  testWidgets('422 zonder veld ("Geen spelersprofiel") in het formulier', (
    tester,
  ) async {
    await _open(
      tester,
      setup: (http) => http.on(_post, 422, AbsencesFixtures.noPlayer),
    );
    await tapAndSettle(tester, find.byKey(const ValueKey('vacations-add')));
    await _pickToday(tester, 'vacation-from');
    await _pickToday(tester, 'vacation-to');
    await tapAndSettle(tester, find.byKey(const ValueKey('vacation-save')));

    expect(find.byKey(const ValueKey('vacation-form-error')), findsOneWidget);
    expect(find.text('Geen spelersprofiel gekoppeld.'), findsOneWidget);
  });

  testWidgets('andere fout → toast, sheet blijft open', (tester) async {
    await _open(
      tester,
      setup: (http) =>
          http.on(_post, 403, {'message': ProfileFixtures.demoMessage}),
    );
    await tapAndSettle(tester, find.byKey(const ValueKey('vacations-add')));
    await _pickToday(tester, 'vacation-from');
    await _pickToday(tester, 'vacation-to');
    await tapAndSettle(tester, find.byKey(const ValueKey('vacation-save')));

    expect(find.text('Opslaan mislukt'), findsOneWidget);
    expect(find.text(ProfileFixtures.demoMessage), findsOneWidget);
    expect(find.byKey(const ValueKey('vacation-save')), findsOneWidget);
  });

  testWidgets('weghalen na bevestiging', (tester) async {
    final vacations = [_wintersport];
    final http = await _open(
      tester,
      setup: (http) {
        http.routes[absencesProfileRoute] = (_) =>
            FakeResponse(200, ProfileFixtures.profile(vacations: vacations));
        http.routes['DELETE /teams/3/vacations/5'] = (_) {
          vacations.clear();
          return const FakeResponse(204);
        };
      },
    );
    await tapAndSettle(tester, find.byKey(const ValueKey('vacation-remove-5')));
    await tapAndSettle(
      tester,
      find.byKey(const ValueKey('vacation-remove-confirm')),
    );

    expect(http.requestsTo('DELETE /teams/3/vacations/5'), hasLength(1));
    expect(find.byKey(const ValueKey('vacation-5')), findsNothing);
    expect(find.byKey(const ValueKey('vacations-empty')), findsOneWidget);
  });

  testWidgets('feature uit: alleen nog weghalen', (tester) async {
    await _open(tester, featureOn: false);
    expect(
      find.byKey(const ValueKey('vacations-feature-off-notice')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('vacation-remove-5')), findsOneWidget);
    expect(find.byKey(const ValueKey('vacations-add')), findsNothing);
  });

  testWidgets('feature uit zonder vakanties: lege staat', (tester) async {
    await _open(
      tester,
      featureOn: false,
      profile: ProfileFixtures.profile(vacations: const []),
    );
    expect(find.byKey(const ValueKey('vacations-feature-off')), findsOneWidget);
  });

  testWidgets('geen spelersprofiel: uitleg', (tester) async {
    await _open(
      tester,
      profile: ProfileFixtures.profile(
        withPlayer: false,
        canUseVacations: false,
        vacations: const [],
      ),
    );
    expect(find.byKey(const ValueKey('vacations-no-player')), findsOneWidget);
    expect(find.byKey(const ValueKey('vacations-add')), findsNothing);
  });
}
