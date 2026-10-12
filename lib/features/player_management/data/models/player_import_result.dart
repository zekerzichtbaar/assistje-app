/// Het antwoord van `POST players/import`: hoeveel spelers er uit de CSV
/// zijn aangemaakt, hoeveel rijen zijn overgeslagen en waarom.
class PlayerImportResult {
  const PlayerImportResult({
    required this.created,
    required this.skipped,
    this.errors = const [],
    this.message,
  });

  factory PlayerImportResult.fromJson(Map<String, dynamic> json) =>
      PlayerImportResult(
        created: (json['created'] as num?)?.toInt() ?? 0,
        skipped: (json['skipped'] as num?)?.toInt() ?? 0,
        errors: [
          for (final error in (json['errors'] as List<dynamic>?) ?? const [])
            if (error is String) error,
        ],
        message: json['message'] as String?,
      );

  /// Aangemaakte spelers.
  final int created;

  /// Overgeslagen rijen (fout of dubbel).
  final int skipped;

  /// Per overgeslagen rij de reden ("Rij 4: naam ontbreekt").
  final List<String> errors;

  /// De statusmelding van het web (hooguit 5 fouten).
  final String? message;
}
