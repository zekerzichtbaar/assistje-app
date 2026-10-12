// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fines_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FinePeriod _$FinePeriodFromJson(Map<String, dynamic> json) => _FinePeriod(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  startsOn: json['starts_on'] == null
      ? null
      : DateTime.parse(json['starts_on'] as String),
  endsOn: json['ends_on'] == null
      ? null
      : DateTime.parse(json['ends_on'] as String),
  closedAt: json['closed_at'] == null
      ? null
      : DateTime.parse(json['closed_at'] as String),
);

Map<String, dynamic> _$FinePeriodToJson(_FinePeriod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'starts_on': instance.startsOn?.toIso8601String(),
      'ends_on': instance.endsOn?.toIso8601String(),
      'closed_at': instance.closedAt?.toIso8601String(),
    };

_FineRow _$FineRowFromJson(Map<String, dynamic> json) => _FineRow(
  key: json['key'] as String,
  playerId: (json['player_id'] as num?)?.toInt(),
  userId: (json['user_id'] as num?)?.toInt(),
  name: json['name'] as String? ?? '',
  shirtNumber: (json['shirt_number'] as num?)?.toInt(),
  avatarUrl: json['avatar_url'] as String?,
  isStaff: json['is_staff'] as bool? ?? false,
  counting: json['counting'] as bool? ?? true,
  totalCents: (json['total_cents'] as num?)?.toInt() ?? 0,
  openCents: (json['open_cents'] as num?)?.toInt() ?? 0,
  count: (json['count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$FineRowToJson(_FineRow instance) => <String, dynamic>{
  'key': instance.key,
  'player_id': instance.playerId,
  'user_id': instance.userId,
  'name': instance.name,
  'shirt_number': instance.shirtNumber,
  'avatar_url': instance.avatarUrl,
  'is_staff': instance.isStaff,
  'counting': instance.counting,
  'total_cents': instance.totalCents,
  'open_cents': instance.openCents,
  'count': instance.count,
};

_FineType _$FineTypeFromJson(Map<String, dynamic> json) => _FineType(
  id: (json['id'] as num).toInt(),
  label: json['label'] as String? ?? '',
  defaultCents: (json['default_cents'] as num?)?.toInt() ?? 0,
  trigger: json['trigger'] as String?,
  triggerLabel: json['trigger_label'] as String?,
  archived: json['archived'] as bool? ?? false,
);

Map<String, dynamic> _$FineTypeToJson(_FineType instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'default_cents': instance.defaultCents,
  'trigger': instance.trigger,
  'trigger_label': instance.triggerLabel,
  'archived': instance.archived,
};

_FineTotals _$FineTotalsFromJson(Map<String, dynamic> json) => _FineTotals(
  openCents: (json['open_cents'] as num?)?.toInt() ?? 0,
  allCents: (json['all_cents'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$FineTotalsToJson(_FineTotals instance) =>
    <String, dynamic>{
      'open_cents': instance.openCents,
      'all_cents': instance.allCents,
    };

_PotLine _$PotLineFromJson(Map<String, dynamic> json) => _PotLine(
  key: json['key'] as String,
  kind:
      $enumDecodeNullable(
        _$PotLineKindEnumMap,
        json['kind'],
        unknownValue: PotLineKind.unknown,
      ) ??
      PotLineKind.unknown,
  id: (json['id'] as num?)?.toInt(),
  amountCents: (json['amount_cents'] as num?)?.toInt() ?? 0,
  description: json['description'] as String? ?? '',
  occurredOn: json['occurred_on'] == null
      ? null
      : DateTime.parse(json['occurred_on'] as String),
  createdBy: json['created_by'] as String?,
);

Map<String, dynamic> _$PotLineToJson(_PotLine instance) => <String, dynamic>{
  'key': instance.key,
  'kind': _$PotLineKindEnumMap[instance.kind]!,
  'id': instance.id,
  'amount_cents': instance.amountCents,
  'description': instance.description,
  'occurred_on': instance.occurredOn?.toIso8601String(),
  'created_by': instance.createdBy,
};

const _$PotLineKindEnumMap = {
  PotLineKind.entry: 'entry',
  PotLineKind.fines: 'fines',
  PotLineKind.settlement: 'settlement',
  PotLineKind.unknown: 'unknown',
};

_FinePot _$FinePotFromJson(Map<String, dynamic> json) => _FinePot(
  balanceCents: (json['balance_cents'] as num?)?.toInt() ?? 0,
  openCents: (json['open_cents'] as num?)?.toInt() ?? 0,
  lines:
      (json['lines'] as List<dynamic>?)
          ?.map((e) => PotLine.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PotLine>[],
);

Map<String, dynamic> _$FinePotToJson(_FinePot instance) => <String, dynamic>{
  'balance_cents': instance.balanceCents,
  'open_cents': instance.openCents,
  'lines': instance.lines.map((e) => e.toJson()).toList(),
};

_FinesOverview _$FinesOverviewFromJson(Map<String, dynamic> json) =>
    _FinesOverview(
      period: FinePeriod.fromJson(json['period'] as Map<String, dynamic>),
      periods:
          (json['periods'] as List<dynamic>?)
              ?.map((e) => FinePeriod.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FinePeriod>[],
      rows:
          (json['rows'] as List<dynamic>?)
              ?.map((e) => FineRow.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FineRow>[],
      fineTypes:
          (json['fine_types'] as List<dynamic>?)
              ?.map((e) => FineType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FineType>[],
      guestsInFines: json['guests_in_fines'] as bool? ?? false,
      staffInFines: json['staff_in_fines'] as bool? ?? false,
      totals: json['totals'] == null
          ? const FineTotals()
          : FineTotals.fromJson(json['totals'] as Map<String, dynamic>),
      pot: json['pot'] == null
          ? const FinePot()
          : FinePot.fromJson(json['pot'] as Map<String, dynamic>),
      canManage: json['can_manage'] as bool? ?? false,
    );

Map<String, dynamic> _$FinesOverviewToJson(_FinesOverview instance) =>
    <String, dynamic>{
      'period': instance.period.toJson(),
      'periods': instance.periods.map((e) => e.toJson()).toList(),
      'rows': instance.rows.map((e) => e.toJson()).toList(),
      'fine_types': instance.fineTypes.map((e) => e.toJson()).toList(),
      'guests_in_fines': instance.guestsInFines,
      'staff_in_fines': instance.staffInFines,
      'totals': instance.totals.toJson(),
      'pot': instance.pot.toJson(),
      'can_manage': instance.canManage,
    };

_FineEvent _$FineEventFromJson(Map<String, dynamic> json) => _FineEvent(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String? ?? '',
  startsAt: json['starts_at'] == null
      ? null
      : DateTime.parse(json['starts_at'] as String),
);

Map<String, dynamic> _$FineEventToJson(_FineEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'starts_at': instance.startsAt?.toIso8601String(),
    };

_Fine _$FineFromJson(Map<String, dynamic> json) => _Fine(
  id: (json['id'] as num).toInt(),
  type: (json['type'] as num?)?.toInt(),
  typeLabel: json['type_label'] as String? ?? '',
  amountCents: (json['amount_cents'] as num?)?.toInt() ?? 0,
  description: json['description'] as String?,
  status:
      $enumDecodeNullable(
        _$FineStatusEnumMap,
        json['status'],
        unknownValue: FineStatus.unknown,
      ) ??
      FineStatus.open,
  paidAt: json['paid_at'] == null
      ? null
      : DateTime.parse(json['paid_at'] as String),
  event: json['event'] == null
      ? null
      : FineEvent.fromJson(json['event'] as Map<String, dynamic>),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  createdBy: json['created_by'] as String?,
);

Map<String, dynamic> _$FineToJson(_Fine instance) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'type_label': instance.typeLabel,
  'amount_cents': instance.amountCents,
  'description': instance.description,
  'status': _$FineStatusEnumMap[instance.status]!,
  'paid_at': instance.paidAt?.toIso8601String(),
  'event': instance.event?.toJson(),
  'created_at': instance.createdAt?.toIso8601String(),
  'created_by': instance.createdBy,
};

const _$FineStatusEnumMap = {
  FineStatus.open: 'open',
  FineStatus.paid: 'paid',
  FineStatus.waived: 'waived',
  FineStatus.unknown: 'unknown',
};

_FinePerson _$FinePersonFromJson(Map<String, dynamic> json) => _FinePerson(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  shirtNumber: (json['shirt_number'] as num?)?.toInt(),
  avatarUrl: json['avatar_url'] as String?,
);

Map<String, dynamic> _$FinePersonToJson(_FinePerson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shirt_number': instance.shirtNumber,
      'avatar_url': instance.avatarUrl,
    };

_PersonFines _$PersonFinesFromJson(Map<String, dynamic> json) => _PersonFines(
  period: FinePeriod.fromJson(json['period'] as Map<String, dynamic>),
  person: FinePerson.fromJson(json['player'] as Map<String, dynamic>),
  fines:
      (json['fines'] as List<dynamic>?)
          ?.map((e) => Fine.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Fine>[],
  totals: json['totals'] == null
      ? const FineTotals()
      : FineTotals.fromJson(json['totals'] as Map<String, dynamic>),
  fineTypes:
      (json['fine_types'] as List<dynamic>?)
          ?.map((e) => FineType.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <FineType>[],
  canManage: json['can_manage'] as bool? ?? false,
);

Map<String, dynamic> _$PersonFinesToJson(_PersonFines instance) =>
    <String, dynamic>{
      'period': instance.period.toJson(),
      'player': instance.person.toJson(),
      'fines': instance.fines.map((e) => e.toJson()).toList(),
      'totals': instance.totals.toJson(),
      'fine_types': instance.fineTypes.map((e) => e.toJson()).toList(),
      'can_manage': instance.canManage,
    };
