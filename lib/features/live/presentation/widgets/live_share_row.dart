import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../player_management/application/share_service.dart';
import '../../application/live_share.dart';
import '../../data/models/live_models.dart';
import 'live_ui.dart';

/// "Laat het team live meekijken" / "Deel de uitslag met het team" met een
/// Deel-knop, onderaan het scorebord. Voor iedereen: de publieke link is er
/// juist voor het thuisfront zonder app. De PWA opent wa.me; hier het
/// systeem-deelmenu (WhatsApp is daar één van de doelen).
///
/// Leeg als er niets te delen valt (geen link, of nog niet afgetrapt).
class LiveShareRow extends ConsumerWidget {
  const LiveShareRow({super.key, required this.event, required this.teamName});

  final LiveEvent event;

  /// Terugval in het bericht als thuis- en uitteam ontbreken.
  final String teamName;

  Future<void> _share(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final message = liveShareMessage(l10n, event, teamName: teamName);
    if (message == null) return;
    unawaited(Haptics.light());
    final box = context.findRenderObject() as RenderBox?;
    final origin = box == null || !box.hasSize
        ? null
        : box.localToGlobal(Offset.zero) & box.size;
    try {
      await ref.read(shareServiceProvider).share(message, origin: origin);
    } on Object catch (error) {
      if (context.mounted) showLiveError(context, l10n.liveShareError, error);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!canShareLive(event)) return const SizedBox.shrink();
    final t = AssistjeTokens.of(context);
    final l10n = AppLocalizations.of(context);
    final ended = event.live.isEnded;
    return Padding(
      key: const ValueKey('live-share-row'),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              ended ? l10n.liveShareEndedPrompt : l10n.liveShareLivePrompt,
              key: const ValueKey('live-share-label'),
              style: TextStyle(fontSize: 12, color: t.muted),
            ),
          ),
          const SizedBox(width: 8),
          Builder(
            builder: (buttonContext) => AppButtonBase(
              key: const ValueKey('live-share'),
              label: l10n.liveShareButton,
              icon: const Icon(PhosphorIconsBold.shareNetwork, size: 16),
              background: StatusColors.emerald500,
              foreground: Colors.white,
              horizontalPadding: 14,
              onPressed: () => _share(buttonContext, ref),
            ),
          ),
        ],
      ),
    );
  }
}
