// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savings_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SavingsPotSummary _$SavingsPotSummaryFromJson(Map<String, dynamic> json) =>
    _SavingsPotSummary(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      amountCents: (json['amount_cents'] as num?)?.toInt() ?? 0,
      goalCents: (json['goal_cents'] as num?)?.toInt(),
      months: (json['months'] as num?)?.toInt() ?? 1,
      memberCount: (json['member_count'] as num?)?.toInt() ?? 0,
      savedCents: (json['saved_cents'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SavingsPotSummaryToJson(_SavingsPotSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount_cents': instance.amountCents,
      'goal_cents': instance.goalCents,
      'months': instance.months,
      'member_count': instance.memberCount,
      'saved_cents': instance.savedCents,
    };

_SavingsOverview _$SavingsOverviewFromJson(Map<String, dynamic> json) =>
    _SavingsOverview(
      pots:
          (json['pots'] as List<dynamic>?)
              ?.map(
                (e) => SavingsPotSummary.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <SavingsPotSummary>[],
      canManage: json['can_manage'] as bool? ?? false,
    );

Map<String, dynamic> _$SavingsOverviewToJson(_SavingsOverview instance) =>
    <String, dynamic>{
      'pots': instance.pots.map((e) => e.toJson()).toList(),
      'can_manage': instance.canManage,
    };

_SavingsEvent _$SavingsEventFromJson(Map<String, dynamic> json) =>
    _SavingsEvent(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      startsAt: json['starts_at'] == null
          ? null
          : DateTime.parse(json['starts_at'] as String),
      cancelled: json['cancelled'] as bool? ?? false,
    );

Map<String, dynamic> _$SavingsEventToJson(_SavingsEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'starts_at': instance.startsAt?.toIso8601String(),
      'cancelled': instance.cancelled,
    };

_SavingsPot _$SavingsPotFromJson(Map<String, dynamic> json) => _SavingsPot(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  amountCents: (json['amount_cents'] as num?)?.toInt() ?? 0,
  goalCents: (json['goal_cents'] as num?)?.toInt(),
  months: (json['months'] as num?)?.toInt() ?? 1,
  startsOn: json['starts_on'] == null
      ? null
      : DateTime.parse(json['starts_on'] as String),
  scope:
      $enumDecodeNullable(
        _$SavingsScopeEnumMap,
        json['scope'],
        unknownValue: SavingsScope.unknown,
      ) ??
      SavingsScope.all,
  oneOff: json['one_off'] as bool? ?? false,
  event: json['event'] == null
      ? null
      : SavingsEvent.fromJson(json['event'] as Map<String, dynamic>),
  actualCostCents: (json['actual_cost_cents'] as num?)?.toInt(),
  settledOn: json['settled_on'] == null
      ? null
      : DateTime.parse(json['settled_on'] as String),
);

Map<String, dynamic> _$SavingsPotToJson(_SavingsPot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount_cents': instance.amountCents,
      'goal_cents': instance.goalCents,
      'months': instance.months,
      'starts_on': instance.startsOn?.toIso8601String(),
      'scope': _$SavingsScopeEnumMap[instance.scope]!,
      'one_off': instance.oneOff,
      'event': instance.event?.toJson(),
      'actual_cost_cents': instance.actualCostCents,
      'settled_on': instance.settledOn?.toIso8601String(),
    };

const _$SavingsScopeEnumMap = {
  SavingsScope.all: 'all',
  SavingsScope.allStaff: 'all_staff',
  SavingsScope.custom: 'custom',
  SavingsScope.event: 'event',
  SavingsScope.unknown: 'unknown',
};

_SavingsParticipant _$SavingsParticipantFromJson(Map<String, dynamic> json) =>
    _SavingsParticipant(
      key: json['key'] as String,
      name: json['name'] as String? ?? '',
      kind:
          $enumDecodeNullable(
            _$SavingsParticipantKindEnumMap,
            json['kind'],
            unknownValue: SavingsParticipantKind.unknown,
          ) ??
          SavingsParticipantKind.player,
      shirtNumber: (json['shirt_number'] as num?)?.toInt(),
      refund: json['refund'] as bool? ?? false,
      refundReason: $enumDecodeNullable(
        _$SavingsRefundReasonEnumMap,
        json['refund_reason'],
        unknownValue: SavingsRefundReason.unknown,
      ),
      refunded: json['refunded'] as bool? ?? false,
    );

Map<String, dynamic> _$SavingsParticipantToJson(_SavingsParticipant instance) =>
    <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'kind': _$SavingsParticipantKindEnumMap[instance.kind]!,
      'shirt_number': instance.shirtNumber,
      'refund': instance.refund,
      'refund_reason': _$SavingsRefundReasonEnumMap[instance.refundReason],
      'refunded': instance.refunded,
    };

const _$SavingsParticipantKindEnumMap = {
  SavingsParticipantKind.player: 'player',
  SavingsParticipantKind.staff: 'staff',
  SavingsParticipantKind.unknown: 'unknown',
};

const _$SavingsRefundReasonEnumMap = {
  SavingsRefundReason.absent: 'absent',
  SavingsRefundReason.left: 'left',
  SavingsRefundReason.cancelled: 'cancelled',
  SavingsRefundReason.unknown: 'unknown',
};

_SavingsPayment _$SavingsPaymentFromJson(Map<String, dynamic> json) =>
    _SavingsPayment(
      key: json['key'] as String,
      ym: json['ym'] as String,
      cents: (json['cents'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SavingsPaymentToJson(_SavingsPayment instance) =>
    <String, dynamic>{
      'key': instance.key,
      'ym': instance.ym,
      'cents': instance.cents,
    };

_SavingsPotDetail _$SavingsPotDetailFromJson(
  Map<String, dynamic> json,
) => _SavingsPotDetail(
  pot: SavingsPot.fromJson(json['pot'] as Map<String, dynamic>),
  finesEnabled: json['fines_enabled'] as bool? ?? false,
  periods:
      (json['periods'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  participants:
      (json['participants'] as List<dynamic>?)
          ?.map((e) => SavingsParticipant.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SavingsParticipant>[],
  payments:
      (json['payments'] as List<dynamic>?)
          ?.map((e) => SavingsPayment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SavingsPayment>[],
  canManage: json['can_manage'] as bool? ?? false,
);

Map<String, dynamic> _$SavingsPotDetailToJson(_SavingsPotDetail instance) =>
    <String, dynamic>{
      'pot': instance.pot.toJson(),
      'fines_enabled': instance.finesEnabled,
      'periods': instance.periods,
      'participants': instance.participants.map((e) => e.toJson()).toList(),
      'payments': instance.payments.map((e) => e.toJson()).toList(),
      'can_manage': instance.canManage,
    };

_SavingsPlayerOption _$SavingsPlayerOptionFromJson(Map<String, dynamic> json) =>
    _SavingsPlayerOption(
      key: json['key'] as String,
      name: json['name'] as String? ?? '',
      shirtNumber: (json['shirt_number'] as num?)?.toInt(),
      isGuest: json['is_guest'] as bool? ?? false,
    );

Map<String, dynamic> _$SavingsPlayerOptionToJson(
  _SavingsPlayerOption instance,
) => <String, dynamic>{
  'key': instance.key,
  'name': instance.name,
  'shirt_number': instance.shirtNumber,
  'is_guest': instance.isGuest,
};

_SavingsStaffOption _$SavingsStaffOptionFromJson(Map<String, dynamic> json) =>
    _SavingsStaffOption(
      key: json['key'] as String,
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$SavingsStaffOptionToJson(_SavingsStaffOption instance) =>
    <String, dynamic>{'key': instance.key, 'name': instance.name};

_SavingsPeople _$SavingsPeopleFromJson(
  Map<String, dynamic> json,
) => _SavingsPeople(
  players:
      (json['players'] as List<dynamic>?)
          ?.map((e) => SavingsPlayerOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SavingsPlayerOption>[],
  staff:
      (json['staff'] as List<dynamic>?)
          ?.map((e) => SavingsStaffOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SavingsStaffOption>[],
);

Map<String, dynamic> _$SavingsPeopleToJson(_SavingsPeople instance) =>
    <String, dynamic>{
      'players': instance.players.map((e) => e.toJson()).toList(),
      'staff': instance.staff.map((e) => e.toJson()).toList(),
    };

_SavingsFormValues _$SavingsFormValuesFromJson(Map<String, dynamic> json) =>
    _SavingsFormValues(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      scope:
          $enumDecodeNullable(
            _$SavingsScopeEnumMap,
            json['scope'],
            unknownValue: SavingsScope.unknown,
          ) ??
          SavingsScope.all,
      includeGuests: json['include_guests'] as bool? ?? false,
      amount: json['amount'] as num? ?? 0,
      goal: json['goal'] as num?,
      startMonth: json['start_month'] as String? ?? '',
      months: (json['months'] as num?)?.toInt() ?? 1,
      members:
          (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      eventId: (json['event_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SavingsFormValuesToJson(_SavingsFormValues instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'scope': _$SavingsScopeEnumMap[instance.scope]!,
      'include_guests': instance.includeGuests,
      'amount': instance.amount,
      'goal': instance.goal,
      'start_month': instance.startMonth,
      'months': instance.months,
      'members': instance.members,
      'event_id': instance.eventId,
    };

_SavingsFormOptions _$SavingsFormOptionsFromJson(Map<String, dynamic> json) =>
    _SavingsFormOptions(
      people: json['people'] == null
          ? const SavingsPeople()
          : SavingsPeople.fromJson(json['people'] as Map<String, dynamic>),
      activities:
          (json['activities'] as List<dynamic>?)
              ?.map((e) => SavingsEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SavingsEvent>[],
      presetEventId: (json['preset_event_id'] as num?)?.toInt(),
      pot: json['pot'] == null
          ? null
          : SavingsFormValues.fromJson(json['pot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SavingsFormOptionsToJson(_SavingsFormOptions instance) =>
    <String, dynamic>{
      'people': instance.people.toJson(),
      'activities': instance.activities.map((e) => e.toJson()).toList(),
      'preset_event_id': instance.presetEventId,
      'pot': instance.pot?.toJson(),
    };

_SavingsToggleResult _$SavingsToggleResultFromJson(Map<String, dynamic> json) =>
    _SavingsToggleResult(
      key: json['key'] as String,
      ym: json['ym'] as String,
      paid: json['paid'] as bool? ?? false,
      cents: (json['cents'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SavingsToggleResultToJson(
  _SavingsToggleResult instance,
) => <String, dynamic>{
  'key': instance.key,
  'ym': instance.ym,
  'paid': instance.paid,
  'cents': instance.cents,
};

_SavingsRefundResult _$SavingsRefundResultFromJson(Map<String, dynamic> json) =>
    _SavingsRefundResult(
      key: json['key'] as String,
      refunded: json['refunded'] as bool? ?? false,
    );

Map<String, dynamic> _$SavingsRefundResultToJson(
  _SavingsRefundResult instance,
) => <String, dynamic>{'key': instance.key, 'refunded': instance.refunded};
