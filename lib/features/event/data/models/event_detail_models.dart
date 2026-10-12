import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../agenda/data/models/agenda_models.dart';

part 'event_detail_models.freezed.dart';
part 'event_detail_models.g.dart';

/// Wie een rij in de spelerslijst is (`players[].kind`).
enum EventPlayerKind {
  player,
  staff,
  guest,
  spectator,

  /// Een soort die deze appversie nog niet kent.
  unknown,
}

/// Hoe iemand naar een uitwedstrijd rijdt (`carpool_offers[].mode`).
enum CarpoolMode {
  @JsonValue('from_club')
  fromClub,
  @JsonValue('direct')
  direct,
}

/// Wat de bond over de wedstrijd weet (`sportlink`).
@freezed
abstract class SportlinkInfo with _$SportlinkInfo {
  const factory SportlinkInfo({
    String? field,
    String? dressingRoom,
    String? referee,
  }) = _SportlinkInfo;

  const SportlinkInfo._();

  factory SportlinkInfo.fromJson(Map<String, dynamic> json) =>
      _$SportlinkInfoFromJson(json);

  bool get isEmpty =>
      (field ?? '').isEmpty &&
      (dressingRoom ?? '').isEmpty &&
      (referee ?? '').isEmpty;
}

/// Eén rij in `players` (speler, staf, gast of toeschouwer).
@freezed
abstract class EventPlayer with _$EventPlayer {
  const factory EventPlayer({
    required int id,
    @JsonKey(unknownEnumValue: EventPlayerKind.unknown)
    @Default(EventPlayerKind.player)
    EventPlayerKind kind,
    String? rowKey,
    @Default('') String name,
    String? avatarUrl,
    int? shirtNumber,
    @Default(false) bool isGuest,
    @Default(false) bool isInjured,
    @Default(false) bool isOnVacation,
    @JsonKey(unknownEnumValue: AttendanceStatus.pending)
    @Default(AttendanceStatus.pending)
    AttendanceStatus status,
    String? reason,
    @Default(false) bool isMe,
    @Default(false) bool isCaptain,
    @Default(false) bool isKeeper,
  }) = _EventPlayer;

  factory EventPlayer.fromJson(Map<String, dynamic> json) =>
      _$EventPlayerFromJson(json);
}

/// Iemand op wie je kunt stemmen (`motm.eligible`).
@freezed
abstract class MotmCandidate with _$MotmCandidate {
  const factory MotmCandidate({
    required int id,
    @Default('') String name,
    int? shirtNumber,
    String? avatarUrl,
  }) = _MotmCandidate;

  factory MotmCandidate.fromJson(Map<String, dynamic> json) =>
      _$MotmCandidateFromJson(json);
}

/// Eén regel uit de uitslag (`motm.tally`, pas als de stemming dicht is).
@freezed
abstract class MotmTally with _$MotmTally {
  const factory MotmTally({required int playerId, @Default(0) int votes}) =
      _MotmTally;

  factory MotmTally.fromJson(Map<String, dynamic> json) =>
      _$MotmTallyFromJson(json);
}

/// Het `motm`-blok van een wedstrijd.
@freezed
abstract class MotmState with _$MotmState {
  const factory MotmState({
    @Default(false) bool isOpen,
    @Default(false) bool opensAfter,
    DateTime? closesAt,
    @Default(<MotmCandidate>[]) List<MotmCandidate> eligible,
    @Default(<MotmTally>[]) List<MotmTally> tally,
    int? myVote,
    @Default(true) bool canVote,
    int? selfId,
  }) = _MotmState;

  factory MotmState.fromJson(Map<String, dynamic> json) =>
      _$MotmStateFromJson(json);
}

/// Antwoord op `POST …/motm`.
@freezed
abstract class MotmVoteResult with _$MotmVoteResult {
  const factory MotmVoteResult({
    required int eventId,
    int? myVote,
    @Default(false) bool isOpen,
    DateTime? closesAt,
  }) = _MotmVoteResult;

  factory MotmVoteResult.fromJson(Map<String, dynamic> json) =>
      _$MotmVoteResultFromJson(json);
}

/// Een aanmelding om te rijden (`carpool_offers[]`, en het antwoord op
/// `POST …/carpool`).
@freezed
abstract class CarpoolOffer with _$CarpoolOffer {
  const factory CarpoolOffer({
    required int id,
    int? userId,
    @Default('') String userName,
    String? avatarUrl,
    @JsonKey(unknownEnumValue: CarpoolMode.direct)
    @Default(CarpoolMode.direct)
    CarpoolMode mode,
    int? seats,
    @Default(false) bool isSelf,
  }) = _CarpoolOffer;

  factory CarpoolOffer.fromJson(Map<String, dynamic> json) =>
      _$CarpoolOfferFromJson(json);
}

/// Een keuze in de toewijslijst van een dienst (`duties[].options[]`,
/// alleen voor de trainer): een persoon (`p_12`/`u_3`, met [kind]) of een
/// groep (`g_4`, met [id] en [members]).
@freezed
abstract class EventDutyOption with _$EventDutyOption {
  const factory EventDutyOption({
    required String key,
    @Default('') String name,
    int? id,
    String? kind,
    @Default(<String>[]) List<String> members,
  }) = _EventDutyOption;

  factory EventDutyOption.fromJson(Map<String, dynamic> json) =>
      _$EventDutyOptionFromJson(json);
}

