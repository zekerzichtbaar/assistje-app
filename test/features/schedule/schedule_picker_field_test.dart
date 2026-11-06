import 'package:assistje/features/schedule/presentation/widgets/schedule_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../core/widgets/widget_harness.dart';

void main() {
  testWidgets('starttijd en eindtijd (met wisknop) zijn even hoog', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SchedulePickerField(
              key: const ValueKey('start'),
              label: 'Starttijd',
              icon: Icons.schedule,
              value: '13:45',
              placeholder: '--:--',
              onTap: () {},
            ),
          ),
          Expanded(
            child: SchedulePickerField(
              key: const ValueKey('end'),
              label: 'Eindtijd',
              icon: Icons.schedule,
              value: '15:30',
              placeholder: '--:--',
              onTap: () {},
              onClear: () {},
              clearLabel: 'Wissen',
            ),
          ),
        ],
      ),
      dark: false,
    );
    double boxHeight(String key) => tester
        .getSize(
          find
              .descendant(
                of: find.byKey(ValueKey(key)),
                matching: find.byType(Material),
              )
              .first,
        )
        .height;
    expect(boxHeight('start'), boxHeight('end'));
    expect(boxHeight('start'), greaterThanOrEqualTo(48));
    expect(find.byKey(const ValueKey('end-clear')), findsOneWidget);
  });
}
