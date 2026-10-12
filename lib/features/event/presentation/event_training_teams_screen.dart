import 'package:flutter/material.dart';

import '../../training_teams/presentation/training_teams_view.dart';

/// De partijvorm van een training (trainer of `training_points`). De router
/// opent dit scherm; de inhoud staat in de feature `training_teams`.
class EventTrainingTeamsScreen extends StatelessWidget {
  const EventTrainingTeamsScreen({super.key, required this.eventId});

  /// Id van het evenement uit het pad (al geparsed door de router).
  final int eventId;

  @override
  Widget build(BuildContext context) => TrainingTeamsView(eventId: eventId);
}
