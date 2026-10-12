import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../event/data/models/event_detail_models.dart';

part 'schedule_models.freezed.dart';
part 'schedule_models.g.dart';

/// Soort event zoals het formulier hem verstuurt (`type`).
enum ScheduleType {
  training,
  match,
  activity;

  /// De waarde zoals de API hem verwacht.
  String get apiValue => name;

  /// [value] uit de API, of `null` als deze appversie hem niet kent.
  static ScheduleType? tryParse(Object? value) {
    for (final type in values) {
      if (type.apiValue == value) return type;
    }
    return null;
  }
}

/// Eén keuze uit `options.types` of `options.competitions`.
@freezed
abstract class ScheduleChoice with _$ScheduleChoice {
  const factory ScheduleChoice({
    required String value,
    @Default('') String label,
  }) = _ScheduleChoice;

  factory ScheduleChoice.fromJson(Map<String, dynamic> json) =>
      _$ScheduleChoiceFromJson(json);
}

Map<String, int> _durationsFromJson(Object? json) {
  if (json is! Map) return const {};
  return {
    for (final entry in json.entries)
      if (entry.value is num) '${entry.key}': (entry.value as num).toInt(),
  };
}

/// `options.defaults`: wat een nieuw formulier vooraf invult.
@freezed
abstract class ScheduleDefaults with _$ScheduleDefaults {
  const factory ScheduleDefaults({
    @Default('training') String type,

    /// `HH:mm`, alleen voor een nieuwe training.
    @Default('19:00') String trainingStartTime,
    @Default('league') String competition,
    @Default(true) bool isHome,
    @JsonKey(fromJson: _durationsFromJson)
    @Default(<String, int>{})
    Map<String, int> durationMinutes,
  }) = _ScheduleDefaults;

  factory ScheduleDefaults.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDefaultsFromJson(json);
}

/// `GET teams/{team}/schedule/options`: wat het formulier nodig heeft.
@freezed
abstract class ScheduleOptions with _$ScheduleOptions {
  const factory ScheduleOptions({
    @Default('') String teamName,
    @Default('Europe/Amsterdam') String timezone,
    @Default(<ScheduleChoice>[]) List<ScheduleChoice> types,
    @Default(<ScheduleChoice>[]) List<ScheduleChoice> competitions,
    @Default(ScheduleDefaults()) ScheduleDefaults defaults,
  }) = _ScheduleOptions;

  const ScheduleOptions._();

  factory ScheduleOptions.fromJson(Map<String, dynamic> json) =>
      _$ScheduleOptionsFromJson(json);

  /// Het label van soort [type] (uit de API; anders de waarde zelf).
  String typeLabel(ScheduleType type) {
    for (final choice in types) {
      if (choice.value == type.apiValue) return choice.label;
    }
    return type.apiValue;
  }

  /// De soorten die deze appversie kent, in de volgorde van de API.
  List<ScheduleType> get knownTypes {
    final known = [
      for (final choice in types) ?ScheduleType.tryParse(choice.value),
    ];
    return known.isEmpty ? ScheduleType.values : known;
  }
}

/// De formuliervelden van een bestaand event, uit dezelfde `data` als
/// `GET events/{event}` (ook het antwoord op aanmaken/wijzigen/afgelasten).
/// [EventDetail] kent `can_cancel` en `spectators_can_rsvp` niet; daarom
/// leest de agenda-beheer-feature ze hier zelf.
@freezed
abstract class ScheduleEvent with _$ScheduleEvent {
  const factory ScheduleEvent({
    required int id,
    @Default('training') String type,
    @Default('') String title,
    required DateTime startsAt,
    DateTime? endsAt,
    DateTime? meetAt,
    String? venue,
    String? notes,
    bool? isHome,
    String? competition,
    String? homeTeam,
    String? awayTeam,
    DateTime? cancelledAt,
    @Default(false) bool canCancel,
    @Default(false) bool spectatorsCanRsvp,
  }) = _ScheduleEvent;

  const ScheduleEvent._();

  factory ScheduleEvent.fromJson(Map<String, dynamic> json) =>
      _$ScheduleEventFromJson(json);

  bool get isCancelled => cancelledAt != null;

