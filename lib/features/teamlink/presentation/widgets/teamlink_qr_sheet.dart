import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// De QR-code van de teamlink in een sheet: één moment in de kleedkamer —
/// ophouden, iedereen scant, weer weg.
Future<void> showTeamLinkQrSheet(
  BuildContext context, {
  required String url,
  required String teamName,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<void>(
    context: context,
    title: l10n.pmTlQrTitle,
    builder: (context) => TeamLinkQr(url: url, teamName: teamName),
  );
}

/// De QR op een witte ondergrond (ook in dark mode: een QR op een donker
/// vlak leest geen camera).
class TeamLinkQr extends StatelessWidget {
  const TeamLinkQr({super.key, required this.url, required this.teamName});

  final String url;
  final String teamName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AssistjeTokens.radius2xl),
          ),
          child: QrImageView(
            key: const ValueKey('tl-qr'),
            data: url,
            size: 224,
            padding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            errorCorrectionLevel: QrErrorCorrectLevel.M,
            semanticsLabel: l10n.pmTlQrLabel(teamName),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          l10n.pmTlQrHint,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: t.muted),
        ),
      ],
    );
  }
}
