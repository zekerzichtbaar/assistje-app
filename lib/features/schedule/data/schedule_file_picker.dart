import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/schedule_import_models.dart';

/// Kiest het programmabestand voor de import. Een eigen naad, zodat tests
/// geen native kiezer nodig hebben.
abstract interface class ScheduleFilePicker {
  /// Het gekozen bestand, of `null` als er niets gekozen is.
  Future<ScheduleFile?> pick();
}

/// De extensies die de server leest (`.txt`: formaat uit de inhoud geraden).
const scheduleFileExtensions = ['ics', 'xlsx', 'csv', 'txt'];

/// De native bestandskiezer (`file_picker`).
class PlatformScheduleFilePicker implements ScheduleFilePicker {
  const PlatformScheduleFilePicker();

  @override
  Future<ScheduleFile?> pick() async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: scheduleFileExtensions,
    );
    if (file == null) return null;
    return (name: file.name, bytes: await file.readAsBytes());
  }
}

final scheduleFilePickerProvider = Provider<ScheduleFilePicker>(
  (ref) => const PlatformScheduleFilePicker(),
);
