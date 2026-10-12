import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/fines_models.dart';

/// Wie een nieuwe boete krijgt (`POST teams/{team}/fines`): het hele team,
/// of een selectie spelers en/of pure stafleden.
class FineTargets {
  const FineTargets({
    this.playerIds = const [],
    this.userIds = const [],
    this.everyone = false,
  });

  const FineTargets.everyone() : this(everyone: true);

  final List<int> playerIds;
  final List<int> userIds;
  final bool everyone;

  bool get isEmpty => !everyone && playerIds.isEmpty && userIds.isEmpty;

  /// De vorm die de API verwacht: één persoon als `player_id`/`user_id`,
  /// meerdere als lijsten, of `everyone: true`.
  Map<String, Object> toJson() {
    if (everyone) return {'everyone': true};
    if (playerIds.length == 1 && userIds.isEmpty) {
      return {'player_id': playerIds.single};
    }
    if (userIds.length == 1 && playerIds.isEmpty) {
      return {'user_id': userIds.single};
    }
    return {
      if (playerIds.isNotEmpty) 'player_ids': playerIds,
      if (userIds.isNotEmpty) 'user_ids': userIds,
    };
  }
}

/// Een boeking voor `POST/PATCH teams/{team}/fine-pot` (alle velden verplicht).
class PotEntryDraft {
  const PotEntryDraft({
    required this.amountCents,
    required this.description,
    required this.occurredOn,
  });

  /// Positief = erin, negatief = eruit; nooit 0.
  final int amountCents;
  final String description;
  final DateTime occurredOn;

  Map<String, Object> toJson() => {
    'amount_cents': amountCents,
    'description': description,
    'occurred_on': dateOnly(occurredOn),
  };

  /// `YYYY-MM-DD` van de kalenderdag van [date].
  static String dateOnly(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}

/// De boetepot-endpoints (vogels3 `docs/api/v1/fines.md`). Bedragen in
/// centen; fouten komen als [ApiException] (403 geen penningmeester, 404
/// feature uit of van een ander team, 422 validatie of selectieregel — die
/// laatste met alleen `message`).
class FinesRepository {
  const FinesRepository(this._api);

  final ApiClient _api;

  /// Het overzicht van periode [periodId] (standaard de lopende).
  Future<FinesOverview> fetchOverview(int teamId, {int? periodId}) async {
    final body = await _api.get(
      '/teams/$teamId/fines',
      query: periodId == null ? null : {'period': periodId},
    );
    return FinesOverview.fromJson(_data(body));
  }

  /// De boetes van speler [playerId] in periode [periodId].
  Future<PersonFines> fetchPlayer(
    int teamId,
    int playerId, {
    int? periodId,
  }) async {
    final body = await _api.get(
      '/teams/$teamId/fines/players/$playerId',
      query: periodId == null ? null : {'period': periodId},
    );
    return PersonFines.fromJson(_data(body));
  }

  /// De boetes van puur staflid [userId] in periode [periodId].
  Future<PersonFines> fetchStaff(
    int teamId,
    int userId, {
    int? periodId,
  }) async {
    final body = await _api.get(
      '/teams/$teamId/fines/staff/$userId',
      query: periodId == null ? null : {'period': periodId},
    );
    return PersonFines.fromJson(_data(body));
  }

  /// Een boete uitdelen (altijd in de lopende periode). Geeft de aangemaakte
  /// boetes terug.
  Future<List<Fine>> recordFines(
    int teamId, {
    required FineTargets targets,
    required int typeId,
    int? amountCents,
    String? description,
    int? eventId,
  }) async {
    final body = await _api.post(
      '/teams/$teamId/fines',
      data: {
        ...targets.toJson(),
        'type': typeId,
        'amount_cents': ?amountCents,
        if (description != null && description.isNotEmpty)
          'description': description,
        'event_id': ?eventId,
      },
    );
    final data = _data(body);
    final fines = data['fines'];
    if (fines is! List) return const [];
    return [
      for (final fine in fines)
        if (fine is Map<String, dynamic>) Fine.fromJson(fine),
    ];
  }

  /// Een boete bijwerken. [clearDescription] stuurt `description: null`.
  Future<Fine> updateFine(
    int teamId,
    int fineId, {
    int? amountCents,
    String? description,
    bool clearDescription = false,
    FineStatus? status,
  }) async {
    final body = await _api.patch(
      '/teams/$teamId/fines/$fineId',
      data: {
        'amount_cents': ?amountCents,
        if (clearDescription)
          'description': null
        else
          'description': ?description,
        'status': ?(status == FineStatus.unknown ? null : status?.name),
      },
    );
    return Fine.fromJson(_data(body));
  }

