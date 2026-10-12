import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/duties_models.dart';

/// Eén rij in `dates[]` bij beurten inplannen: een [date] (`YYYY-MM-DD`,
/// losse dienst) of een [eventId] (wedstrijddienst), met optionele tijden en
/// notitie.
class DutyDateRow {
  const DutyDateRow({
    this.date,
    this.eventId,
    this.startsAt,
    this.endsAt,
    this.notes,
  });

  final String? date;
  final int? eventId;
  final String? startsAt;
  final String? endsAt;
  final String? notes;

  Map<String, Object?> toJson() {
    return {
      if (eventId != null) 'event_id': eventId else 'date': date,
      'starts_at': ?_nonBlank(startsAt),
      'ends_at': ?_nonBlank(endsAt),
      'notes': ?_nonBlank(notes),
    };
  }

  static String? _nonBlank(String? value) {
    final text = value?.trim();
    return text == null || text.isEmpty ? null : text;
  }
}

/// `POST duties/assignments`: [mode] `individual` (met [memberKey]),
/// `single` (met [groupId]) of `rotate` (groepen om de beurt).
class DutyAssignmentDraft {
  const DutyAssignmentDraft({
    required this.dutyTypeId,
    required this.mode,
    required this.dates,
    this.memberKey,
    this.groupId,
  });

  final int dutyTypeId;
  final String mode;
  final List<DutyDateRow> dates;
  final String? memberKey;
  final int? groupId;

  Map<String, Object?> toJson() => {
    'duty_type_id': dutyTypeId,
    'mode': mode,
    if (mode == 'individual') 'member_key': memberKey,
    if (mode == 'single') 'duty_group_id': groupId,
    'dates': [for (final row in dates) row.toJson()],
  };
}

/// De diensten-endpoints (vogels3 `docs/api/v1/duties.md`). Alles alleen
/// voor de trainer (anders `403`); feature uit, onbekend type of iets van
/// een ander team `404`; veldfouten `422`.
class DutiesRepository {
  const DutiesRepository(this._api);

  final ApiClient _api;

  String _base(int teamId) => '/teams/$teamId/duties';

  /// Het overzicht van type [type] (slug), anders het eerste type.
  Future<DutiesOverview> fetch(int teamId, {String? type}) async {
    final body = await _api.get(
      _base(teamId),
      query: type == null ? null : {'type': type},
    );
    return DutiesOverview.fromJson(_data(body));
  }

  Future<DutyGroup> createGroup(
    int teamId, {
    required int dutyTypeId,
    required String name,
    List<String> memberKeys = const [],
  }) async {
    final body = await _api.post(
      '${_base(teamId)}/groups',
      data: {
        'duty_type_id': dutyTypeId,
        'name': name.trim(),
        'member_keys': memberKeys,
      },
    );
    return DutyGroup.fromJson(_data(body));
  }

  /// Naam en leden (vervangt de leden).
  Future<DutyGroup> updateGroup(
    int teamId,
    int groupId, {
    required String name,
    List<String> memberKeys = const [],
  }) async {
    final body = await _api.patch(
      '${_base(teamId)}/groups/$groupId',
      data: {'name': name.trim(), 'member_keys': memberKeys},
    );
    return DutyGroup.fromJson(_data(body));
  }

  Future<void> deleteGroup(int teamId, int groupId) =>
      _api.delete('${_base(teamId)}/groups/$groupId');

  /// Nieuwe volgorde: [ids] in de gewenste volgorde (`204`).
  Future<void> reorderGroups(int teamId, List<int> ids) =>
      _api.post('${_base(teamId)}/groups/reorder', data: {'ids': ids});

  /// Beurten inplannen. Geeft álle beurten van het type terug.
  Future<List<DutyAssignment>> storeAssignments(
    int teamId,
    DutyAssignmentDraft draft,
  ) async {
    final body = await _api.post(
      '${_base(teamId)}/assignments',
      data: draft.toJson(),
    );
    return _assignments(_data(body));
  }

  /// Een wedstrijddienst over de komende wedstrijden verdelen. Geeft de
  /// melding van de server terug.
  Future<String?> autoAssign(int teamId, int dutyTypeId) async {
    final body = await _api.post(
      '${_base(teamId)}/auto-assign',
      data: {'duty_type_id': dutyTypeId},
    );
    final message = _data(body)['message'];
    return message is String ? message : null;
  }

  /// Eén beurt bewerken; alleen de velden in [changes] veranderen.
  Future<DutyAssignment> updateAssignment(
    int teamId,
    int assignmentId,
    Map<String, Object?> changes,
  ) async {
    final body = await _api.patch(
      '${_base(teamId)}/assignments/$assignmentId',
      data: changes,
    );
    return DutyAssignment.fromJson(_data(body));
  }

  /// Het vinkje "gedaan" aan of weer uit.
  Future<DutyAssignment> toggleDone(int teamId, int assignmentId) async {
    final body = await _api.post(
      '${_base(teamId)}/assignments/$assignmentId/done',
    );
    return DutyAssignment.fromJson(_data(body));
  }

  Future<void> deleteAssignment(int teamId, int assignmentId) =>
      _api.delete('${_base(teamId)}/assignments/$assignmentId');

  /// De dienst van één wedstrijd regelen (`PATCH events/{event}/duties/{type}`).
  /// Personen gaan op [memberKey], een groepsdienst op [groupId]; beide
  /// `null` maakt de dienst vrij. Bij `multi` zet elke aanroep één persoon
  /// aan óf uit.
  Future<List<DutyAssignment>> assignEventDuty(
    int teamId,
    int eventId,
    int dutyTypeId, {
    required bool group,
    String? memberKey,
    int? groupId,
  }) async {
    final body = await _api.patch(
      '/teams/$teamId/events/$eventId/duties/$dutyTypeId',
      data: group ? {'duty_group_id': groupId} : {'member_key': memberKey},
    );
    return _assignments(_data(body));
  }

  static List<DutyAssignment> _assignments(Map<String, dynamic> data) => [
    for (final row in (data['assignments'] as List<dynamic>? ?? const []))
      if (row is Map<String, dynamic>) DutyAssignment.fromJson(row),
  ];

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final dutiesRepositoryProvider = Provider<DutiesRepository>(
  (ref) => DutiesRepository(ref.watch(apiClientProvider)),
);