/// Een dienst bij deze wedstrijd (`duties[]`). Trainers krijgen elk
/// match-diensttype (ook leeg) met [options]; anderen alleen wat
/// toegewezen is.
@freezed
abstract class EventDuty with _$EventDuty {
  const factory EventDuty({
    required int dutyTypeId,
    @Default('') String name,
    String? icon,

    /// `individual`, `group` of `multi` (onbekend telt als persoon).
    @Default('individual') String mode,
    int? assignmentId,
    String? memberKey,
    @Default(<String>[]) List<String> memberKeys,
    @Default(false) bool assigneeAbsent,
    int? dutyGroupId,
    String? label,
    @Default(<String>[]) List<String> memberNames,
    String? notes,
    @Default(false) bool done,
    @Default(false) bool mine,
    @Default(<EventDutyOption>[]) List<EventDutyOption> options,
  }) = _EventDuty;

  const EventDuty._();

  factory EventDuty.fromJson(Map<String, dynamic> json) =>
      _$EventDutyFromJson(json);

  bool get isGroup => mode == 'group';
  bool get isMulti => mode == 'multi';

  /// Staat optie [key] aan? Bij `multi` kunnen dat er meerdere zijn.
  bool isPicked(String key) => isGroup
      ? dutyGroupId != null && key == 'g_$dutyGroupId'
      : memberKeys.contains(key);

  /// Nog niemand (of geen groep) ingedeeld.
  bool get nobodyPicked => isGroup ? dutyGroupId == null : memberKeys.isEmpty;
}

/// Eén beurt van de vlaggersdienst (`flag.shifts[]`).
@freezed
abstract class FlagShift with _$FlagShift {
  const factory FlagShift({
    String? key,
    int? playerId,
    int? userId,
    @Default(0) int fromMinute,
  }) = _FlagShift;

  factory FlagShift.fromJson(Map<String, dynamic> json) =>
      _$FlagShiftFromJson(json);
}

/// De vlaggersdienst (`flag`); alleen lezen — wijzigen zit (nog) niet in
/// de API.
@freezed
abstract class FlagDuty with _$FlagDuty {
  const factory FlagDuty({
    @Default(<FlagShift>[]) List<FlagShift> shifts,
    @Default(<String>[]) List<String> names,
    @Default(false) bool mine,
    int? matchMinutes,
  }) = _FlagDuty;

  factory FlagDuty.fromJson(Map<String, dynamic> json) =>
      _$FlagDutyFromJson(json);
}

/// Het event-detail (`GET teams/{team}/events/{event}`). Alleen de velden
/// die de app toont; onbekende sleutels worden genegeerd.
@freezed
abstract class EventDetail with _$EventDetail {
  const factory EventDetail({
    required int id,
    @JsonKey(unknownEnumValue: EventType.unknown)
    @Default(EventType.unknown)
    EventType type,
    @Default('') String title,
    required DateTime startsAt,
    DateTime? endsAt,
    DateTime? meetAt,
    String? venue,
    String? notes,
    bool? isHome,

    /// `league`, `cup`, `friendly` of `null`.
    String? competition,
    String? homeTeam,
    String? awayTeam,
    int? homeScore,
    int? awayScore,
    DateTime? cancelledAt,
    LiveState? live,
    @JsonKey(unknownEnumValue: AttendanceStatus.pending)
    @Default(<AttendanceStatus>[
      AttendanceStatus.present,
      AttendanceStatus.nonplay,
      AttendanceStatus.absent,
    ])
    List<AttendanceStatus> rsvpStatuses,
    SportlinkInfo? sportlink,
    @JsonKey(unknownEnumValue: AttendanceStatus.pending)
    AttendanceStatus? myStatus,
    String? myReason,
    @Default(false) bool canRsvp,
    @Default(false) bool canChange,
    @Default(AttendanceCounts()) AttendanceCounts counts,
    @Default(AttendanceCounts()) AttendanceCounts playerCounts,
    @Default(<EventPlayer>[]) List<EventPlayer> players,
    @Default(false) bool hasLineup,
    @Default(false) bool lineupShared,
    MotmState? motm,
    List<CarpoolOffer>? carpoolOffers,
    @Default(false) bool isTrainer,
    @Default(false) bool canAssignTeams,
    @Default(<EventDuty>[]) List<EventDuty> duties,
    FlagDuty? flag,
  }) = _EventDetail;

  const EventDetail._();

  factory EventDetail.fromJson(Map<String, dynamic> json) =>
      _$EventDetailFromJson(json);

  bool get isMatch => type == EventType.match;
  bool get isTraining => type == EventType.training;
  bool get isCancelled => cancelledAt != null;
  bool get isLive => live?.isLive ?? false;
  bool get hasEnded => live?.endedAt != null;

  /// De dienstenkaart: alleen bij een wedstrijd met diensten of een
  /// vlaggersdienst (`EventDetail.tsx`).
  bool get showsDuties => isMatch && (duties.isNotEmpty || flag != null);

  /// Gespeeld: na de aanvang, of live gestart/afgelopen (`matchHasRun`).
  bool hasRun(DateTime now) => !startsAt.isAfter(now) || isLive || hasEnded;

  /// Jouw eigen rij in de lijst, als je erin staat.
  EventPlayer? get me {
    for (final p in players) {
      if (p.isMe) return p;
    }
    return null;
  }
}
