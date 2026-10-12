import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../../event/data/models/event_detail_models.dart';
import 'models/schedule_import_models.dart';
import 'models/schedule_models.dart';

/// Agenda beheren door de trainer (vogels3 `docs/api/v1/schedule.md`):
/// opties, aanmaken (ook een wekelijkse reeks), wijzigen (ook "alle
/// volgende"), verwijderen en (de)afgelasten. Alleen de trainer (anders
/// `403`), demo-teams mogen niet schrijven (`403`), veldfouten `422`.
///
/// Aanmaken, wijzigen en (de)afgelasten geven het event terug in de vorm van
/// `GET events/{event}`; dat wordt zowel een [EventDetail] als een
/// [ScheduleEvent].
class ScheduleRepository {
  const ScheduleRepository(this._api);

  final ApiClient _api;

  String _base(int teamId) => '/teams/$teamId/schedule';

  /// `GET …/schedule/options`.
  Future<ScheduleOptions> options(int teamId) async => ScheduleOptions.fromJson(
    _data(await _api.get('${_base(teamId)}/options')),
  );

  /// `GET teams/{team}/events/{event}` als formuliervelden (bewerken, en of
  /// het event met de hand afgelast mag worden).
  Future<ScheduleEvent> fetchEvent(int teamId, int eventId) async =>
      ScheduleEvent.fromJson(
        _data(await _api.get('/teams/$teamId/events/$eventId')),
      );

  /// `POST …/schedule`: één event, of een reeks trainingen (`recur_until`).
  Future<ScheduleWriteResult> create(int teamId, ScheduleDraft draft) async =>
      _result(
        await _api.post(_base(teamId), data: draft.toPayload(update: false)),
      );

  /// `PATCH …/schedule/{event}`: het hele formulier.
  Future<ScheduleWriteResult> update(
    int teamId,
    int eventId,
    ScheduleDraft draft,
  ) async => _result(
    await _api.patch(
      '${_base(teamId)}/$eventId',
      data: draft.toPayload(update: true),
    ),
  );

  /// `DELETE …/schedule/{event}` (`204`).
  Future<void> delete(int teamId, int eventId) =>
      _api.delete('${_base(teamId)}/$eventId');

  /// `POST …/schedule/{event}/cancel`: afgelasten.
  Future<ScheduleWriteResult> cancel(int teamId, int eventId) async =>
      _result(await _api.post('${_base(teamId)}/$eventId/cancel'));

  /// `DELETE …/schedule/{event}/cancel`: gaat toch door.
  Future<ScheduleWriteResult> uncancel(int teamId, int eventId) async =>
      _result(await _api.delete('${_base(teamId)}/$eventId/cancel'));

  // ── Het programma importeren (`schedule.md` "Het programma importeren") ──

  /// `POST …/schedule/import` (multipart): een `.ics`, `.xlsx`, `.csv` of
  /// `.txt`. Met [dryRun] wordt er alleen geteld. Weigering: `422` op `file`.
  Future<ScheduleImportResult> importFile(
    int teamId,
    ScheduleFile file, {
    bool dryRun = false,
  }) async {
    final body = await _api.post(
      '${_base(teamId)}/import',
      data: FormData.fromMap({
        'file': MultipartFile.fromBytes(
          file.bytes,
          filename: file.name,
          contentType: scheduleFileMediaType(file.name),
        ),
        'dry_run': dryRun ? '1' : '0',
      }),
    );
    return ScheduleImportResult.fromJson(_data(body));
  }

  /// `POST …/schedule/fetch` (`202`): het programma bij de bond laten
  /// ophalen. Weigering: `422` op `schedule`.
  Future<ScheduleActionResult> fetchFromFederation(int teamId) async =>
      ScheduleActionResult.fromJson(
        _data(await _api.post('${_base(teamId)}/fetch')),
      );

  /// `POST …/schedule/request` (`201`): "Doe dat voor mij". Staat er al een
  /// verzoek open: `409` ([ConflictException]).
  Future<ScheduleActionResult> requestByHand(int teamId) async =>
      ScheduleActionResult.fromJson(
        _data(await _api.post('${_base(teamId)}/request')),
      );

  /// `POST …/schedule/feed`: de agendalink zetten en meteen ophalen.
  /// Weigering: `422` op `schedule_feed_url`.
  Future<ScheduleActionResult> setFeed(int teamId, String url) async =>
      ScheduleActionResult.fromJson(
        _data(
          await _api.post(
            '${_base(teamId)}/feed',
            data: {'schedule_feed_url': url},
          ),
        ),
      );

  static ScheduleWriteResult _result(Map<String, dynamic> body) {
    final data = _data(body);
    final meta = body['meta'];
    final m = meta is Map ? meta : const <String, Object?>{};
    return ScheduleWriteResult(
      event: EventDetail.fromJson(data),
      schedule: ScheduleEvent.fromJson(data),
      createdIds: _ids(m['created_ids']),
      adoptedIds: _ids(m['adopted_ids']),
      followingUpdated: switch (m['following_updated']) {
        final num n => n.toInt(),
        _ => 0,
      },
    );
  }

  static List<int> _ids(Object? raw) => raw is List
      ? [
          for (final id in raw)
            if (id is num) id.toInt(),
        ]
      : const [];

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

/// Het mediatype bij de extensie van een programmabestand.
DioMediaType scheduleFileMediaType(String name) {
  final lower = name.toLowerCase();
  if (lower.endsWith('.ics')) return DioMediaType('text', 'calendar');
  if (lower.endsWith('.csv')) return DioMediaType('text', 'csv');
  if (lower.endsWith('.xlsx')) {
    return DioMediaType(
      'application',
      'vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    );
  }
  return DioMediaType('text', 'plain');
}

final scheduleRepositoryProvider = Provider<ScheduleRepository>(
  (ref) => ScheduleRepository(ref.watch(apiClientProvider)),
);
