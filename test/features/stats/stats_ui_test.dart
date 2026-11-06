import 'package:assistje/core/widgets/status_colors.dart';
import 'package:assistje/features/stats/presentation/widgets/stats_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('aanwezigheidskleur als de PWA: groen ≥ 80, amber ≥ 60, rood', () {
    expect(attendanceColor(100), StatusColors.green500);
    expect(attendanceColor(80), StatusColors.green500);
    expect(attendanceColor(79.6), StatusColors.amber500);
    expect(attendanceColor(60), StatusColors.amber500);
    expect(attendanceColor(59), StatusColors.red500);
    expect(attendanceColor(0), StatusColors.red500);
  });
}
