import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_models.freezed.dart';
part 'feedback_models.g.dart';

/// Soort melding. `schedule` komt van "Doe dat voor mij" op de agenda (PWA),
/// niet uit het formulier; `null`/onbekend = [none].
enum FeedbackKind {
  issue,
  idea,
  schedule,
  none;

  static FeedbackKind parse(String? raw) => switch (raw) {
    'issue' => issue,
    'idea' => idea,
    'schedule' => schedule,
    _ => none,
  };
}

/// Status van een melding; onbekend telt als [received] (`new`).
enum FeedbackStatus {
  received,
  inProgress,
  resolved;

  static FeedbackStatus parse(String? raw) => switch (raw) {
    'in_progress' => inProgress,
    'resolved' => resolved,
    _ => received,
  };
}

/// Eén bericht in het gesprek onder een melding (`messages[]`).
@freezed
abstract class FeedbackMessage with _$FeedbackMessage {
  const factory FeedbackMessage({
    required int id,

    /// `uit` = van Assistje naar jou, `in` = jouw reactie.
    @Default('uit') String direction,
    @Default('') String body,
    String? createdAt,
  }) = _FeedbackMessage;

  const FeedbackMessage._();

  factory FeedbackMessage.fromJson(Map<String, dynamic> json) =>
      _$FeedbackMessageFromJson(json);

  /// Een reactie van de melder zelf.
  bool get isMine => direction == 'in';
}

/// Eén melding (`data[]` van de lijst, en de `POST`-responsen).
@freezed
abstract class FeedbackItem with _$FeedbackItem {
  const factory FeedbackItem({
    required int id,
    String? kind,
    @Default('') String body,
    String? status,

    /// Absolute URL die alleen met het bearer-token werkt, of `null`.
    String? imageUrl,
    @Default(<FeedbackMessage>[]) List<FeedbackMessage> messages,
    String? createdAt,
    String? resolvedAt,
  }) = _FeedbackItem;

  const FeedbackItem._();

  factory FeedbackItem.fromJson(Map<String, dynamic> json) =>
      _$FeedbackItemFromJson(json);

  FeedbackKind get kindValue => FeedbackKind.parse(kind);

  FeedbackStatus get statusValue => FeedbackStatus.parse(status);

  DateTime? get createdAtTime => parseFeedbackTime(createdAt);

  DateTime? get resolvedAtTime => parseFeedbackTime(resolvedAt);

  /// De afbeeldings-URL, of `null` als hij leeg is.
  String? get image {
    final value = imageUrl?.trim();
    return value == null || value.isEmpty ? null : value;
  }

  /// Reageren kan pas als er al geantwoord is (anders 422), net als de PWA
  /// die het gesprek pas toont als er berichten zijn.
  bool get canReply => messages.isNotEmpty;
}

/// ISO-tijdstip naar lokale tijd, of `null` bij leeg/ongeldig.
DateTime? parseFeedbackTime(String? iso) {
  if (iso == null || iso.isEmpty) return null;
  return DateTime.tryParse(iso)?.toLocal();
}

/// Een lijst meldingen, waarbij kapotte items worden overgeslagen.
List<FeedbackItem> parseFeedbackList(Object? raw) => [
  if (raw is List)
    for (final entry in raw)
      if (entry is Map<String, dynamic> && entry['id'] is int)
        FeedbackItem.fromJson(entry),
];
