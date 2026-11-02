import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/shell.dart';

// Een beslist gelijkspel: "n.v." of "4–3 n.s." achter de uitslag
// (`live.result_suffix`), zoals de agenda in de PWA.

Map<String, dynamic> _decided(int id, String? suffix) {
  final event = ApiFixtures.agendaEvent(id: id, year: 2025);
  return {
    ...event,
    'home_score': 2,
    'away_score': 2,
    'live': {
      ...event['live'] as Map<String, dynamic>,
      'ended_at': '2025-10-11T16:20:51+02:00',
      'result_suffix': suffix,
    },
  };
}

void main() {
  testWidgets('afgelopen uitslag met de toevoeging erachter', (tester) async {
    await pumpSignedIn(
      tester,
      teams: [ApiFixtures.membership()],
      agenda: ApiFixtures.agendaResponse(
        past: [_decided(300, '4–3 n.s.'), _decided(301, null)],
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Verleden'));
    await tester.pumpAndSettle();

    expect(find.text('2 - 2 4–3 n.s.'), findsOneWidget);
    expect(find.text('2 - 2'), findsOneWidget);
  });
}
