import 'package:flutter/material.dart';

import '../../lineup/presentation/lineup_view.dart';

/// De opstelling van een wedstrijd; de inhoud woont in `features/lineup`.
class EventLineupScreen extends StatelessWidget {
  const EventLineupScreen({super.key, required this.eventId});

  /// Id van het evenement uit het pad (al geparsed door de router).
  final int eventId;

  @override
  Widget build(BuildContext context) => LineupView(eventId: eventId);
}
