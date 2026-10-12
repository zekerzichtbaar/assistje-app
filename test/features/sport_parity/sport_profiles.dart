import 'dart:convert';

/// De vier sportprofielen precies zoals vogels3 ze via de API meestuurt
/// (`membership.sport` in `/me` = `SportProfile::toArray()`), letterlijk
/// gedumpt uit `Sport::cases()` (vogels3 `app/Sports/*Profile.php`).
/// Werk dit bij als een profiel daar verandert; de pariteitstests lezen
/// hun verwachtingen hieruit, niet uit vaste sportnamen.
abstract final class SportProfiles {
  /// Sleutel (`football`, `hockey`, …) → profiel. Elke aanroep een verse
  /// kopie, zodat een test het profiel kan aanpassen zonder de rest te raken.
  static Map<String, Map<String, dynamic>> all() => {
    for (final entry in (jsonDecode(_json) as Map<String, dynamic>).entries)
      entry.key: entry.value as Map<String, dynamic>,
  };

  static Map<String, dynamic> of(String key) => all()[key]!;

  static const _json = r'''
{
  "football": {
    "key": "football",
    "label": "Voetbal",
    "field_variant": "football",
    "score_model": "goals",
    "match_stats_mode": "timeline",
    "supports_live_clock": true,
    "supports_federation_import": true,
    "federation_import": {
      "method": "paste",
      "name": "voetbal.nl",
      "hint": "Uit de URL van de programmapagina: voetbal.nl/team/T429576725/programma/competitie",
      "example": "T429576725"
    },
    "designation": {
      "word": "elftal",
      "question": "Welk elftal?",
      "hint": "Zoals het bij de club heet, bijvoorbeeld 3, JO17-1 of Zaterdag 2",
      "example": "3"
    },
    "supports_flag_duty": true,
    "tracks_scorers": true,
    "allows_draw": true,
    "tracks_playing_time": true,
    "periods": {
      "count": 2,
      "label": "Helft",
      "plural": "Helften",
      "minutes": 45,
      "boundaries": [
        45,
        90
      ]
    },
    "positions": {
      "K": "Keeper",
      "RB": "Rechtsback",
      "CB": "Centrale verdediger",
      "LB": "Linksback",
      "DM": "Verdedigende middenvelder",
      "CM": "Centrale middenvelder",
      "AM": "Aanvallende middenvelder",
      "RW": "Rechtsbuiten",
      "ST": "Spits",
      "LW": "Linksbuiten",
      "GK": "Keeper"
    },
    "position_groups": [
      {
        "key": "gk",
        "label": "Keepers",
        "codes": [
          "K",
          "GK"
        ]
      },
      {
        "key": "def",
        "label": "Verdedigers",
        "codes": [
          "RB",
          "CB",
          "LB"
        ]
      },
      {
        "key": "mid",
        "label": "Middenvelders",
        "codes": [
          "DM",
          "CM",
          "AM"
        ]
      },
      {
        "key": "att",
        "label": "Aanvallers",
        "codes": [
          "RW",
          "ST",
          "LW"
        ]
      }
    ],
    "terms": {
      "goal": "Goal",
      "goals": "Goals",
      "scorer": "Doelpuntenmaker",
      "assist": "Assist",
      "assists": "Assists",
      "keeper": "Keeper",
      "period": "Helft",
      "periods": "Helften"
    },
    "card_types": [
      {
        "value": "yellow",
        "label": "Gele kaart"
      },
      {
        "value": "red",
        "label": "Rode kaart"
      }
    ],
    "tracks_penalties": true,
    "moment_types": [
      {
        "value": "penalty_missed",
        "label": "Penalty gemist"
      },
      {
        "value": "penalty_saved",
        "label": "Penalty gestopt"
      },
      {
        "value": "woodwork",
        "label": "Paal of lat"
      }
    ]
  },
  "hockey": {
    "key": "hockey",
    "label": "Hockey",
    "field_variant": "hockey",
    "score_model": "goals",
    "match_stats_mode": "timeline",
    "supports_live_clock": true,
    "supports_federation_import": true,
    "federation_import": {
      "method": "feed",
      "name": "clubagenda",
      "hint": "hockey.nl heeft geen export per team. Gebruik de iCal-link van de agenda op de site van je club.",
      "example": "https://mijnclub.nl/agenda/team/h1.ics"
    },
    "designation": {
      "word": "team",
      "question": "Welk team?",
      "hint": "Zoals het bij de club heet, bijvoorbeeld Heren 3, Dames 1 of JB1",
      "example": "Heren 3"
    },
    "supports_flag_duty": false,
    "tracks_scorers": true,
    "allows_draw": true,
    "tracks_playing_time": true,
    "periods": {
      "count": 4,
      "label": "Kwart",
      "plural": "Kwarten",
      "minutes": 17,
      "boundaries": [
        17,
        34,
        51,
        70
      ]
    },
    "positions": {
      "K": "Keeper",
      "LV": "Linksachter",
      "LM": "Laatste man",
      "RV": "Rechtsachter",
      "LH": "Linkshalf",
      "CH": "Centrale middenvelder",
      "RH": "Rechtshalf",
      "LA": "Linksvoor",
      "CA": "Centrale aanvaller",
      "RA": "Rechtsvoor",
      "SP": "Spits"
    },
    "position_groups": [
      {
        "key": "gk",
        "label": "Keepers",
        "codes": [
          "K"
        ]
      },
      {
        "key": "def",
        "label": "Verdedigers",
        "codes": [
          "LV",
          "LM",
          "RV"
        ]
      },
      {
        "key": "mid",
        "label": "Middenveld",
        "codes": [
          "LH",
          "CH",
          "RH"
        ]
      },
      {
        "key": "att",
        "label": "Aanvallers",
        "codes": [
          "LA",
          "CA",
          "RA",
          "SP"
        ]
      }
    ],
    "terms": {
      "goal": "Doelpunt",
      "goals": "Doelpunten",
      "scorer": "Doelpuntenmaker",
      "assist": "Assist",
      "assists": "Assists",
      "keeper": "Keeper",
      "period": "Kwart",
      "periods": "Kwarten"
    },
    "card_types": [
      {
        "value": "green",
        "label": "Groene kaart"
      },
      {
        "value": "yellow",
        "label": "Gele kaart"
      },
      {
        "value": "red",
        "label": "Rode kaart"
      }
    ],
    "tracks_penalties": true,
    "moment_types": [
      {
        "value": "penalty_missed",
        "label": "Penalty gemist"
      },
      {
        "value": "penalty_saved",
        "label": "Penalty gestopt"
      },
      {
        "value": "woodwork",
        "label": "Paal of lat"
      }
    ]
  },
  "volleyball": {
    "key": "volleyball",
    "label": "Volleybal",
    "field_variant": "volleyball",
    "score_model": "sets",
    "match_stats_mode": "postmatch",
    "supports_live_clock": false,
    "supports_federation_import": true,
    "federation_import": {
      "method": "feed",
      "name": "volleybal.nl",
      "hint": "Op de teampagina van volleybal.nl onder \"Toevoegen aan kalender\": kopieer de iCal-link.",
      "example": "https://api.nevobo.nl/export/team/CKL8Y9N/dames/3/programma.ics"
    },
    "designation": {
      "word": "team",
      "question": "Welk team?",
      "hint": "Zoals het bij de club heet, bijvoorbeeld DS1, HS2 of MC1",
      "example": "DS1"
    },
    "supports_flag_duty": false,
    "tracks_scorers": false,
    "allows_draw": false,
    "tracks_playing_time": false,
    "periods": {
      "count": 5,
      "label": "Set",
      "plural": "Sets",
      "minutes": null,
      "boundaries": []
    },
    "positions": {
      "SV": "Spelverdeler",
      "MID": "Midden",
      "PL": "Passer-loper",
      "DIA": "Diagonaal",
      "LIB": "Libero"
    },
    "position_groups": [
      {
        "key": "sv",
        "label": "Spelverdelers",
        "codes": [
          "SV"
        ]
      },
      {
        "key": "mid",
        "label": "Middens",
        "codes": [
          "MID"
        ]
      },
      {
        "key": "pl",
        "label": "Passer-lopers",
        "codes": [
          "PL"
        ]
      },
      {
        "key": "dia",
        "label": "Diagonalen",
        "codes": [
          "DIA"
        ]
      },
      {
        "key": "lib",
        "label": "Libero's",
        "codes": [
          "LIB"
        ]
      }
    ],
    "terms": {
      "goal": "Punt",
      "goals": "Punten",
      "scorer": "Puntenmaker",
      "assist": "Set-up",
      "assists": "Set-ups",
      "keeper": "Libero",
      "period": "Set",
      "periods": "Sets"
    },
    "card_types": [],
    "tracks_penalties": false,
    "moment_types": []
  },
  "korfball": {
    "key": "korfball",
    "label": "Korfbal",
    "field_variant": "korfball",
    "score_model": "goals",
    "match_stats_mode": "timeline",
    "supports_live_clock": true,
    "supports_federation_import": true,
    "federation_import": {
      "method": "feed",
      "name": "clubagenda",
      "hint": "Gebruik de iCal-link van de agenda op de site van je club: korfbal.nl biedt geen export per team.",
      "example": "https://mijnclub.nl/agenda/team/1.ics"
    },
    "designation": {
      "word": "team",
      "question": "Welk team?",
      "hint": "Zoals het bij de club heet, bijvoorbeeld 2, A1 of B1",
      "example": "2"
    },
    "supports_flag_duty": false,
    "tracks_scorers": true,
    "allows_draw": true,
    "tracks_playing_time": true,
    "periods": {
      "count": 2,
      "label": "Helft",
      "plural": "Helften",
      "minutes": 30,
      "boundaries": [
        30,
        60
      ]
    },
    "positions": {
      "SCH": "Schutter",
      "DL": "Doorloper",
      "REB": "Rebounder",
      "ALL": "Allround"
    },
    "position_groups": [
      {
        "key": "sch",
        "label": "Schutters",
        "codes": [
          "SCH"
        ]
      },
      {
        "key": "dl",
        "label": "Doorlopers",
        "codes": [
          "DL"
        ]
      },
      {
        "key": "reb",
        "label": "Rebounders",
        "codes": [
          "REB"
        ]
      },
      {
        "key": "all",
        "label": "Allround",
        "codes": [
          "ALL"
        ]
      }
    ],
    "terms": {
      "goal": "Doelpunt",
      "goals": "Doelpunten",
      "scorer": "Doelpuntenmaker",
      "assist": "Assist",
      "assists": "Assists",
      "period": "Helft",
      "periods": "Helften"
    },
    "card_types": [
      {
        "value": "yellow",
        "label": "Gele kaart"
      },
      {
        "value": "red",
        "label": "Rode kaart"
      }
    ],
    "tracks_penalties": true,
    "moment_types": [
      {
        "value": "penalty_missed",
        "label": "Penalty gemist"
      },
      {
        "value": "penalty_saved",
        "label": "Penalty gestopt"
      },
      {
        "value": "woodwork",
        "label": "Paal of lat"
      }
    ]
  }
}
''';
}
