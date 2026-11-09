import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/env.dart';
import '../session/session_providers.dart';
import '../theme/theme_providers.dart';

/// De native beoordelingsvraag, achter een interface zodat tests hem kunnen
/// vervangen.
abstract interface class ReviewRequester {
  Future<bool> isAvailable();

  /// De systeemvraag (iOS beslist zelf of hij verschijnt, max. 3× per jaar).
  Future<void> requestReview();

  /// De store-pagina, op het beoordelingstabblad (vanuit Profiel).
  Future<void> openStoreListing();
}

class InAppReviewRequester implements ReviewRequester {
  const InAppReviewRequester();

  @override
  Future<bool> isAvailable() => InAppReview.instance.isAvailable();

  @override
  Future<void> requestReview() => InAppReview.instance.requestReview();

  @override
  Future<void> openStoreListing() =>
      InAppReview.instance.openStoreListing(appStoreId: Env.iosAppStoreId);
}

final reviewRequesterProvider = Provider<ReviewRequester>(
  (ref) => const InAppReviewRequester(),
);

/// De klok van [ReviewPrompt]; tests zetten hem vast.
final reviewClockProvider = Provider<DateTime Function()>(
  (ref) => DateTime.now,
);

/// Vraagt om een beoordeling op een blij moment: een afgesloten wedstrijd,
/// een gedeelde opstelling, "ik ben erbij".
///
/// Pas na [minMoments] van zulke momenten, als de app al [minAge] op dit
/// toestel staat, en hooguit eens per [cooldown]. Nooit in een demoteam (daar
/// zit de App Review van Apple in). Een fout is nooit erg: dit mag de actie
/// zelf niet raken.
class ReviewPrompt {
  ReviewPrompt(this._ref);

  final Ref _ref;

  static const int minMoments = 3;
  static const Duration minAge = Duration(days: 3);
  static const Duration cooldown = Duration(days: 120);

  static const String firstSeenKey = 'review.first_seen';
  static const String momentsKey = 'review.moments';
  static const String lastAskedKey = 'review.last_asked';

  SharedPreferences get _prefs => _ref.read(sharedPreferencesProvider);

  /// Een blij moment. Geeft `true` als de systeemvraag is aangeroepen.
  Future<bool> positiveMoment() async {
    try {
      if (_ref.read(currentMembershipProvider)?.team.isDemo ?? true) {
        return false;
      }
      final now = _ref.read(reviewClockProvider)();
      final prefs = _prefs;

      final firstSeen = _read(firstSeenKey);
      if (firstSeen == null) {
        await prefs.setInt(firstSeenKey, now.millisecondsSinceEpoch);
      }
      final moments = (prefs.getInt(momentsKey) ?? 0) + 1;
      await prefs.setInt(momentsKey, moments);

      if (moments < minMoments) return false;
      if (firstSeen == null || now.difference(firstSeen) < minAge) {
        return false;
      }
      final lastAsked = _read(lastAskedKey);
      if (lastAsked != null && now.difference(lastAsked) < cooldown) {
        return false;
      }

      final requester = _ref.read(reviewRequesterProvider);
      if (!await requester.isAvailable()) return false;
      await prefs.setInt(lastAskedKey, now.millisecondsSinceEpoch);
      await prefs.setInt(momentsKey, 0);
      await requester.requestReview();
      return true;
    } on Object {
      return false;
    }
  }

  DateTime? _read(String key) {
    final ms = _prefs.getInt(key);
    return ms == null ? null : DateTime.fromMillisecondsSinceEpoch(ms);
  }
}

final reviewPromptProvider = Provider<ReviewPrompt>(ReviewPrompt.new);
