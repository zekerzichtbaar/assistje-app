import 'dart:convert';
import 'dart:typed_data';

import 'package:assistje/app.dart';
import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/auth/device_name.dart';
import 'package:assistje/core/auth/token_store.dart';
import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/core/theme/theme_providers.dart';
import 'package:assistje/features/player_management/data/csv_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/pump.dart';
import '../../helpers/test_app.dart';
import 'multipart_http_adapter.dart';
import 'pm_fixtures.dart';

const _index = 'GET /teams/3/players';
const _import = 'POST /teams/3/players/import';

/// Een kiezer die meteen [file] teruggeeft (of niets).
class _FakePicker implements CsvFilePicker {
  _FakePicker(this.file);

  CsvFile? file;
  int calls = 0;

  @override
  Future<CsvFile?> pickCsv() async {
    calls++;
    return file;
  }
}

final _csv = (
  name: 'spelers.csv',
  bytes: Uint8List.fromList(utf8.encode('naam;positie\nAnna;MF\n')),
);

/// Ingelogd als trainer van team 3 op `/players`, met een nep-kiezer.
Future<MultipartHttpAdapter> _open(
  WidgetTester tester,
  _FakePicker picker,
) async {
  tester.view
    ..physicalSize = const Size(1800, 4200)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final backend = TestBackend(token: '12|abc');
  await backend.init();
  final http = MultipartHttpAdapter()
    ..on(
      'GET /me',
      200,
      ApiFixtures.meResponse(teams: [PmFixtures.trainerMembership()]),
    )
    ..on('GET /teams/3/agenda', 200, ApiFixtures.emptyAgendaResponse())
    ..on(_index, 200, PmFixtures.overview());
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(backend.prefs),
      tokenStoreProvider.overrideWithValue(backend.tokens),
      apiHttpAdapterProvider.overrideWithValue(http),
      deviceNameProvider.overrideWithValue('iPhone'),
      csvFilePickerProvider.overrideWithValue(picker),
    ],
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const AssistjeApp()),
  );
  await pumpUntilFound(tester, find.byKey(const Key('glass-tab-bar')));
  container.read(routerProvider).go(AppRoutes.players);
  await pumpUntilFound(tester, find.byKey(const ValueKey('pm-teamlink-card')));
  await tester.pumpAndSettle();
  return http;
}

Finder _key(String key) => find.byKey(ValueKey(key));

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _openCsvTab(WidgetTester tester) async {
  await _tap(tester, _key('pm-add'));
  await _tap(
    tester,
    find.descendant(of: _key('pm-add-tabs'), matching: find.text('CSV')),
  );
}

void main() {
  testWidgets('CSV importeren: kiezen, uitnodigen, samenvatting, ververst', (
    tester,
  ) async {
    final picker = _FakePicker(_csv);
    final http = await _open(tester, picker);
    http.on(_import, 200, {
      'data': {
        'created': 2,
        'skipped': 1,
        'errors': ['Rij 4: naam ontbreekt'],
        'message':
            '2 speler(s) geïmporteerd, 1 overgeslagen: Rij 4: naam ontbreekt',
      },
    });

    await _openCsvTab(tester);

    expect(_key('pm-csv-form'), findsOneWidget);
    expect(_key('pm-add-name'), findsNothing);
    expect(
      find.text(
        'Upload een CSV met kolommen: naam, email, positie, rugnummer, '
        'geboortedatum.',
      ),
      findsOneWidget,
    );
    expect(find.text('Kies CSV-bestand'), findsOneWidget);

    // Zonder bestand kan er niets verstuurd worden.
    await _tap(tester, _key('pm-csv-submit'));
    expect(http.requestsTo(_import), isEmpty);

    // De uitleg klapt open met het voorbeeld uit de PWA.
    await _tap(tester, _key('pm-csv-help-toggle'));
    expect(_key('pm-csv-help'), findsOneWidget);
    expect(find.text('Vereiste kolommen'), findsOneWidget);
    expect(find.textContaining('Bram Visser,bram@example.nl'), findsOneWidget);

    await _tap(tester, _key('pm-csv-pick'));
    expect(picker.calls, 1);
    expect(find.text('spelers.csv'), findsOneWidget);

    await _tap(tester, _key('pm-csv-invites'));
    final before = http.requestsTo(_index).length;
    await _tap(tester, _key('pm-csv-submit'));

    expect(http.requestsTo(_import), hasLength(1));
    final body = http.multipartBodies.single;
    expect(body, contains('filename="spelers.csv"'));
    expect(body, contains('name="send_invites"\r\n\r\n1'));
    // Het overzicht is opnieuw opgehaald.
    expect(http.requestsTo(_index).length, greaterThan(before));

    expect(_key('pm-csv-result'), findsOneWidget);
    expect(find.text('2 speler(s) geïmporteerd'), findsOneWidget);
    expect(find.text('1 overgeslagen'), findsOneWidget);
    expect(find.text('Rij 4: naam ontbreekt'), findsOneWidget);

    await _tap(tester, _key('pm-csv-done'));
    expect(_key('pm-csv-result'), findsNothing);
    expect(_key('pm-add-tabs'), findsNothing);
  });

  testWidgets('CSV importeren: 422 op file staat in de sheet', (tester) async {
    final picker = _FakePicker(_csv);
    final http = await _open(tester, picker);
    http.on(_import, 422, {
      'message': 'Kolommen ontbreken: positie',
      'errors': {
        'file': ['Kolommen ontbreken: positie'],
      },
    });

    await _openCsvTab(tester);
    await _tap(tester, _key('pm-csv-pick'));
    await _tap(tester, _key('pm-csv-submit'));

    expect(
      http.multipartBodies.single,
      contains('name="send_invites"\r\n\r\n0'),
    );
    expect(_key('pm-csv-error'), findsOneWidget);
    expect(find.text('Kolommen ontbreken: positie'), findsOneWidget);
    expect(_key('pm-csv-result'), findsNothing);
    // Het bestand blijft gekozen: opnieuw proberen kan meteen.
    expect(find.text('spelers.csv'), findsOneWidget);
  });

  testWidgets('CSV: niets gekozen laat het formulier leeg', (tester) async {
    final picker = _FakePicker(null);
    final http = await _open(tester, picker);

    await _openCsvTab(tester);
    await _tap(tester, _key('pm-csv-pick'));

    expect(picker.calls, 1);
    expect(find.text('Kies CSV-bestand'), findsOneWidget);
    await _tap(tester, _key('pm-csv-submit'));
    expect(http.requestsTo(_import), isEmpty);
  });
}
