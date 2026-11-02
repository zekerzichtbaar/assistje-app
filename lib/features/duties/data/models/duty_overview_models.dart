import 'package:freezed_annotation/freezed_annotation.dart';

part 'duty_overview_models.freezed.dart';
part 'duty_overview_models.g.dart';

/// Eén beurt in het leesoverzicht (`mine[]` en `duties[].upcoming[]`, de
/// rijvorm van `App\Support\DutyRows`). Bij `multi` staan alle namen samen
/// in één rij.
@freezed
abstract class DutyOverviewRow with _$DutyOverviewRow {
  const factory DutyOverviewRow({
    required int dutyId,
    int? dutyTypeId,
    int? eventId,
    @Default(false) bool matchBound,

    /// ISO 8601 (`2026-11-08T00:00:00+01:00`). Bewust als tekst: de dag is
    /// de clubdag, niet de dag in de tijdzone van het toestel.
    @Default('') String date,
    String? dutyType,
    @Default('') String title,
    String? icon,

    /// Groepsnaam, of de namen komma-gescheiden.
    String? groupName,
    @Default(<String>[]) List<String> playerNames,
    String? timeRange,

    /// `HH:MM` of `null`.
    String? startsAt,
    String? endsAt,
    String? notes,
    @Default(false) bool done,
    @Default(false) bool mine,

    /// `"Thuis – Uit"` of de titel; `null` zonder wedstrijd.
    String? eventLabel,
  }) = _DutyOverviewRow;

  factory DutyOverviewRow.fromJson(Map<String, dynamic> json) =>
      _$DutyOverviewRowFromJson(json);
}

/// Een vaste groep van een groepsdienst (`duties[].groups[]`).
@freezed
abstract class DutyOverviewGroup with _$DutyOverviewGroup {
  const factory DutyOverviewGroup({
    required int id,
    @Default('') String name,
    @Default(<String>[]) List<String> members,

    /// Jij zit in deze groep.
    @Default(false) bool mine,
  }) = _DutyOverviewGroup;

  factory DutyOverviewGroup.fromJson(Map<String, dynamic> json) =>
      _$DutyOverviewGroupFromJson(json);
}

/// Eén diensttype met zijn komende beurten en groepen (`duties[]`).
@freezed
abstract class DutyOverviewType with _$DutyOverviewType {
  const factory DutyOverviewType({
    required int id,
    @Default('') String name,
    String? icon,

    /// `individual`, `group` of `multi`.
    @Default('individual') String mode,

    /// Hooguit 8 komende beurten, op datum.
    @Default(<DutyOverviewRow>[]) List<DutyOverviewRow> upcoming,

    /// Alle komende beurten (ook die niet in [upcoming] passen).
    @Default(0) int upcomingTotal,
    @Default(<DutyOverviewGroup>[]) List<DutyOverviewGroup> groups,
  }) = _DutyOverviewType;

  const DutyOverviewType._();

  factory DutyOverviewType.fromJson(Map<String, dynamic> json) =>
      _$DutyOverviewTypeFromJson(json);

  /// Hoeveel komende beurten er niet in [upcoming] staan.
  int get more {
    final rest = upcomingTotal - upcoming.length;
    return rest > 0 ? rest : 0;
  }
}

/// `GET teams/{team}/duty-overview`: het dienstenoverzicht voor elk teamlid
/// (`Pages/Player/Duties.tsx`). Alleen lezen.
@freezed
abstract class DutyOverview with _$DutyOverview {
  const factory DutyOverview({
    /// Je eigen komende beurten die nog niet afgevinkt zijn.
    @Default(<DutyOverviewRow>[]) List<DutyOverviewRow> mine,
    @Default(<DutyOverviewType>[]) List<DutyOverviewType> duties,
  }) = _DutyOverview;

  factory DutyOverview.fromJson(Map<String, dynamic> json) =>
      _$DutyOverviewFromJson(json);
}
