import 'package:freezed_annotation/freezed_annotation.dart';

part 'duties_models.freezed.dart';
part 'duties_models.g.dart';

/// Eén diensttype voor de typewisselaar (`duty_types[]`).
@freezed
abstract class DutyTypeSummary with _$DutyTypeSummary {
  const factory DutyTypeSummary({
    required int id,
    @Default('') String name,
    @Default('') String slug,
    String? icon,

    /// `individual`, `group` of `multi`.
    @Default('individual') String mode,

    /// `free` of `match`.
    @Default('free') String scope,
    @Default(false) bool autoRotate,
  }) = _DutyTypeSummary;

  factory DutyTypeSummary.fromJson(Map<String, dynamic> json) =>
      _$DutyTypeSummaryFromJson(json);
}

/// Een lid van een groep (`groups[].members[]`).
@freezed
abstract class DutyMember with _$DutyMember {
  const factory DutyMember({required String key, @Default('') String name}) =
      _DutyMember;

  factory DutyMember.fromJson(Map<String, dynamic> json) =>
      _$DutyMemberFromJson(json);
}

/// Een vaste groep van een groepsdienst (`groups[]`, en de schrijfrespons).
@freezed
abstract class DutyGroup with _$DutyGroup {
  const factory DutyGroup({
    required int id,
    @Default('') String name,
    DateTime? lastAssignedAt,
    @Default(0) int count,
    @Default(<DutyMember>[]) List<DutyMember> members,

    /// Alleen in de schrijfrespons.
    int? dutyTypeId,
    int? sortOrder,
  }) = _DutyGroup;

  factory DutyGroup.fromJson(Map<String, dynamic> json) =>
      _$DutyGroupFromJson(json);
}

/// Eén beurt (`assignments[]`, en de schrijfrespons).
@freezed
abstract class DutyAssignment with _$DutyAssignment {
  const factory DutyAssignment({
    required int id,

    /// `YYYY-MM-DD`.
    @Default('') String scheduledFor,

    /// `HH:MM` of `null`.
    String? startsAt,
    String? endsAt,
    String? notes,
    int? groupId,
    String? groupName,
    int? playerId,
    String? memberKey,
    String? playerName,
    int? eventId,
    String? eventLabel,
    DateTime? markedDoneAt,
    int? dutyTypeId,
  }) = _DutyAssignment;

  const DutyAssignment._();

  factory DutyAssignment.fromJson(Map<String, dynamic> json) =>
      _$DutyAssignmentFromJson(json);

  bool get isDone => markedDoneAt != null;

  /// De datum als lokale dag, of `null` als hij niet te lezen is.
  DateTime? get date => DateTime.tryParse(scheduledFor);
}

/// Iemand die dit type kan doen (`all_people[]`) of in het team zit
/// (`pool_people[]`, zonder `count`).
@freezed
abstract class DutyPerson with _$DutyPerson {
  const factory DutyPerson({
    required String key,
    @Default('') String name,

    /// `player`, `guest`, `staff` of `spectator`.
    @Default('player') String kind,
    @Default(false) bool isTrainerOnly,
    @Default(0) int count,
  }) = _DutyPerson;

  factory DutyPerson.fromJson(Map<String, dynamic> json) =>
      _$DutyPersonFromJson(json);
}

/// Een kiesbare wedstrijd (`matches[]`, alleen bij `scope: match`).
@freezed
abstract class DutyMatch with _$DutyMatch {
  const factory DutyMatch({
    required int id,
    @Default('') String label,

    /// `YYYY-MM-DD`.
    @Default('') String date,
    DateTime? startsAt,
  }) = _DutyMatch;

  factory DutyMatch.fromJson(Map<String, dynamic> json) =>
      _$DutyMatchFromJson(json);
}

/// `GET teams/{team}/duties[?type=]`: het overzicht van één diensttype.
@freezed
abstract class DutiesOverview with _$DutiesOverview {
  const factory DutiesOverview({
    @Default('') String type,
    required int dutyTypeId,
    @Default('individual') String dutyTypeMode,
    @Default('free') String dutyTypeScope,
    @Default(false) bool dutyTypeAutoRotate,
    @Default(<String>[]) List<String> dutyTypePool,
    @Default(<DutyTypeSummary>[]) List<DutyTypeSummary> dutyTypes,
    @Default(<DutyGroup>[]) List<DutyGroup> groups,
    @Default(<DutyAssignment>[]) List<DutyAssignment> assignments,
    @Default(<DutyPerson>[]) List<DutyPerson> allPeople,
    @Default(<DutyPerson>[]) List<DutyPerson> poolPeople,
    @Default(<DutyMatch>[]) List<DutyMatch> matches,
  }) = _DutiesOverview;

  const DutiesOverview._();

  factory DutiesOverview.fromJson(Map<String, dynamic> json) =>
      _$DutiesOverviewFromJson(json);

  /// Eén persoon per beurt. Alle andere modi plannen in groepen, zoals
  /// `isIndividual` in de PWA (`Trainer/Duties/Index.tsx`).
  bool get isIndividual => dutyTypeMode == 'individual';

  /// Hangt aan een wedstrijd: je kiest een wedstrijd in plaats van een datum.
  bool get isMatchBound => dutyTypeScope == 'match';

  /// Het getoonde type uit [dutyTypes].
  DutyTypeSummary? get currentType {
    for (final t in dutyTypes) {
      if (t.slug == type || t.id == dutyTypeId) return t;
    }
    return null;
  }

  /// [allPeople] op aantal beurten (minste eerst), dan op naam.
  List<DutyPerson> get peopleByCount => [...allPeople]
    ..sort((a, b) {
      final byCount = a.count.compareTo(b.count);
      return byCount != 0 ? byCount : a.name.compareTo(b.name);
    });

  /// Voorstel bij een nieuwe beurt: wie de minste beurten had, geen gast.
  String? get suggestedMemberKey {
    for (final p in peopleByCount) {
      if (p.kind != 'guest') return p.key;
    }
    return null;
  }
}
