import 'package:freezed_annotation/freezed_annotation.dart';

part 'agenda_models.freezed.dart';
part 'agenda_models.g.dart';

/// Een antwoord op een event (`attendance.status`). `null` op een event =
/// er is (nog) geen rij voor jou.
enum AttendanceStatus {
  present,
  absent,
  nonplay,
  pending;

  /// Vraagt dit antwoord (als het team `absence_reason` aan heeft) een reden?
  bool get needsReason =>
      this == AttendanceStatus.absent || this == AttendanceStatus.nonplay;
}

/// Soort event.
enum EventType {
  match,
  training,
  activity,

  /// Een type dat deze appversie nog niet kent.
  unknown,
}

/// Tellers per antwoord (`AttendanceTally` in de PWA).
@freezed
abstract class AttendanceCounts with _$AttendanceCounts {
  const factory AttendanceCounts({
    @Default(0) int present,
    @Default(0) int absent,
    @Default(0) int nonplay,
    @Default(0) int pending,
  }) = _AttendanceCounts;

  const AttendanceCounts._();

  factory AttendanceCounts.fromJson(Map<String, dynamic> json) =>
      _$AttendanceCountsFromJson(json);

  int operator [](AttendanceStatus status) => switch (status) {
    AttendanceStatus.present => present,
    AttendanceStatus.absent => absent,
    AttendanceStatus.nonplay => nonplay,
    AttendanceStatus.pending => pending,
  };

  /// Wie gereageerd heeft (aanwezig, afwezig of kijken).
  int get responded => present + absent + nonplay;

  /// Wie moet reageren: gereageerd plus openstaand.
  int get total => responded + pending;

  /// Eén persoon gaat van [from] naar [to] (zoals de server het straks
  /// terugrekent); nooit onder nul.
  AttendanceCounts shift(AttendanceStatus? from, AttendanceStatus to) {
    var next = this;
    if (from != null) {
      final left = next[from] - 1;
      next = next._with(from, left < 0 ? 0 : left);
    }
    return next._with(to, next[to] + 1);
  }

  AttendanceCounts _with(AttendanceStatus status, int value) =>
      switch (status) {
        AttendanceStatus.present => copyWith(present: value),
        AttendanceStatus.absent => copyWith(absent: value),
        AttendanceStatus.nonplay => copyWith(nonplay: value),
        AttendanceStatus.pending => copyWith(pending: value),
      };
}

/// De live-stand van een wedstrijd (`Event::liveState()`).
@freezed
abstract class LiveState with _$LiveState {
  const factory LiveState({
    @Default(false) bool isLive,
    @Default(false) bool running,
    DateTime? startedAt,
    @Default(0) int accumulatedSeconds,
    DateTime? endedAt,
    @Default(1) int period,
    @Default(<int>[]) List<int> periodEnds,
  }) = _LiveState;

  const LiveState._();

  factory LiveState.fromJson(Map<String, dynamic> json) =>
      _$LiveStateFromJson(json);

  /// Verstreken seconden op [now].
  int secondsAt(DateTime now) {
    final start = startedAt;
    if (!running || start == null) return accumulatedSeconds;
    final delta = now.difference(start).inSeconds;
    return accumulatedSeconds + (delta < 0 ? 0 : delta);
  }

  /// De stand zoals een wedstrijd geteld wordt: `38'` binnen het deel,
  /// `45+3'` erbuiten (zie `useMatchClock` in de PWA).
  String clockLabel(DateTime now) {
    final minute = secondsAt(now) ~/ 60;
    if (periodEnds.isEmpty) return "$minute'";
    final index = period.clamp(1, periodEnds.length) - 1;
    final end = periodEnds[index];
    final stoppage = minute - end;
    return stoppage > 0 ? "$end+$stoppage'" : "$minute'";
  }
}

/// Eén event in de agenda.
@freezed
abstract class AgendaEvent with _$AgendaEvent {
  const factory AgendaEvent({
    required int id,
    @JsonKey(unknownEnumValue: EventType.unknown)
    @Default(EventType.unknown)
    EventType type,
    @Default('') String title,
    required DateTime startsAt,
    DateTime? endsAt,
    DateTime? meetAt,
    String? venue,
    String? homeTeam,
    String? awayTeam,

    /// `league`, `cup`, `friendly` of `null`.
    String? competition,
    int? homeScore,
    int? awayScore,
    DateTime? cancelledAt,
    @JsonKey(unknownEnumValue: AttendanceStatus.pending)
    AttendanceStatus? myStatus,
    @Default(AttendanceCounts()) AttendanceCounts counts,

    /// Alleen spelers (zonder staf); `null` = gelijk aan [counts].
    AttendanceCounts? playerCounts,
    @Default(AttendanceCounts()) AttendanceCounts guestCounts,
    LiveState? live,
    @Default(false) bool inVacation,

    /// Mag ík hierop reageren? `null` = de pagina-brede `can_rsvp`.
    bool? canRsvp,
    @JsonKey(unknownEnumValue: AttendanceStatus.pending)
    @Default(<AttendanceStatus>[
      AttendanceStatus.present,
      AttendanceStatus.absent,
      AttendanceStatus.nonplay,
    ])
    List<AttendanceStatus> rsvpStatuses,
    @Default(false) bool spectatorsCanRsvp,
    @Default(0) int spectatorsPresent,
  }) = _AgendaEvent;

  const AgendaEvent._();

  factory AgendaEvent.fromJson(Map<String, dynamic> json) =>
      _$AgendaEventFromJson(json);

  bool get isMatch => type == EventType.match;
  bool get isCancelled => cancelledAt != null;
  bool get isLive => live?.isLive ?? false;

