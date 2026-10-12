import 'dart:typed_data';

import 'package:assistje/app.dart';
import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/auth/device_name.dart';
import 'package:assistje/core/auth/token_store.dart';
import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/core/theme/theme_providers.dart';
import 'package:assistje/features/stats/application/stats_csv_sharer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/pump.dart';
import 'stats_export_support.dart';
import 'stats_fixtures.dart';

class _FakeSharer implements StatsCsvSharer {
  final List<(Uint8List, String, Rect?)> shared = [];

  @override
  Future<void> share(Uint8List bytes, String filename, {Rect? origin}) async {
    shared.add((bytes, filename, origin));
  }
}

const _exportButton = ValueKey('stats-export');

/// Als `pumpSignedIn`, maar met een nep-deelmenu en een adapter die de CSV
/// binair kan beantwoorden.
Future<(FakeHttpAdapter, CsvAwareAdapter, _FakeSharer)> _open(
  WidgetTester tester, {
  String role = 'player',
  void Function(FakeHttpAdapter http, CsvAwareAdapter csv)? setup,
}) async {
  tester.view
    ..physicalSize = const Size(1800, 4200)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final http = FakeHttpAdapter();
  final csv = CsvAwareAdapter(http);
  final sharer = _FakeSharer();
  final membership = {
    ...ApiFixtures.membership(role: role, features: {'stats': true}),
    'sport': StatsFixtures.footballSport(),
  };
  http
    ..on('GET /me', 200, ApiFixtures.meResponse(teams: [membership]))
    ..on('GET /teams/3/agenda', 200, ApiFixtures.emptyAgendaResponse())
    ..on('GET /teams/3/stats', 200, StatsFixtures.response());
  setup?.call(http, csv);

  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      tokenStoreProvider.overrideWithValue(InMemoryTokenStore('12|abc')),
      apiHttpAdapterProvider.overrideWithValue(csv),
      deviceNameProvider.overrideWithValue('iPhone'),
      statsCsvSharerProvider.overrideWithValue(sharer),
    ],
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const AssistjeApp()),
  );
  await pumpUntilFound(tester, find.byKey(const Key('glass-tab-bar')));
  container.read(routerProvider).go(AppRoutes.stats);
  await pumpUntilFound(tester, find.byKey(const ValueKey('stats-screen')));
  await tester.pumpAndSettle();
  return (http, csv, sharer);
}

void main() {
  for (final role in ['player', 'trainer', 'spectator']) {
    testWidgets('$role ziet "Exporteer" (elk teamlid, zoals de API)', (
      tester,
    ) async {
      await _open(tester, role: role);

      expect(find.byKey(_exportButton), findsOneWidget);
      expect(
        find.descendant(
          of: find.byKey(_exportButton),
          matching: find.text('Exporteer'),
        ),
        findsOneWidget,
      );
    });
  }

  testWidgets('tik: CSV downloaden en als bestand naar het deelmenu', (
    tester,
  ) async {
    final (_, csv, sharer) = await _open(
      tester,
      setup: (_, csv) => csv.csv[3] = CsvResponse(
        200,
        statsCsvBytes,
        disposition: 'attachment; filename=stats-2026-10-11.csv',
      ),
    );

    await tester.tap(find.byKey(_exportButton));
    await tester.pumpAndSettle();

    final request = csv.exports.single;
    expect(request.uri.path, '/api/v1/teams/3/stats/export');
    expect(request.headers['Authorization'], 'Bearer 12|abc');
    final (bytes, name, origin) = sharer.shared.single;
    expect(bytes, statsCsvBytes);
    expect(name, 'stats-2026-10-11.csv');
    expect(origin, isNotNull);
    expect(find.text('Exporteren mislukt'), findsNothing);
  });

  testWidgets('het getoonde venster gaat mee als ?window=', (tester) async {
    final (http, csv, sharer) = await _open(
      tester,
      setup: (http, csv) => csv.csv[3] = CsvResponse(200, statsCsvBytes),
    );
    http.on('GET /teams/3/stats', 200, StatsFixtures.response({'window': '5'}));

    await tester.tap(find.text('Laatste 5'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(_exportButton));
    await tester.pumpAndSettle();

    expect(csv.exports.single.uri.queryParameters['window'], '5');
    expect(sharer.shared.single.$2, startsWith('stats-'));
  });

  testWidgets('fout (403): fouttoast, geen deelmenu', (tester) async {
    final (_, _, sharer) = await _open(
      tester,
      setup: (http, _) => http.on('GET /teams/3/stats/export', 403, {
        'message': 'Geen toegang tot dit team.',
      }),
    );

    await tester.tap(find.byKey(_exportButton));
    await tester.pumpAndSettle();

    expect(sharer.shared, isEmpty);
    expect(find.text('Exporteren mislukt'), findsOneWidget);
    expect(find.text('Geen toegang tot dit team.'), findsOneWidget);
  });
}
