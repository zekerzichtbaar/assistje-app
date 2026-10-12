import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/savings_models.dart';

/// Het hele potformulier voor `POST`/`PATCH teams/{team}/savings`. Intern in
/// centen; de API wil (net als het webformulier) euro's.
class SavingsPotDraft {
  const SavingsPotDraft({
    required this.name,
    required this.scope,
    required this.amountCents,
    required this.startMonth,
    required this.months,
    this.includeGuests = false,
    this.goalCents,
    this.members = const [],
    this.eventId,
  });

  final String name;
  final SavingsScope scope;
  final bool includeGuests;
  final int amountCents;
  final int? goalCents;

  /// `YYYY-MM`.
  final String startMonth;

  /// 1 – 60; `1` = eenmalig.
  final int months;

  /// Deelnemer-keys bij [SavingsScope.custom].
  final List<String> members;
  final int? eventId;

  Map<String, Object?> toJson() => {
    'name': name,
    'scope': scope.apiValue,
    'include_guests': includeGuests,
    'amount': centsToEuros(amountCents),
    'goal': goalCents == null ? null : centsToEuros(goalCents!),
    'start_month': startMonth,
    'months': months,
    'members': scope == SavingsScope.custom ? members : const <String>[],
    'event_id': eventId,
  };
}

/// Centen naar het euro-getal dat de API verwacht (`1250` → `12.5`).
num centsToEuros(int cents) => cents % 100 == 0 ? cents ~/ 100 : cents / 100;

/// `YYYY-MM-DD` van de kalenderdag van [date].
String savingsDateOnly(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

/// De spaarpot-endpoints (vogels3 `docs/api/v1/savings.md`). Antwoorden in
/// centen, schrijven in euro's. Fouten komen als [ApiException] (403 geen
/// penningmeester/toeschouwer/demo, 404 feature uit of pot van een ander
/// team, 422 validatie — bij toggle/refund/remind met alleen `message`).
class SavingsRepository {
  const SavingsRepository(this._api);

  final ApiClient _api;

  String _base(int teamId) => '/teams/$teamId/savings';

  /// De lopende potten.
  Future<SavingsOverview> fetchOverview(int teamId) async {
    final body = await _api.get(_base(teamId));
    return SavingsOverview.fromJson(_data(body));
  }

  /// Eén pot met zijn matrix.
  Future<SavingsPotDetail> fetchPot(int teamId, int potId) async {
    final body = await _api.get('${_base(teamId)}/$potId');
    return SavingsPotDetail.fromJson(_data(body));
  }

  /// Keuzelijsten voor een nieuwe pot; [eventId] zet een activiteit voor.
  Future<SavingsFormOptions> fetchCreateOptions(
    int teamId, {
    int? eventId,
  }) async {
    final body = await _api.get(
      '${_base(teamId)}/create',
      query: eventId == null ? null : {'event': eventId},
    );
    return SavingsFormOptions.fromJson(_data(body));
  }

  /// Keuzelijsten plus de huidige waarden van pot [potId].
  Future<SavingsFormOptions> fetchEditOptions(int teamId, int potId) async {
    final body = await _api.get('${_base(teamId)}/$potId/edit');
    return SavingsFormOptions.fromJson(_data(body));
  }

  Future<SavingsPot> createPot(int teamId, SavingsPotDraft draft) async {
    final body = await _api.post(_base(teamId), data: draft.toJson());
    return SavingsPot.fromJson(_data(body));
  }

  Future<SavingsPot> updatePot(
    int teamId,
    int potId,
    SavingsPotDraft draft,
  ) async {
    final body = await _api.patch(
      '${_base(teamId)}/$potId',
      data: draft.toJson(),
    );
    return SavingsPot.fromJson(_data(body));
  }

  /// Archiveren (`204`).
  Future<void> archivePot(int teamId, int potId) =>
      _api.delete('${_base(teamId)}/$potId');

  /// Eén cel aan- of uitzetten.
  Future<SavingsToggleResult> togglePayment(
    int teamId,
    int potId, {
    required String key,
    required String ym,
  }) async {
    final body = await _api.post(
      '${_base(teamId)}/$potId/payments/toggle',
      data: {'key': key, 'period_ym': ym},
    );
    return SavingsToggleResult.fromJson(_data(body));
  }

  /// Terugbetaald zetten (of terugdraaien).
  Future<SavingsRefundResult> refundPayment(
    int teamId,
    int potId, {
    required String key,
    required bool refunded,
  }) async {
    final body = await _api.post(
      '${_base(teamId)}/$potId/payments/refund',
      data: {'key': key, 'refunded': refunded},
    );
    return SavingsRefundResult.fromJson(_data(body));
  }

  /// Herinnering sturen; geeft het aantal ontvangers.
  Future<int> remind(int teamId, int potId) async {
    final body = await _api.post('${_base(teamId)}/$potId/remind');
    final sent = _data(body)['sent'];
    return sent is num ? sent.toInt() : 0;
  }

  /// Afrekenen met de werkelijke kosten.
  Future<SavingsPot> settle(
    int teamId,
    int potId, {
    required int actualCostCents,
    DateTime? settledOn,
  }) async {
    final body = await _api.patch(
      '${_base(teamId)}/$potId/settle',
      data: {
        'actual_cost': centsToEuros(actualCostCents),
        if (settledOn != null) 'settled_on': savingsDateOnly(settledOn),
      },
    );
    return SavingsPot.fromJson(_data(body));
  }

  /// Afrekening ongedaan maken.
  Future<SavingsPot> unsettle(int teamId, int potId) async {
    final body = await _api.delete('${_base(teamId)}/$potId/settle');
    return SavingsPot.fromJson(_data(body));
  }

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final savingsRepositoryProvider = Provider<SavingsRepository>(
  (ref) => SavingsRepository(ref.watch(apiClientProvider)),
);
