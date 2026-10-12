import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'report_repository.dart';

/// Kiest de PDF van een scoutrapport. Een eigen naad, zodat tests geen
/// native kiezer nodig hebben.
abstract interface class ScoutFilePicker {
  /// De gekozen PDF, of `null` als er niets gekozen is.
  Future<ScoutFile?> pickPdf();
}

/// De native bestandskiezer (`file_picker`), alleen PDF's.
class PlatformScoutFilePicker implements ScoutFilePicker {
  const PlatformScoutFilePicker();

  @override
  Future<ScoutFile?> pickPdf() async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
    );
    if (file == null) return null;
    return (name: file.name, bytes: await file.readAsBytes());
  }
}

final scoutFilePickerProvider = Provider<ScoutFilePicker>(
  (ref) => const PlatformScoutFilePicker(),
);
