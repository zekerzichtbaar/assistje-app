import 'package:flutter/material.dart';

import '../../live/presentation/live_view.dart';

/// De live-wedstrijd; de inhoud woont in `features/live`.
class EventLiveScreen extends StatelessWidget {
  const EventLiveScreen({super.key, required this.eventId});

  /// Id van het evenement uit het pad (al geparsed door de router).
  final int eventId;

  @override
  Widget build(BuildContext context) => LiveView(eventId: eventId);
}
