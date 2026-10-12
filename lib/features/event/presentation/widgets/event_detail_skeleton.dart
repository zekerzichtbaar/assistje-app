import 'package:flutter/material.dart';

import '../../../../core/widgets/widgets.dart';

/// Plaatshouders in de vorm van de eventpagina: infokaart met RSVP-knoppen,
/// de opkomst en een spelerslijst.
class EventDetailSkeleton extends StatelessWidget {
  const EventDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      key: ValueKey('event-skeleton'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(width: 110, height: 22, radius: 9999),
              SizedBox(height: 12),
              FractionallySizedBox(widthFactor: 0.6, child: Skeleton()),
              SizedBox(height: 8),
              FractionallySizedBox(widthFactor: 0.8, child: Skeleton()),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: Skeleton(height: 40, radius: 8)),
                  SizedBox(width: 8),
                  Expanded(child: Skeleton(height: 40, radius: 8)),
                  SizedBox(width: 8),
                  Expanded(child: Skeleton(height: 40, radius: 8)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        AppCard(child: Skeleton(height: 8, radius: 9999)),
        SizedBox(height: 12),
        AppCard(padding: EdgeInsets.zero, child: SkeletonList(count: 4)),
      ],
    );
  }
}
