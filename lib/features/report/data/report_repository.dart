import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/report_models.dart';

/// Eén setstand voor `PATCH report/sets` (thuis–uit).
typedef SetScore = ({int home, int away});

/// Eén beurt voor `PUT flag`: precies één van [playerId]/[userId].
typedef FlagShiftInput = ({int? playerId, int? userId, int fromMinute});

/// Een PDF voor `report/scout-preview`.
typedef ScoutFile = ({String name, Uint8List bytes});

/// De verslag-endpoints (vogels3 `docs/api/v1/report.md`).
///
/// - Alles alleen met de lineup-bevoegdheid (`403`); ander team `404`.
/// - `score`/`sets`/`player-stats` geven het complete verslag terug.
/// - `scout-preview` slaat niets op; `422 {message}` als er niets te lezen is.
/// - `PUT flag` geeft het `flag`-veld van het event-detail terug.
class ReportRepository {
  const ReportRepository(this._api);

  final ApiClient _api;

  static String _event(int teamId, int eventId) =>
      '/teams/$teamId/events/$eventId';

  static String _report(int teamId, int eventId) =>
      '${_event(teamId, eventId)}/report';

  Future<MatchReport> fetch(int teamId, int eventId) async =>
      MatchReport.fromJson(_data(await _api.get(_report(teamId, eventId))));

  /// De stand (doelpunten). `null` = leegmaken.
  Future<MatchReport> saveScore(
    int teamId,
    int eventId, {
    required int? home,
    required int? away,
  }) async {
    final body = await _api.patch(
      '${_report(teamId, eventId)}/score',
      data: {'home_score': home, 'away_score': away},
    );
    return MatchReport.fromJson(_data(body));
  }

  /// Vervangt alle setstanden (een `0-0`-set telt als niet gespeeld).
  Future<MatchReport> saveSets(
    int teamId,
    int eventId,
    List<SetScore> sets,
  ) async {
    final body = await _api.patch(
      '${_report(teamId, eventId)}/sets',
      data: {
        'sets': [
          for (final set in sets)
            {'home_points': set.home, 'away_points': set.away},
        ],
      },
    );
    return MatchReport.fromJson(_data(body));
  }

  /// Slaat de regels van het statistiekenblad op. Elke rij: `player_id`
  /// plus de kolommen; spelers die er niet in staan blijven zoals ze waren.
  Future<MatchReport> savePlayerStats(
    int teamId,
    int eventId,
    List<Map<String, int>> rows,
  ) async {
    final body = await _api.patch(
      '${_report(teamId, eventId)}/player-stats',
      data: {'stats': rows},
    );
    return MatchReport.fromJson(_data(body));
  }

  /// Leest een scoutrapport: een PDF ([file], multipart) of geplakte
  /// tabel ([text], JSON). Slaat niets op.
  Future<ScoutPreview> scoutPreview(
    int teamId,
    int eventId, {
    ScoutFile? file,
    String? text,
  }) async {
    final path = '${_report(teamId, eventId)}/scout-preview';
    final Object data;
    if (file != null) {
      data = FormData.fromMap({
        'report': MultipartFile.fromBytes(
          file.bytes,
          filename: file.name,
          contentType: DioMediaType('application', 'pdf'),
        ),
        if (text != null && text.trim().isNotEmpty) 'text': text,
      });
    } else {
      data = {'text': text ?? ''};
    }
    return ScoutPreview.fromJson(_data(await _api.post(path, data: data)));
  }

  /// De vlaggersdienst uit het event-detail, of `null` als deze wedstrijd
  /// (of sport) er geen heeft.
  Future<FlagDutyEdit?> fetchFlag(int teamId, int eventId) async {
    final flag = _data(await _api.get(_event(teamId, eventId)))['flag'];
    return flag is Map<String, dynamic> ? FlagDutyEdit.fromJson(flag) : null;
  }

  /// Vervangt de vlaggersdienst. Elke beurt precies één van `player_id` /
  /// `user_id` plus de minuut waarop die persoon het overneemt.
  Future<FlagDutyEdit> saveFlag(
    int teamId,
    int eventId,
    List<FlagShiftInput> shifts,
  ) async {
    final body = await _api.put(
      '${_event(teamId, eventId)}/flag',
      data: {
        'shifts': [
          for (final shift in shifts)
            {
              'player_id': shift.playerId,
              'user_id': shift.userId,
              'from_minute': shift.fromMinute,
            },
        ],
      },
    );
    return FlagDutyEdit.fromJson(_data(body));
  }

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final reportRepositoryProvider = Provider<ReportRepository>(
  (ref) => ReportRepository(ref.watch(apiClientProvider)),
);
