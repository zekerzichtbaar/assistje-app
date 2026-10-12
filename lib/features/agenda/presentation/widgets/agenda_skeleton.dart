import 'package:flutter/material.dart';

import '../../../../core/widgets/widgets.dart';

/// Plaatshouders in de vorm van de agendakaarten (`MoreSkeleton` in de
/// PWA): bij het eerste laden en bij het bijladen.
class AgendaSkeleton extends StatelessWidget {
  const AgendaSkeleton({super.key, this.count = 3, this.withRsvp = true});

  final int count;
  final bool withRsvp;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('agenda-skeleton'),
      children: [
        for (var i = 0; i < count; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: AppCard(
              child: Column(
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Skeleton(width: 56, height: 56, radius: 8),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Skeleton(width: 96, height: 20, radius: 9999),
                            SizedBox(height: 8),
                            FractionallySizedBox(
                              widthFactor: 0.66,
                              child: Skeleton(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (withRsvp) ...[
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Expanded(child: Skeleton(height: 32, radius: 8)),
                        SizedBox(width: 8),
                        Expanded(child: Skeleton(height: 32, radius: 8)),
                        SizedBox(width: 8),
                        Expanded(child: Skeleton(height: 32, radius: 8)),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}
