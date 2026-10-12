import 'package:flutter/material.dart';

import '../../attendance/presentation/attendance_view.dart';

/// De aanwezigheid van een event (trainer). De router opent dit scherm;
/// de inhoud staat in de feature `attendance`.
class EventAttendanceScreen extends StatelessWidget {
  const EventAttendanceScreen({super.key, required this.eventId});

  /// Id van het evenement uit het pad (al geparsed door de router).
  final int eventId;

  @override
  Widget build(BuildContext context) => AttendanceView(eventId: eventId);
}
