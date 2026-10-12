import 'package:flutter/material.dart';

import '../../report/presentation/report_view.dart';

/// Het wedstrijdverslag; de inhoud woont in `lib/features/report`. De
/// router hoeft daarvoor niet aangepast te worden.
class EventReportScreen extends StatelessWidget {
  const EventReportScreen({super.key, required this.eventId});

  /// Id van het evenement uit het pad (al geparsed door de router).
  final int eventId;

  @override
  Widget build(BuildContext context) => ReportView(eventId: eventId);
}
