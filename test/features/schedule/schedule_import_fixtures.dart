import 'dart:convert';
import 'dart:typed_data';

import 'package:assistje/app.dart';
import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/auth/device_name.dart';
import 'package:assistje/core/auth/token_store.dart';
import 'package:assistje/core/theme/theme_providers.dart';
import 'package:assistje/features/schedule/data/models/schedule_import_models.dart';
import 'package:assistje/features/schedule/data/schedule_file_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/test_app.dart';

/// Antwoorden uit `docs/api/v1/schedule.md` "Het programma importeren".
abstract final class ScheduleImportFixtures {
  static const fetchMessage =
      'We halen het programma op. Dat duurt even, ververs zo de agenda.';
  static const requestMessage =
      'Komt goed. Je krijgt bericht zodra alle wedstrijden in de agenda staan.';
  static const conflictMessage =
      'Je verzoek staat al bij ons. Je krijgt bericht zodra de wedstrijden '
      'erin staan.';
  static const feedUrl =
      'https://api.nevobo.nl/export/team/X/dames/1/programma.ics';
  static const feedMessage =
      'Het programma staat in de agenda. Verzette wedstrijden schuiven '
      'vanzelf mee.';
  static const importMessage =
      '12 wedstrijden aangemaakt, 1 overgeslagen. 2 bijgewerkt. 12 dienst(en) '
      'ingedeeld. Rij 7: datum onleesbaar';

  static Map<String, dynamic> importResponse({bool dryRun = false}) => {
    'data': {
      'created': 12,
      'updated': 2,
      'skipped': 1,
      'duties': dryRun ? 0 : 12,
      'dry_run': dryRun,
      'messages': ['Rij 7: datum onleesbaar'],
      'message': importMessage,
    },
  };

  static Map<String, dynamic> fetchResponse() => {
    'data': {'status': 'queued', 'message': fetchMessage},
  };

  static Map<String, dynamic> requestResponse() => {
    'data': {'status': 'requested', 'message': requestMessage},
  };

  static Map<String, dynamic> feedResponse() => {
    'data': {
      'status': 'imported',
      'schedule_feed_url': feedUrl,
      'message': feedMessage,
    },
  };
}

/// Legt multipart-verzoeken ruw vast (de [FakeHttpAdapter] leest alleen
/// JSON). Alle andere verzoeken gaan door naar [fallback].
class RawMultipartAdapter implements HttpClientAdapter {
  RawMultipartAdapter({this.fallback});

  final FakeHttpAdapter? fallback;

  RequestOptions? options;
  String body = '';
  int calls = 0;
  int _status = 200;
  Object? _response;

  void respond(int status, Object? body) {
    _status = status;
    _response = body;
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final contentType = '${options.headers[Headers.contentTypeHeader] ?? ''}';
    final fallback = this.fallback;
    if (fallback != null && !contentType.startsWith('multipart/')) {
      return fallback.fetch(options, requestStream, cancelFuture);
    }
    calls++;
    this.options = options;
    if (requestStream != null) {
      final bytes = await requestStream.expand((c) => c).toList();
      body = latin1.decode(bytes);
    }
    return ResponseBody.fromString(
      _response == null ? '' : jsonEncode(_response),
      _status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// Kiest een vast bestand (of niets) zonder native kiezer.
class FakeScheduleFilePicker implements ScheduleFilePicker {
  FakeScheduleFilePicker([this.file]);

  ScheduleFile? file;
  int picks = 0;

  @override
  Future<ScheduleFile?> pick() async {
    picks++;
    return file;
  }
}

/// Een trainer (standaard) van team 3, met de voetbalbron.
Map<String, dynamic> importTrainer({
  String role = 'trainer',
  bool demo = false,
  Map<String, dynamic>? federation = const {
    'method': 'paste',
    'name': 'voetbal.nl',
    'hint': 'Uit de URL van de programmapagina.',
    'example': 'T429576725',
  },
}) {
  final m = ApiFixtures.membership(role: role);
  return {
    ...m,
    'team': {...m['team'] as Map<String, dynamic>, 'is_demo': demo},
    'sport': {
      ...m['sport'] as Map<String, dynamic>,
      'federation_import': federation,
    },
  };
}

/// Een agenda-antwoord met de trainervelden voor het programma.
Map<String, dynamic> importAgenda({
  bool empty = true,
  bool needsSchedule = false,
  bool canFetch = false,
  String? request,
  Map<String, dynamic>? feed,
}) {
  final base = empty
      ? ApiFixtures.emptyAgendaResponse()
      : ApiFixtures.agendaResponse();
  return {
    ...base,
    'data': {
      ...base['data'] as Map<String, dynamic>,
      'needs_schedule': needsSchedule,
      'can_fetch_schedule': canFetch,
      'schedule_request': request,
      'schedule_feed': feed,
    },
  };
}

/// Start de app ingelogd zoals `pumpSignedIn`, maar met een nep-kiezer en
/// een adapter die multipart-verzoeken ruw vastlegt.
Future<(ProviderContainer, FakeHttpAdapter, RawMultipartAdapter)> pumpImportApp(
  WidgetTester tester, {
  required Map<String, dynamic> membership,
  required Map<String, dynamic> agenda,
  FakeScheduleFilePicker? picker,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  tester.view
    ..physicalSize = const Size(1800, 4200)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final backend = TestBackend(token: '12|abc');
  await backend.init();
  final http = backend.http
    ..on('GET /me', 200, ApiFixtures.meResponse(teams: [membership]))
    ..on('GET /teams/3/agenda', 200, agenda)
    ..on('GET /teams/3/schedule/options', 200, {
      'data': {'team_name': 'Vogels 3'},
    });
  setup?.call(http);
  final raw = RawMultipartAdapter(fallback: http);
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(backend.prefs),
      tokenStoreProvider.overrideWithValue(backend.tokens),
      apiHttpAdapterProvider.overrideWithValue(raw),
      deviceNameProvider.overrideWithValue('iPhone'),
      scheduleFilePickerProvider.overrideWithValue(
        picker ?? FakeScheduleFilePicker(),
      ),
    ],
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const AssistjeApp()),
  );
  await pumpUntilFound(tester, find.byKey(const Key('glass-tab-bar')));
  await tester.pumpAndSettle();
  return (container, http, raw);
}
