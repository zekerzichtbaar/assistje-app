import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/messages_models.dart';

/// Een nieuw teambericht.
class MessageDraft {
  const MessageDraft({required this.title, required this.body, this.url});

  final String title;
  final String body;

  /// Webpad; leeg of alleen spaties wordt weggelaten.
  final String? url;

  Map<String, Object?> toJson() {
    final link = url?.trim();
    return {
      'title': title.trim(),
      'body': body.trim(),
      if (link != null && link.isNotEmpty) 'url': link,
    };
  }
}

/// De berichten-endpoints (vogels3 `docs/api/v1/messages.md`). Alleen de
/// trainer (anders 403), alleen met feature `messages` (anders 404); veldfouten
/// 422; op een demo-team geeft schrijven 403.
class MessagesRepository {
  const MessagesRepository(this._api);

  final ApiClient _api;

  Future<MessagesOverview> fetch(int teamId) async {
    final body = await _api.get('/teams/$teamId/messages');
    return MessagesOverview.fromJson(_data(body));
  }

  /// Stuurt een push + inbox-bericht naar het hele team.
  Future<TeamMessage> send(int teamId, MessageDraft draft) async {
    final body = await _api.post(
      '/teams/$teamId/messages',
      data: draft.toJson(),
    );
    return TeamMessage.fromJson(_data(body));
  }

  /// Zet een automatische melding aan/uit en/of wijzigt de teksten. Alleen
  /// meegegeven velden gaan mee; een lege tekst betekent "standaardtekst".
  Future<AutoMessageSetting> updateSetting(
    int teamId,
    String key, {
    bool? enabled,
    String? titleTemplate,
    String? bodyTemplate,
  }) async {
    final body = await _api.patch(
      '/teams/$teamId/messages/settings',
      data: {
        'key': key,
        'enabled': ?enabled,
        if (titleTemplate != null) 'title_template': _template(titleTemplate),
        if (bodyTemplate != null) 'body_template': _template(bodyTemplate),
      },
    );
    return AutoMessageSetting.fromJson(_data(body));
  }

  /// Leeg wordt `null` (= standaardtekst).
  static String? _template(String value) =>
      value.trim().isEmpty ? null : value.trim();

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final messagesRepositoryProvider = Provider<MessagesRepository>(
  (ref) => MessagesRepository(ref.watch(apiClientProvider)),
);
