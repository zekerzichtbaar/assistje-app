import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';

/// Antwoorden van de opstelling-API (vogels3 `docs/api/v1/lineup.md`), per
/// veldvariant met de formaties uit de vogels3-sportprofielen.
abstract final class LineupFixtures {
  static const lineupPath = '/teams/3/events/412/lineup';
  static const get = 'GET $lineupPath';
  static const patch = 'PATCH $lineupPath';
  static const publish = 'POST $lineupPath/publish';
  static const formation = 'PATCH $lineupPath/formation';

  static Map<String, dynamic> player(
    int id,
    String name, {
    int? shirt,
    String position = '',
    bool guest = false,
    String? fromTeam,
  }) => {
    'id': id,
    'shirt_number': shirt,
    'name': name,
    'position': position,
    'is_guest': guest,
    'from_team': fromTeam,
    'avatar_url': null,
  };

  static final Map<int, Map<String, dynamic>> players = {
    11: player(11, 'Kees de Keeper', shirt: 1, position: 'GK'),
    37: player(37, 'Sam Spits', shirt: 9, position: 'ST'),
    52: player(52, 'Gijs Gast', shirt: 20, guest: true, fromTeam: 'JO19-2'),
    60: player(60, 'Bram Back', shirt: 4, position: 'CB'),
  };

  /// Per veldvariant: formaties (key → posities) en hun labels.
  static final Map<String, Map<String, List<Map<String, dynamic>>>>
  formationsByVariant = {
    'football': {
      '4-3-3': [
        _slot('GK', 50, 92, 'K'),
        _slot('LB', 15, 72, 'LB'),
        _slot('CB', 50, 78, 'CV'),
        _slot('RB', 85, 72, 'RB'),
        _slot('CM', 50, 52, 'CM'),
        _slot('ST', 50, 22, 'SP'),
      ],
      '4-4-2': [
        _slot('GK', 50, 92, 'K'),
        _slot('CB', 50, 78, 'CV'),
        _slot('LS', 35, 22, 'LS'),
        _slot('RS', 65, 22, 'RS'),
      ],
    },
    'hockey': {
      '3-3-3-1': [
        _slot('GK', 50, 92, 'K'),
        _slot('LCB', 25, 78, 'LV'),
        _slot('CH', 50, 60, 'CH'),
        _slot('ST', 50, 20, 'SP'),
      ],
      '4-3-3': [
        _slot('GK', 50, 92, 'K'),
        _slot('LB', 15, 72, 'LV'),
        _slot('ST', 50, 20, 'SP'),
      ],
    },
    'korfball': {
      'achttal': [
        _slot('A1', 25, 12, 'A1'),
        _slot('A2', 75, 12, 'A2'),
        _slot('A3', 33, 34, 'A3'),
        _slot('A4', 67, 34, 'A4'),
        _slot('V1', 25, 88, 'V1'),
        _slot('V2', 75, 88, 'V2'),
        _slot('V3', 33, 66, 'V3'),
        _slot('V4', 67, 66, 'V4'),
      ],
      'viertal': [
        _slot('A1', 25, 12, 'A1'),
        _slot('A2', 75, 12, 'A2'),
        _slot('A3', 33, 34, 'A3'),
        _slot('A4', 67, 34, 'A4'),
      ],
    },
    'volleyball': {
      'basis': [
        _slot('P4', 22, 32, '4'),
        _slot('P3', 50, 28, '3'),
        _slot('P2', 78, 32, '2'),
        _slot('P5', 22, 68, '5'),
        _slot('P6', 50, 72, '6'),
        _slot('P1', 78, 68, '1'),
      ],
      'libero': [
        _slot('P4', 22, 32, '4'),
        _slot('P3', 50, 28, '3'),
        _slot('P2', 78, 32, '2'),
        _slot('P5', 22, 68, '5'),
        _slot('P6', 50, 72, '6'),
        _slot('P1', 78, 68, '1'),
        _slot('LIB', 50, 92, 'LIB'),
      ],
    },
  };

