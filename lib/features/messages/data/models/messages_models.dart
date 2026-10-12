import 'package:freezed_annotation/freezed_annotation.dart';

part 'messages_models.freezed.dart';
part 'messages_models.g.dart';

/// Een handmatig verstuurd teambericht (`messages[]`, en de `POST`-respons).
@freezed
abstract class TeamMessage with _$TeamMessage {
  const factory TeamMessage({
    required int id,
    @Default('') String title,
    @Default('') String body,

    /// Webpad (`/agenda`, `/events/412`), zelfde als `data.url` in de push.
    String? url,

    /// ISO-tijdstip; `null` zolang het bericht nog verstuurd wordt.
    String? sentAt,
    @Default(0) int recipientsCount,
    String? senderName,
  }) = _TeamMessage;

  const TeamMessage._();

  factory TeamMessage.fromJson(Map<String, dynamic> json) =>
      _$TeamMessageFromJson(json);

  DateTime? get sentAtTime => parseMessagesTime(sentAt);

  /// Het pad, of `null` als het leeg is.
  String? get link {
    final value = url?.trim();
    return value == null || value.isEmpty ? null : value;
  }
}

/// Eén automatische melding met aan/uit en eigen teksten (`auto_settings[]`,
/// en de `PATCH settings`-respons).
@freezed
abstract class AutoMessageSetting with _$AutoMessageSetting {
  const factory AutoMessageSetting({
    required String key,
    @Default('') String label,
    @Default(true) bool enabled,
    @Default('') String titleTemplate,
    @Default('') String bodyTemplate,
    @Default(<String>[]) List<String> placeholders,

    /// `false` = alleen aan/uit, geen eigen tekst.
    @Default(true) bool templated,
  }) = _AutoMessageSetting;

  const AutoMessageSetting._();

  factory AutoMessageSetting.fromJson(Map<String, dynamic> json) =>
      _$AutoMessageSettingFromJson(json);

  /// De placeholders als invoegbare tekst: `{name}`. De API geeft ze kaal
  /// (`name`) — met accolades (zoals in het doc-voorbeeld) kan ook.
  List<String> get placeholderTokens => [
    for (final raw in placeholders)
      if (raw.trim().isNotEmpty)
        '{${raw.trim().replaceAll(RegExp(r'^\{+|\}+$'), '')}}',
  ];

  /// Heeft deze melding een eigen titel of tekst?
  bool get isCustomized =>
      titleTemplate.trim().isNotEmpty || bodyTemplate.trim().isNotEmpty;
}

/// Eén automatische verzendronde (`auto_history[]`).
@freezed
abstract class AutoHistoryEntry with _$AutoHistoryEntry {
  const factory AutoHistoryEntry({
    @Default('') String type,
    @Default('') String label,
    String? title,
    String? body,
    String? sentAt,
    @Default(0) int recipientsCount,
  }) = _AutoHistoryEntry;

  const AutoHistoryEntry._();

  factory AutoHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$AutoHistoryEntryFromJson(json);

  DateTime? get sentAtTime => parseMessagesTime(sentAt);
}

/// Een kiesbare bestemming voor `url`.
@freezed
abstract class LinkTarget with _$LinkTarget {
  const factory LinkTarget({required String value, @Default('') String label}) =
      _LinkTarget;

  factory LinkTarget.fromJson(Map<String, dynamic> json) =>
      _$LinkTargetFromJson(json);
}

/// Een groep bestemmingen (`link_targets[]`): vaste pagina's of events.
@freezed
abstract class LinkTargetGroup with _$LinkTargetGroup {
  const factory LinkTargetGroup({
    @Default('') String label,
    @Default(<LinkTarget>[]) List<LinkTarget> options,
  }) = _LinkTargetGroup;

  factory LinkTargetGroup.fromJson(Map<String, dynamic> json) =>
      _$LinkTargetGroupFromJson(json);
}

/// `GET teams/{team}/messages`.
@freezed
abstract class MessagesOverview with _$MessagesOverview {
  const factory MessagesOverview({
    @Default(<TeamMessage>[]) List<TeamMessage> messages,
    @Default(<AutoMessageSetting>[]) List<AutoMessageSetting> autoSettings,
    @Default(<AutoHistoryEntry>[]) List<AutoHistoryEntry> autoHistory,
    @Default(<LinkTargetGroup>[]) List<LinkTargetGroup> linkTargets,
  }) = _MessagesOverview;

  const MessagesOverview._();

  factory MessagesOverview.fromJson(Map<String, dynamic> json) =>
      _$MessagesOverviewFromJson(json);

  /// Het label van een bekend pad uit [linkTargets], anders `null`.
  String? linkLabel(String? url) {
    if (url == null) return null;
    for (final group in linkTargets) {
      for (final option in group.options) {
        if (option.value == url) return option.label;
      }
    }
    return null;
  }
}

/// ISO-tijdstip naar lokale tijd, of `null` bij leeg/ongeldig.
DateTime? parseMessagesTime(String? iso) {
  if (iso == null || iso.isEmpty) return null;
  return DateTime.tryParse(iso)?.toLocal();
}
