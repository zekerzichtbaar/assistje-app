import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import 'widgets/roster_view.dart';

/// Team (`Pages/Player/Team.tsx`): de selectie van het huidige team.
class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) => RosterView(
    title: AppLocalizations.of(context).navTeam,
    screenKey: 'team-screen',
  );
}
