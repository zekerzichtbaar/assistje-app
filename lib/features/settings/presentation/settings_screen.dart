import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import 'settings_view.dart';

/// Instellingen (trainer-menu): team, seizoen, deadlines, functies en
/// diensttypes van het actieve team.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      SettingsView(title: AppLocalizations.of(context).navSettings);
}
