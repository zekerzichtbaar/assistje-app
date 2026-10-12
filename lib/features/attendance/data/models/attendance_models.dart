import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../agenda/data/models/agenda_models.dart';

part 'attendance_models.freezed.dart';
part 'attendance_models.g.dart';

/// Soort rij in de aanwezigheidslijst (`rows[].kind`).
enum AttendanceRowKind {
  player,
  staff,

  /// Een soort die deze appversie nog niet kent (niet te wijzigen).
  unknown,
}

/// Het event bovenaan de aanwezigheidslijst (`data.event`).
@freezed
abstract class AttendanceEvent with _$AttendanceEvent {
  const factory AttendanceEvent({
    required int id,

    /// `match`, `training` of `activity` (ruw, zodat een onbekend type niet
    /// breekt).
    @Default('') String type,
    @Default('') String title,
    DateTime? startsAt,
    DateTime? cancelledAt,
    @Default(false) bool canEdit,
  }) = _AttendanceEvent;

  const AttendanceEvent._();

  factory AttendanceEvent.fromJson(Map<String, dynamic> json) =>
      _$AttendanceEventFromJson(json);

  bool get isCancelled => cancelledAt != null;

  /// De antwoorden die de trainer kan zetten. Bij een activiteit bestaat
  /// "kijken" niet (`Event::rsvpStatuses()`); openstaand mag altijd terug.
  List<AttendanceStatus> get settableStatuses => [
    AttendanceStatus.present,
    AttendanceStatus.absent,
    if (type != 'activity') AttendanceStatus.nonplay,
    AttendanceStatus.pending,
  ];
}

/// Eén speler (ook gast) of staflid in de lijst (`data.rows[]`).
@freezed
abstract class AttendanceRow with _$AttendanceRow {
  const factory AttendanceRow({
    @JsonKey(unknownEnumValue: AttendanceRowKind.unknown)
    @Default(AttendanceRowKind.player)
    AttendanceRowKind kind,
    int? playerId,
    int? userId,
    int? shirtNumber,
    @Default('') String name,

    /// Positiecode uit het sportprofiel (bij staf een label).
    @Default('') String position,
    String? avatarUrl,
    @Default(false) bool isGuest,
    @JsonKey(unknownEnumValue: AttendanceStatus.pending)
    @Default(AttendanceStatus.pending)
    AttendanceStatus status,
    String? vacationNote,
    @Default(false) bool standingAbsent,
  }) = _AttendanceRow;

  const AttendanceRow._();

  factory AttendanceRow.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRowFromJson(json);

  bool get isStaff => kind == AttendanceRowKind.staff;

  /// Unieke sleutel (`player-37`, `staff-51`).
  String get key => '${kind.name}-${playerId ?? userId}';

  /// Is deze rij namens iemand te wijzigen (heeft hij een id op de juiste plek)?
  bool get isEditable => switch (kind) {
    AttendanceRowKind.player => playerId != null,
    AttendanceRowKind.staff => userId != null,
    AttendanceRowKind.unknown => false,
  };
}

/// De hele aanwezigheidslijst (`GET events/{event}/attendance`).
@freezed
abstract class EventAttendance with _$EventAttendance {
  const factory EventAttendance({
    required AttendanceEvent event,
    @Default(<AttendanceRow>[]) List<AttendanceRow> rows,
  }) = _EventAttendance;

  const EventAttendance._();

  factory EventAttendance.fromJson(Map<String, dynamic> json) =>
      _$EventAttendanceFromJson(json);

  /// Vaste spelers (geen gasten, geen staf).
  List<AttendanceRow> get players => [
    for (final r in rows)
      if (r.kind == AttendanceRowKind.player && !r.isGuest) r,
  ];

  List<AttendanceRow> get staff => [
    for (final r in rows)
      if (r.isStaff) r,
  ];

  List<AttendanceRow> get guests => [
    for (final r in rows)
      if (r.isGuest) r,
  ];

  /// De breuk: iedereen behalve gasten (die hoeven niet te reageren) —
  /// zelfde getal als op de eventpagina.
  AttendanceCounts get counts => _tally(rows.where((r) => !r.isGuest));

  int get guestsPresent =>
      guests.where((r) => r.status == AttendanceStatus.present).length;

  /// Met [row] op [status] gezet (optimistisch).
  EventAttendance withStatus(AttendanceRow row, AttendanceStatus status) =>
      copyWith(
        rows: [
          for (final r in rows)
            r.key == row.key ? r.copyWith(status: status) : r,
        ],
      );

  static AttendanceCounts _tally(Iterable<AttendanceRow> list) {
    var counts = const AttendanceCounts();
    for (final r in list) {
      counts = switch (r.status) {
        AttendanceStatus.present => counts.copyWith(
          present: counts.present + 1,
        ),
        AttendanceStatus.absent => counts.copyWith(absent: counts.absent + 1),
        AttendanceStatus.nonplay => counts.copyWith(
          nonplay: counts.nonplay + 1,
        ),
        AttendanceStatus.pending => counts.copyWith(
          pending: counts.pending + 1,
        ),
      };
    }
    return counts;
  }
}

/// Een gast van het team die nog niet bij dit event staat
/// (`GET events/{event}/guests/options`).
@freezed
abstract class GuestOption with _$GuestOption {
  const factory GuestOption({
    required int id,
    @Default('') String name,
    int? shirtNumber,
    String? position,
  }) = _GuestOption;

  factory GuestOption.fromJson(Map<String, dynamic> json) =>
      _$GuestOptionFromJson(json);
}

/// De toegevoegde gast (`POST events/{event}/guests`, `201`).
@freezed
abstract class GuestPlayer with _$GuestPlayer {
  const factory GuestPlayer({
    required int id,
    int? shirtNumber,
    @Default('') String name,
    String? position,
    @Default(true) bool isGuest,
    String? fromTeam,
  }) = _GuestPlayer;

  factory GuestPlayer.fromJson(Map<String, dynamic> json) =>
      _$GuestPlayerFromJson(json);
}

/// Een nieuwe gast aanmaken: [name] verplicht, rugnummer en positiecode
/// optioneel.
class NewGuest {
  const NewGuest({required this.name, this.shirtNumber, this.position});

  final String name;
  final int? shirtNumber;
  final String? position;

  Map<String, Object?> toJson() => {
    'name': name.trim(),
    'shirt_number': shirtNumber,
    'position': position == null || position!.isEmpty ? null : position,
  };
}