  /// De kalenderdag zoals de server hem schreef (`YYYY-MM-DD`), los van de
  /// tijdzone van het toestel — net als `starts_at.slice(0, 10)` in de PWA.
  String get dayKey => startsAt.toLocal().toIso8601String().substring(0, 10);

  AttendanceCounts get effectivePlayerCounts => playerCounts ?? counts;
}

/// Een dienst (of oude wasbeurt) in de agenda of bij "Mijn taken".
@freezed
abstract class AgendaDuty with _$AgendaDuty {
  const factory AgendaDuty({
    @Default('duty') String kind,
    int? dutyId,
    int? washId,
    int? eventId,
    @Default(false) bool matchBound,

    /// Kalenderdatum (ISO, met tijdzone); alleen de dag telt.
    required String date,
    @Default('') String dutyType,
    String? icon,
    @Default('') String title,
    String? groupName,
    @Default(<String>[]) List<String> playerNames,
    String? timeRange,

    /// Tijd als tekst (`16:00`), niet als moment.
    String? startsAt,
    String? endsAt,
    String? notes,
    @Default(false) bool done,
    @Default(false) bool mine,
  }) = _AgendaDuty;

  const AgendaDuty._();

  factory AgendaDuty.fromJson(Map<String, dynamic> json) =>
      _$AgendaDutyFromJson(json);

  /// Unieke sleutel (`duty-88`, `wash-3`).
  String get key => '$kind-${dutyId ?? washId}';

  /// `YYYY-MM-DD` uit [date].
  String get dayKey => date.length >= 10 ? date.substring(0, 10) : date;

  /// Hoort bij een wedstrijd (scope=match), of is een oude wasbeurt.
  bool get isMatchDuty => matchBound || kind == 'wash';
}

/// Een jarige.
@freezed
abstract class AgendaBirthday with _$AgendaBirthday {
  const factory AgendaBirthday({
    required String key,
    int? playerId,
    required String name,
    String? avatarUrl,

    /// `YYYY-MM-DD`.
    required String date,
    int? turning,
    @Default(false) bool isToday,
  }) = _AgendaBirthday;

  factory AgendaBirthday.fromJson(Map<String, dynamic> json) =>
      _$AgendaBirthdayFromJson(json);
}

/// Een diensttype (voor het agenda-abonnement).
@freezed
abstract class DutyTypeMeta with _$DutyTypeMeta {
  const factory DutyTypeMeta({
    required int id,
    required String name,
    required String slug,
    String? icon,
  }) = _DutyTypeMeta;

  factory DutyTypeMeta.fromJson(Map<String, dynamic> json) =>
      _$DutyTypeMetaFromJson(json);
}

/// Wie jij bent in dit team, voor de tellers. `null` in [AgendaData.me] =
/// toeschouwer (telt nergens mee).
@freezed
abstract class AgendaMe with _$AgendaMe {
  const factory AgendaMe({
    @Default(false) bool isGuest,
    @Default(false) bool isStaff,
    @Default(false) bool isInjured,
    @Default(false) bool isOnVacation,
  }) = _AgendaMe;

  factory AgendaMe.fromJson(Map<String, dynamic> json) =>
      _$AgendaMeFromJson(json);
}

/// `data` van `GET teams/{team}/agenda`.
@freezed
abstract class AgendaData with _$AgendaData {
  const factory AgendaData({
    @Default(false) bool canRsvp,
    AgendaMe? me,
    @Default(<AgendaEvent>[]) List<AgendaEvent> upcoming,
    @Default(<AgendaEvent>[]) List<AgendaEvent> past,
    @Default(<AgendaDuty>[]) List<AgendaDuty> upcomingDuties,
    @Default(<AgendaDuty>[]) List<AgendaDuty> pastDuties,
    @Default(<AgendaDuty>[]) List<AgendaDuty> myTasks,
    @Default(<AgendaBirthday>[]) List<AgendaBirthday> birthdays,
    @Default(<DutyTypeMeta>[]) List<DutyTypeMeta> dutyTypes,
    @Default(false) bool hasMatches,
    @Default(false) bool hasTrainings,
    String? agendaFeedUrl,
    @Default(false) bool needsSchedule,
    @Default(false) bool canFetchSchedule,

    /// `available`, `pending` of `null` (trainerdingen).
    String? scheduleRequest,
    Map<String, dynamic>? scheduleFeed,
  }) = _AgendaData;

  factory AgendaData.fromJson(Map<String, dynamic> json) =>
      _$AgendaDataFromJson(json);
}

/// `meta` van `GET teams/{team}/agenda`.
@freezed
abstract class AgendaMeta with _$AgendaMeta {
  const factory AgendaMeta({
    @Default(30) int limit,
    @Default(30) int pageSize,
    @Default(0) int upcomingTotal,
    @Default(0) int pastTotal,
  }) = _AgendaMeta;

  factory AgendaMeta.fromJson(Map<String, dynamic> json) =>
      _$AgendaMetaFromJson(json);
}

/// Antwoord van `PATCH …/attendance`.
@freezed
abstract class AttendanceResult with _$AttendanceResult {
  const factory AttendanceResult({
    required int eventId,
    int? playerId,
    int? userId,
    @JsonKey(unknownEnumValue: AttendanceStatus.pending)
    required AttendanceStatus status,
    String? reason,
    DateTime? respondedAt,
    int? changedByUserId,
  }) = _AttendanceResult;

  factory AttendanceResult.fromJson(Map<String, dynamic> json) =>
      _$AttendanceResultFromJson(json);
}