  static const Map<String, Map<String, String>> formationLabels = {
    'football': {'4-3-3': '1-4-3-3', '4-4-2': '1-4-4-2'},
    'hockey': {'3-3-3-1': '1-3-3-3-1', '4-3-3': '1-4-3-3'},
    'korfball': {'achttal': 'Achttal', 'viertal': 'Viertal'},
    'volleyball': {'basis': 'Basis', 'libero': 'Met libero'},
  };

  static Map<String, dynamic> _slot(String code, int x, int y, String label) =>
      {'code': code, 'x': x, 'y': y, 'label': label};

  /// De opstelling (`data`). [slots] = (slot_code, player-id); onbekende
  /// [variant]s krijgen de voetbalformaties.
  static Map<String, dynamic> data({
    String variant = 'football',
    String? formation,
    List<(String, int)> slots = const [('GK', 11), ('ST', 37)],
    int? captain = 37,
    bool canEdit = true,
    String? publishedAt,
    bool changed = false,
    List<int> pool = const [11, 37, 52, 60],
  }) {
    final formations =
        formationsByVariant[variant] ?? formationsByVariant['football']!;
    final labels = formationLabels[variant] ?? formationLabels['football']!;
    final key = formation ?? formations.keys.first;
    var slotId = 900;
    return {
      'sport': variant,
      'field_variant': variant,
      'event': {
        'id': 412,
        'title': 'VV Vogels 3 - SV Merel 2',
        'starts_at': '2026-10-12T14:30:00+02:00',
        'home_team': 'VV Vogels 3',
        'away_team': 'SV Merel 2',
      },
      'pool': [for (final id in pool) players[id]],
      'slots': [
        for (final (code, id) in slots)
          {'id': ++slotId, 'slot_code': code, 'player': players[id]},
      ],
      'formation': key,
      'formation_slots': formations[key],
      'formations': [
        for (final k in formations.keys) {'key': k, 'label': labels[k]},
      ],
      'formation_label': labels[key],
      'can_edit': canEdit,
      'captain_player_id': captain,
      'published_at': publishedAt,
      'changed_since_publish': changed,
    };
  }

  static Map<String, dynamic> response({
    String variant = 'football',
    String? formation,
    List<(String, int)> slots = const [('GK', 11), ('ST', 37)],
    int? captain = 37,
    bool canEdit = true,
    String? publishedAt,
    bool changed = false,
    List<int> pool = const [11, 37, 52, 60],
  }) => {
    'data': data(
      variant: variant,
      formation: formation,
      slots: slots,
      captain: captain,
      canEdit: canEdit,
      publishedAt: publishedAt,
      changed: changed,
      pool: pool,
    ),
  };

  /// Een `PATCH lineup`-handler die opslaat wat binnenkomt en de opstelling
  /// teruggeeft, zoals de server.
  static FakeHandler echoSave({
    String variant = 'football',
    String? publishedAt,
  }) => (request) {
    final body = request.body! as Map<String, dynamic>;
    final slots = [
      for (final slot in body['slots'] as List<dynamic>)
        (
          (slot as Map<String, dynamic>)['slot_code'] as String,
          slot['player_id'] as int,
        ),
    ];
    return FakeResponse(
      200,
      response(
        variant: variant,
        slots: slots,
        captain: body['captain_player_id'] as int?,
        publishedAt: slots.isEmpty ? null : publishedAt,
        changed: publishedAt != null && slots.isNotEmpty,
      ),
    );
  };

  /// Membership met lineup-bevoegdheid (trainer) of zonder (speler), met
  /// een sportprofiel dat positienamen meegeeft.
  static Map<String, dynamic> membership({
    bool editor = true,
    String variant = 'football',
    Map<String, String> positions = const {
      'GK': 'Keeper',
      'ST': 'Spits',
      'CB': 'Centrale verdediger',
    },
  }) => {
    ...ApiFixtures.membership(
      role: editor ? 'trainer' : 'player',
      abilities: editor ? const ['lineup'] : const [],
      fieldVariant: variant,
    ),
    'sport': {
      'key': variant,
      'label': 'Sport',
      'field_variant': variant,
      'positions': positions,
    },
  };
}