  /// De soort, of `null` als deze appversie hem niet kent.
  ScheduleType? get scheduleType => ScheduleType.tryParse(type);
}

/// Het ingevulde formulier, klaar om te versturen (aanmaken of wijzigen).
///
/// Datum-tijden gaan mee mét de tijdzone van het toestel, zodat de server
/// precies het gekozen moment opslaat (de API respecteert een offset).
@freezed
abstract class ScheduleDraft with _$ScheduleDraft {
  const factory ScheduleDraft({
    required ScheduleType type,
    required DateTime startsAt,
    DateTime? endsAt,
    DateTime? meetAt,
    String? title,
    String? venue,
    String? notes,
    String? homeTeam,
    String? awayTeam,
    bool? isHome,
    String? competition,
    @Default(false) bool spectatorsCanRsvp,

    /// Alleen bij aanmaken van een training: wekelijks t/m deze datum.
    DateTime? recurUntil,

    /// Alleen bij wijzigen van een training: ook de volgende trainingen.
    @Default(false) bool applyToFollowing,
  }) = _ScheduleDraft;

  const ScheduleDraft._();

  /// De body voor `POST schedule` ([update] `false`) of `PATCH
  /// schedule/{event}` ([update] `true`).
  Map<String, dynamic> toPayload({required bool update}) {
    final match = type == ScheduleType.match;
    final training = type == ScheduleType.training;
    String? text(String? value) {
      final trimmed = value?.trim();
      return trimmed == null || trimmed.isEmpty ? null : trimmed;
    }

    return {
      'type': type.apiValue,
      'starts_at': scheduleDateTime(startsAt),
      'ends_at': endsAt == null ? null : scheduleDateTime(endsAt!),
      'meet_at': meetAt == null ? null : scheduleDateTime(meetAt!),
      'title': match ? null : text(title),
      'venue': text(venue),
      'notes': text(notes),
      'home_team': match ? text(homeTeam) : null,
      'away_team': match ? text(awayTeam) : null,
      'is_home': match ? isHome : null,
      'competition': match ? competition : null,
      'spectators_can_rsvp': type == ScheduleType.activity && spectatorsCanRsvp,
      if (!update && training && recurUntil != null)
        'recur_until': scheduleDate(recurUntil!),
      if (update) 'apply_to_following': training && applyToFollowing,
    };
  }
}

/// Wat een schrijfactie teruggeeft: het event (in de vorm van het detail én
/// als formuliervelden) en de `meta`.
class ScheduleWriteResult {
  const ScheduleWriteResult({
    required this.event,
    required this.schedule,
    this.createdIds = const [],
    this.adoptedIds = const [],
    this.followingUpdated = 0,
  });

  final EventDetail event;
  final ScheduleEvent schedule;

  /// `meta.created_ids` (aanmaken).
  final List<int> createdIds;

  /// `meta.adopted_ids` (aanmaken: bestaande trainingen overgenomen).
  final List<int> adoptedIds;

  /// `meta.following_updated` (wijzigen met `apply_to_following`).
  final int followingUpdated;

  /// Hoeveel events de reeks telt (aangemaakt plus overgenomen; minstens 1).
  int get seriesCount {
    final total = createdIds.length + adoptedIds.length;
    return total < 1 ? 1 : total;
  }
}

String _two(int value) => value.toString().padLeft(2, '0');

/// `YYYY-MM-DD` van [date] (kalenderdag, tijd genegeerd).
String scheduleDate(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-${_two(date.month)}-'
    '${_two(date.day)}';

/// `YYYY-MM-DDTHH:mm:00+01:00`: [value] als lokale tijd mét de offset van
/// het toestel op dat moment (zomer-/wintertijd per datum).
String scheduleDateTime(DateTime value) {
  final local = value.isUtc ? value.toLocal() : value;
  final offset = local.timeZoneOffset;
  final sign = offset.isNegative ? '-' : '+';
  final minutes = offset.inMinutes.abs();
  return '${scheduleDate(local)}T${_two(local.hour)}:${_two(local.minute)}:00'
      '$sign${_two(minutes ~/ 60)}:${_two(minutes % 60)}';
}
