import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/// Een gekozen teamlogo.
class PickedLogo {
  const PickedLogo({required this.bytes, required this.mimeType});

  final Uint8List bytes;

  /// `image/png` of `image/jpeg`.
  final String mimeType;

  /// Als data-URI voor `POST settings/team/logo` (`logo_base64`).
  String toDataUri() => 'data:$mimeType;base64,${base64Encode(bytes)}';
}

/// Kiest een teamlogo uit de fotobibliotheek. Achter een interface zodat
/// tests de plugin niet raken.
// ignore: one_member_abstracts
abstract interface class LogoPicker {
  /// `null` als de gebruiker afbrak.
  Future<PickedLogo?> pick();
}

/// [LogoPicker] via `image_picker`. Max. 1024 px (genoeg voor het app-icoon,
/// en ruim onder de 2 MB van de server); PNG blijft PNG (transparantie).
class ImagePickerLogoPicker implements LogoPicker {
  ImagePickerLogoPicker([ImagePicker? picker])
    : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  static const double maxSize = 1024;

  @override
  Future<PickedLogo?> pick() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: maxSize,
      maxHeight: maxSize,
      imageQuality: 90,
    );
    if (file == null) return null;
    final bytes = await file.readAsBytes();
    return PickedLogo(
      bytes: bytes,
      mimeType: mimeTypeFor(file.mimeType, file.name),
    );
  }

  /// Het MIME-type: wat de plugin meldt, anders op extensie, anders JPEG.
  static String mimeTypeFor(String? reported, String name) {
    if (reported != null && reported.startsWith('image/')) return reported;
    final lower = name.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.svg')) return 'image/svg+xml';
    return 'image/jpeg';
  }
}

final logoPickerProvider = Provider<LogoPicker>(
  (ref) => ImagePickerLogoPicker(),
);
