import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

/// Kopiëren en het systeem-deelmenu, achter een provider zodat tests ze
/// kunnen vervangen.
class ShareService {
  const ShareService();

  Future<void> copy(String text) =>
      Clipboard.setData(ClipboardData(text: text));

  /// Opent het deelmenu (WhatsApp, Berichten, …). [origin] is voor iPad.
  Future<void> share(String text, {String? subject, Rect? origin}) async {
    await SharePlus.instance.share(
      ShareParams(text: text, subject: subject, sharePositionOrigin: origin),
    );
  }
}

final shareServiceProvider = Provider<ShareService>(
  (ref) => const ShareService(),
);
