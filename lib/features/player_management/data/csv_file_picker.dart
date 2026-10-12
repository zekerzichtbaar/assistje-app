import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Een gekozen CSV: naam en inhoud.
typedef CsvFile = ({String name, Uint8List bytes});

/// Kiest het CSV-bestand voor de spelersimport. Een eigen naad, zodat tests
/// geen native kiezer nodig hebben.
abstract interface class CsvFilePicker {
  /// Het gekozen bestand, of `null` als er niets gekozen is.
  Future<CsvFile?> pickCsv();
}

/// De native bestandskiezer (`file_picker`): `.csv` en `.txt`, wat de API
/// accepteert.
class PlatformCsvFilePicker implements CsvFilePicker {
  const PlatformCsvFilePicker();

  @override
  Future<CsvFile?> pickCsv() async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['csv', 'txt'],
    );
    if (file == null) return null;
    return (name: file.name, bytes: await file.readAsBytes());
  }
}

final csvFilePickerProvider = Provider<CsvFilePicker>(
  (ref) => const PlatformCsvFilePicker(),
);
