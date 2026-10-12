import '../../../core/session/models/team_membership.dart';

/// Een linie uit `sport.position_groups` (bv. Keepers, Verdedigers).
class PositionGroup {
  const PositionGroup({
    required this.key,
    required this.label,
    required this.codes,
  });

  final String key;
  final String label;
  final List<String> codes;
}

/// Leest de sportwoorden uit `membership.sport` (`SportProfile::toArray()`
/// in vogels3). Nooit een sport hardcoderen: wat ontbreekt valt terug op
/// neutrale standaarden (de code zelf, geen linies).
class SportInfo {
  const SportInfo(this.raw);

  factory SportInfo.of(TeamMembership? membership) =>
      SportInfo(membership?.sport ?? const <String, dynamic>{});

  final Map<String, dynamic> raw;

  /// `positions`: code → volledige naam.
  Map<String, String> get positions {
    final value = raw['positions'];
    if (value is! Map) return const {};
    return {
      for (final entry in value.entries)
        if (entry.value is String) '${entry.key}': entry.value as String,
    };
  }

  /// De volledige naam van positie [code], of de code zelf als de sport hem
  /// niet kent; `null` zonder positie.
  String? positionLabel(String? code) {
    if (code == null || code.trim().isEmpty) return null;
    return positions[code] ?? code;
  }

  /// `position_groups`, in volgorde.
  List<PositionGroup> get positionGroups {
    final value = raw['position_groups'];
    if (value is! List) return const [];
    return [
      for (final group in value)
        if (group is Map && group['key'] is String)
          PositionGroup(
            key: group['key'] as String,
            label: group['label'] is String
                ? group['label'] as String
                : group['key'] as String,
            codes: [
              if (group['codes'] is List)
                for (final code in group['codes'] as List)
                  if (code is String) code,
            ],
          ),
    ];
  }

  /// Een sportwoord uit `terms` (bv. `goals` → "Doelpunten" bij hockey).
  String? term(String key) {
    final terms = raw['terms'];
    if (terms is! Map) return null;
    final value = terms[key];
    return value is String && value.isNotEmpty ? value : null;
  }

  /// Welke veldtekening/bal de sport gebruikt (`field_variant`), of `''`.
  String get fieldVariant {
    final value = raw['field_variant'] ?? raw['key'];
    return value is String ? value : '';
  }

  /// Houdt de sport per speler doelpunten/assists bij? Onbekend → ja.
  bool get tracksScorers {
    final value = raw['tracks_scorers'];
    return value is bool ? value : true;
  }

  /// De kaartsoorten (`card_types[].value`), of `null` als onbekend.
  Set<String>? get cardTypes {
    final value = raw['card_types'];
    if (value is! List) return null;
    return {
      for (final card in value)
        if (card is Map && card['value'] is String) card['value'] as String,
    };
  }
}