  Future<void> deleteFine(int teamId, int fineId) =>
      _api.delete('/teams/$teamId/fines/$fineId');

  /// Met de hand geld in of uit de pot.
  Future<PotLine> createPotEntry(int teamId, PotEntryDraft draft) async {
    final body = await _api.post(
      '/teams/$teamId/fine-pot',
      data: draft.toJson(),
    );
    return PotLine.fromJson(_data(body));
  }

  /// Een boeking volledig vervangen.
  Future<PotLine> updatePotEntry(
    int teamId,
    int entryId,
    PotEntryDraft draft,
  ) async {
    final body = await _api.patch(
      '/teams/$teamId/fine-pot/$entryId',
      data: draft.toJson(),
    );
    return PotLine.fromJson(_data(body));
  }

  Future<void> deletePotEntry(int teamId, int entryId) =>
      _api.delete('/teams/$teamId/fine-pot/$entryId');

  // ── Beheer (penningmeester) ──────────────────────────────────────────

  /// Een nieuwe periode beginnen; de lopende wordt afgesloten.
  Future<FinePeriod> createPeriod(int teamId, {required String name}) async {
    final body = await _api.post(
      '/teams/$teamId/fine-periods',
      data: {'name': name},
    );
    return FinePeriod.fromJson(_data(body));
  }

  /// Alleen de naam van periode [periodId] (mag ook als hij is afgesloten).
  Future<FinePeriod> renamePeriod(
    int teamId,
    int periodId, {
    required String name,
  }) async {
    final body = await _api.patch(
      '/teams/$teamId/fine-periods/$periodId',
      data: {'name': name},
    );
    return FinePeriod.fromJson(_data(body));
  }

  /// Periode [periodId] afsluiten. Geeft de afgesloten periode en de
  /// lopende periode daarna (`meta.active_period`) terug.
  Future<({FinePeriod closed, FinePeriod? active})> closePeriod(
    int teamId,
    int periodId,
  ) async {
    final body = await _api.post('/teams/$teamId/fine-periods/$periodId/close');
    final meta = body['meta'];
    final active = meta is Map<String, dynamic> ? meta['active_period'] : null;
    return (
      closed: FinePeriod.fromJson(_data(body)),
      active: active is Map<String, dynamic>
          ? FinePeriod.fromJson(active)
          : null,
    );
  }

  /// De standaardbedragen per soort in één keer ([amounts]: id → centen).
  /// Geeft alle kiesbare soorten terug.
  Future<List<FineType>> updateFineSettings(
    int teamId,
    Map<int, int> amounts,
  ) async {
    final body = await _api.patch(
      '/teams/$teamId/fine-settings',
      data: {
        'amounts': {
          for (final entry in amounts.entries) '${entry.key}': entry.value,
        },
      },
    );
    final data = body['data'];
    if (data is! List) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return [
      for (final type in data)
        if (type is Map<String, dynamic>) FineType.fromJson(type),
    ];
  }

  /// Een eigen (handmatige) boetesoort erbij.
  Future<FineType> createFineType(
    int teamId, {
    required String label,
    required int amountCents,
  }) async {
    final body = await _api.post(
      '/teams/$teamId/fine-types',
      data: {'label': label, 'amount_cents': amountCents},
    );
    return FineType.fromJson(_data(body));
  }

  /// Een soort bijwerken; alleen meegegeven velden gaan mee. [active]
  /// `false` zet hem uit (archiveert), `true` weer aan.
  Future<FineType> updateFineType(
    int teamId,
    int typeId, {
    String? label,
    int? amountCents,
    bool? active,
  }) async {
    final body = await _api.patch(
      '/teams/$teamId/fine-types/$typeId',
      data: {'label': ?label, 'amount_cents': ?amountCents, 'active': ?active},
    );
    return FineType.fromJson(_data(body));
  }

  /// Een handmatige soort weghalen. `true` als hij gearchiveerd is (er
  /// stonden al boetes onder), `false` als hij echt weg is.
  Future<bool> deleteFineType(int teamId, int typeId) async {
    final body = await _api.delete('/teams/$teamId/fine-types/$typeId');
    final data = body['data'];
    return data is Map<String, dynamic> && data['archived'] == true;
  }

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final finesRepositoryProvider = Provider<FinesRepository>(
  (ref) => FinesRepository(ref.watch(apiClientProvider)),
);
