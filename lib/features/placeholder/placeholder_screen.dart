import 'package:flutter/material.dart';

import '../../core/shell/shell_insets.dart';
import '../../core/theme/assistje_tokens.dart';
import '../../l10n/generated/app_localizations.dart';

/// Eén generiek scherm voor elke bestemming die nog niet gebouwd is, zodat de
/// navigatie nu al compleet is. Latere slices vervangen de builder in de
/// router door het echte scherm.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    this.children = const [],
  });

  final String title;

  /// Extra inhoud onder de uitleg (bv. de themakeuze op de Mij-tab).
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final tokens = AssistjeTokens.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          16,
          ShellInsets.top(context),
          16,
          ShellInsets.bottom(context),
        ),
        children: [
          Semantics(
            header: true,
            child: Text(
              title,
              key: const Key('placeholder-title'),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: tokens.ink,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.placeholderBody,
            style: TextStyle(fontSize: 15, color: tokens.muted),
          ),
          ...children,
        ],
      ),
    );
  }
}
