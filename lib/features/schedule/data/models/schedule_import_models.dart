import 'dart:typed_data';

/// Een gekozen programmabestand (`.ics`, `.xlsx`, `.csv` of `.txt`).
typedef ScheduleFile = ({String name, Uint8List bytes});

/// `data` van `POST teams/{team}/schedule/import`.
class ScheduleImportResult {
  const ScheduleImportResult({
    required this.created,
    required this.updated,
    required this.skipped,
    required this.duties,
    required this.dryRun,
    required this.messages,
    required this.message,
  });

  factory ScheduleImportResult.fromJson(Map<String, dynamic> json) =>
      ScheduleImportResult(
        created: _int(json['created']),
        updated: _int(json['updated']),
        skipped: _int(json['skipped']),
        duties: _int(json['duties']),
        dryRun: json['dry_run'] == true,
        messages: switch (json['messages']) {
          final List<Object?> list => [for (final m in list) '$m'],
          _ => const [],
        },
        message: json['message'] is String ? json['message'] as String : '',
      );

  final int created;
  final int updated;
  final int skipped;
  final int duties;
  final bool dryRun;

  /// Meldingen van de importer ("Rij 7: datum onleesbaar").
  final List<String> messages;

  /// De statusmelding van het web, klaar om te tonen.
  final String message;
}

/// `data` van `fetch` (`queued`), `request` (`requested`) en `feed`
/// (`imported`).
class ScheduleActionResult {
  const ScheduleActionResult({
    required this.status,
    required this.message,
    this.scheduleFeedUrl,
  });

  factory ScheduleActionResult.fromJson(Map<String, dynamic> json) =>
      ScheduleActionResult(
        status: json['status'] is String ? json['status'] as String : '',
        message: json['message'] is String ? json['message'] as String : '',
        scheduleFeedUrl: json['schedule_feed_url'] is String
            ? json['schedule_feed_url'] as String
            : null,
      );

  final String status;
  final String message;
  final String? scheduleFeedUrl;
}

/// `sport.federation_import` uit `/me` (`SportProfile::federationImport()`):
/// de bron van deze sport, zodat er bij een volleybalteam niet "voetbal.nl"
/// staat. `null` bij een sport zonder bekende bron.
class FederationImport {
  const FederationImport({this.method, this.name, this.hint, this.example});

  /// Leest `sport['federation_import']`; `null` als die er niet is.
  static FederationImport? fromSport(Map<String, dynamic> sport) {
    final raw = sport['federation_import'];
    if (raw is! Map) return null;
    String? str(Object? v) => v is String && v.trim().isNotEmpty ? v : null;
    return FederationImport(
      method: str(raw['method']),
      name: str(raw['name']),
      hint: str(raw['hint']),
      example: str(raw['example']),
    );
  }

  /// `paste` of `feed`.
  final String? method;

  /// Bijv. `voetbal.nl`.
  final String? name;
  final String? hint;
  final String? example;
}

/// `schedule_feed` uit de agenda: de agendalink bij een feed-sport, en of de
/// laatste poging geen wedstrijden gaf.
class ScheduleFeedState {
  const ScheduleFeedState({this.url, this.failed = false});

  /// Leest `schedule_feed`; `null` bij een sport zonder feed.
  static ScheduleFeedState? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    final url = json['url'];
    return ScheduleFeedState(
      url: url is String && url.isNotEmpty ? url : null,
      failed: json['failed'] == true,
    );
  }

  final String? url;
  final bool failed;
}

/// `schedule_request` uit de agenda.
enum ScheduleRequestState {
  /// De trainer mag het programma bij ons aanvragen.
  available,

  /// Er staat al een verzoek open.
  pending;

  /// `null` bij een team zonder dit aanbod.
  static ScheduleRequestState? parse(String? raw) => switch (raw) {
    'available' => available,
    'pending' => pending,
    _ => null,
  };
}

int _int(Object? raw) => raw is num ? raw.toInt() : 0;
