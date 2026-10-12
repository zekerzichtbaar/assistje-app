import '../data/models/schedule_models.dart';

/// Een kloktijd zonder datum (`HH:mm`).
typedef ClockTime = ({int hour, int minute});

/// `19:00` → `(hour: 19, minute: 0)`; `null` bij iets onleesbaars.
ClockTime? parseClockTime(String? value) {
  if (value == null) return null;
  final parts = value.split(':');
  if (parts.length < 2) return null;
  final hour = int.tryParse(parts[0]);
  final minute = int.tryParse(parts[1]);
  if (hour == null || minute == null) return null;
  if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;
  return (hour: hour, minute: minute);
}

/// `(19, 0)` → `19:00`.
String formatClockTime(ClockTime time) =>
    '${time.hour.toString().padLeft(2, '0')}:'
    '${time.minute.toString().padLeft(2, '0')}';

ClockTime? _clockOf(DateTime? value) {
  if (value == null) return null;
  final local = value.toLocal();
  return (hour: local.hour, minute: local.minute);
}

int _minutes(ClockTime t) => t.hour * 60 + t.minute;

/// Wat er in het event-formulier staat (`EventFormSheet.tsx` in de PWA).
/// Muteerbaar: het formulier past velden aan en bouwt daarna een
/// [ScheduleDraft].
class ScheduleFormValues {
  ScheduleFormValues({
    required this.type,
    this.date,
    this.start,
    this.end,
    this.meet,
    this.title = '',
    this.venue = '',
    this.notes = '',
    this.isHome = true,
    this.competition = 'league',
    this.opponent = '',
    this.spectatorsCanRsvp = false,
    this.recurring = false,
    this.recurUntil,
    this.applyToFollowing = false,
  });

  /// Een nieuw formulier met de standaarden uit [options]; met [event] de
  /// waarden van dat event (bewerken).
  factory ScheduleFormValues.initial(
    ScheduleOptions options, {
    ScheduleEvent? event,
  }) {
    final defaults = options.defaults;
    if (event == null) {
      final type =
          ScheduleType.tryParse(defaults.type) ?? options.knownTypes.first;
      return ScheduleFormValues(
        type: type,
        // Een nieuwe training begint standaard om de teamtijd; de rest kiest
        // de trainer zelf.
        start: type == ScheduleType.training
            ? parseClockTime(defaults.trainingStartTime)
            : null,
        isHome: defaults.isHome,
        competition: defaults.competition,
      );
    }
    final starts = event.startsAt.toLocal();
    final isHome = event.isHome ?? true;
    return ScheduleFormValues(
      type: event.scheduleType ?? ScheduleType.activity,
      date: DateTime(starts.year, starts.month, starts.day),
      start: _clockOf(starts),
      end: _clockOf(event.endsAt),
      meet: _clockOf(event.meetAt),
      title: event.title,
      venue: event.venue ?? '',
      notes: event.notes ?? '',
      isHome: isHome,
      // Een oude wedstrijd zonder soort krijgt de standaard (competitie).
      competition: event.competition ?? defaults.competition,
      opponent: (isHome ? event.awayTeam : event.homeTeam) ?? '',
      spectatorsCanRsvp: event.spectatorsCanRsvp,
    );
  }

  ScheduleType type;
  DateTime? date;
  ClockTime? start;
  ClockTime? end;
  ClockTime? meet;
  String title;
  String venue;
  String notes;
  bool isHome;
  String competition;
  String opponent;
  bool spectatorsCanRsvp;
  bool recurring;
  DateTime? recurUntil;
  bool applyToFollowing;

  /// Datum en starttijd zijn verplicht.
  bool get hasStart => date != null && start != null;

  /// [time] op de gekozen datum.
  DateTime? _on(ClockTime? time) {
    final day = date;
    if (day == null || time == null) return null;
    return DateTime(day.year, day.month, day.day, time.hour, time.minute);
  }

  /// De eindtijd, op de dag erna als hij niet ná de starttijd ligt (een
  /// borrel van 22:00 tot 01:00), zoals `combineEnd` in de PWA.
  DateTime? get _endsAt {
    final endsAt = _on(end);
    final s = start;
    final e = end;
    if (endsAt == null || s == null || e == null) return endsAt;
    return _minutes(e) > _minutes(s)
        ? endsAt
        : endsAt.add(const Duration(days: 1));
  }

  /// Het formulier als [ScheduleDraft]; `null` zonder datum of starttijd.
  ///
  /// [teamName] wordt thuis- of uitploeg bij een wedstrijd; [isEdit] en
  /// [originalType] bepalen of "alle volgende" en de reeks meegaan.
  ScheduleDraft? toDraft({
    required String teamName,
    required bool isEdit,
    ScheduleType? originalType,
  }) {
    final startsAt = _on(start);
    if (startsAt == null) return null;
    final match = type == ScheduleType.match;
    final training = type == ScheduleType.training;
    final rival = opponent.trim();
    return ScheduleDraft(
      type: type,
      startsAt: startsAt,
      endsAt: _endsAt,
      meetAt: _on(meet),
      title: match ? null : title,
      venue: venue,
      notes: notes,
      homeTeam: match ? (isHome ? teamName : rival) : null,
      awayTeam: match ? (isHome ? rival : teamName) : null,
      isHome: match ? isHome : null,
      competition: match ? competition : null,
      spectatorsCanRsvp: type == ScheduleType.activity && spectatorsCanRsvp,
      recurUntil: !isEdit && training && recurring ? recurUntil : null,
      applyToFollowing:
          canApplyToFollowing(isEdit: isEdit, originalType: originalType) &&
          applyToFollowing,
    );
  }

  /// "Alle volgende" bestaat alleen bij het bewerken van een training die
  /// een training blijft.
  bool canApplyToFollowing({
    required bool isEdit,
    required ScheduleType? originalType,
  }) =>
      isEdit &&
      originalType == ScheduleType.training &&
      type == ScheduleType.training;
}
