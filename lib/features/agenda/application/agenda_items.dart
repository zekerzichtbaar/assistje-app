import '../data/models/agenda_models.dart';

/// Eén dienst zoals hij onder een wedstrijdregel verschijnt.
class DutyChip {
  const DutyChip({
    required this.key,
    required this.icon,
    required this.dutyType,
    required this.label,
    required this.mine,
    this.peopleCount = 0,
  });

  final String key;
  final String? icon;
  final String dutyType;

  /// Voornaam of groepsnaam; leeg = toon [peopleCount] ("3 personen").
  final String label;
  final bool mine;
  final int peopleCount;

  bool get isEmpty => label.isEmpty && peopleCount == 0;
}

/// Eén rij in de agendalijst.
sealed class AgendaItem {
  const AgendaItem();

  /// Waarop de lijst sorteert (ms sinds epoch); zie `sortKey` in de PWA.
  int get sortKey;

  /// Stabiele sleutel voor de lijst.
  String get key;
}

final class AgendaEventItem extends AgendaItem {
  const AgendaEventItem(this.event, {this.dutyChips = const []});

  final AgendaEvent event;
  final List<DutyChip> dutyChips;

  @override
  int get sortKey => event.startsAt.millisecondsSinceEpoch;

  @override
  String get key => 'e-${event.id}';
}

final class AgendaDutyItem extends AgendaItem {
  const AgendaDutyItem(this.duty);

  final AgendaDuty duty;

  /// De dag plus de losse tijd (`16:00`); zonder tijd middernacht, dus
  /// vooraan die dag.
  @override
  int get sortKey {
    final day = parseDay(duty.dayKey).millisecondsSinceEpoch;
    final match = RegExp(r'^(\d{1,2}):(\d{2})').firstMatch(duty.startsAt ?? '');
    if (match == null) return day;
    final minutes = int.parse(match[1]!) * 60 + int.parse(match[2]!);
    return day + minutes * 60000;
  }

  @override
  String get key => 'd-${duty.key}';
}

final class AgendaBirthdayItem extends AgendaItem {
  const AgendaBirthdayItem(this.birthday);

  final AgendaBirthday birthday;

  @override
  int get sortKey => parseDay(birthday.date).millisecondsSinceEpoch;

  @override
  String get key => 'b-${birthday.key}';
}

/// `YYYY-MM-DD…` → lokale middernacht van die dag.
DateTime parseDay(String value) {
  final day = value.length >= 10 ? value.substring(0, 10) : value;
  final parts = day.split('-');
  if (parts.length != 3) return DateTime.fromMillisecondsSinceEpoch(0);
  return DateTime(
    int.tryParse(parts[0]) ?? 1970,
    int.tryParse(parts[1]) ?? 1,
    int.tryParse(parts[2]) ?? 1,
  );
}

/// Bouwt de lijst van één tabblad, precies als `sortedItems` in de PWA:
/// wedstrijddiensten worden onder hun wedstrijd gevouwen (op `event_id`, of
/// voor oudere rijen op de datum); een dienst zonder wedstrijd blijft een
/// eigen rij. [descending] voor Verleden.
List<AgendaItem> buildAgendaItems({
  required List<AgendaEvent> events,
  required List<AgendaDuty> duties,
  List<AgendaBirthday> birthdays = const [],
  bool descending = false,
}) {
  final eventIds = {for (final e in events) e.id};
  final matchDays = {
    for (final e in events)
      if (e.isMatch) e.dayKey,
  };
  final folded = <String>{};
  final byEvent = <int, List<DutyChip>>{};
  final byDay = <String, List<DutyChip>>{};

  for (final d in duties) {
    if (!d.isMatchDuty) continue;
    final names = d.playerNames;
    // Eén persoon → voornaam; een groep → de groepsnaam.
    final label = names.length == 1
        ? names.first.split(' ').first
        : (d.groupName ?? '');
    final chip = DutyChip(
      key: d.key,
      icon: d.icon,
      dutyType: d.dutyType,
      label: label,
      mine: d.mine,
      peopleCount: label.isEmpty ? names.length : 0,
    );
    final eventId = d.eventId;
    if (eventId != null && eventIds.contains(eventId)) {
      folded.add(d.key);
      if (!chip.isEmpty) (byEvent[eventId] ??= []).add(chip);
      continue;
    }
    if (!matchDays.contains(d.dayKey)) continue;
    folded.add(d.key);
    if (!chip.isEmpty) (byDay[d.dayKey] ??= []).add(chip);
  }

  final items = <AgendaItem>[
    for (final e in events)
      AgendaEventItem(
        e,
        dutyChips: byEvent[e.id] ?? byDay[e.dayKey] ?? const [],
      ),
    for (final d in duties)
      if (!folded.contains(d.key)) AgendaDutyItem(d),
    for (final b in birthdays) AgendaBirthdayItem(b),
  ];
  // Stabiel sorteren: gelijke sleutels houden hun volgorde.
  final indexed = items.indexed.toList()
    ..sort((a, b) {
      final cmp = descending
          ? b.$2.sortKey.compareTo(a.$2.sortKey)
          : a.$2.sortKey.compareTo(b.$2.sortKey);
      return cmp != 0 ? cmp : a.$1.compareTo(b.$1);
    });
  return [for (final (_, item) in indexed) item];
}
