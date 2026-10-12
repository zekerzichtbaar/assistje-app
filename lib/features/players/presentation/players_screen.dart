import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../player_management/presentation/player_management_view.dart';

/// Spelers (trainer-menu): het spelersbeheer — spelers, trainers,
/// toeschouwers en de teamlink. Tik op een speler voor zijn beheer; de
/// alleen-lezen spelerpagina (`/players/:id`) zit daar achter.
class PlayersScreen extends StatelessWidget {
  const PlayersScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      PlayerManagementView(title: AppLocalizations.of(context).navPlayers);
}
