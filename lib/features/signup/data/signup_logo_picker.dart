import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/// Een gekozen clublogo.
class PickedSignupLogo {
  const PickedSignupLogo({
    required this.bytes,
    required this.mimeType,
    required this.name,
  });

  final Uint8List bytes;

  /// `image/png`, `image/jpeg` — of iets anders, dat het scherm weigert.
  final String mimeType;

  /// Bestandsnaam voor het multipart-veld.
  final String name;

  /// Past dit binnen `limits` van `GET /signup`?
  bool fits({required List<String> mimetypes, required int maxKb}) =>
      mimetypes.contains(mimeType) && bytes.length <= maxKb * 1024;
}

/// Kiest een logo uit de fotobibliotheek. Achter een interface zodat tests
/// de plugin niet raken.
// ignore: one_member_abstracts
abstract interface class SignupLogoPicker {
  /// `null` als de gebruiker afbrak.
  Future<PickedSignupLogo?> pick();
}

/// [SignupLogoPicker] via `image_picker`. Met `imageQuality` codeert de
/// plugin opnieuw: HEIC wordt JPEG (de server neemt alleen PNG/JPEG/SVG);
/// PNG blijft PNG. 1024 px is ruim voor een logo en blijft onder 2 MB.
class ImagePickerSignupLogoPicker implements SignupLogoPicker {
  ImagePickerSignupLogoPicker([ImagePicker? picker])
    : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  static const double maxSize = 1024;
  static const int quality = 90;

  @override
  Future<PickedSignupLogo?> pick() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: maxSize,
      maxHeight: maxSize,
      imageQuality: quality,
      requestFullMetadata: false,
    );
    if (file == null) return null;
    final bytes = await file.readAsBytes();
    final mimeType = mimeTypeFor(file.mimeType, file.name);
    return PickedSignupLogo(
      bytes: bytes,
      mimeType: mimeType,
      name: fileNameFor(file.name, mimeType),
    );
  }

  /// Wat de plugin meldt, anders op extensie, anders JPEG.
  static String mimeTypeFor(String? reported, String name) {
    if (reported != null && reported.startsWith('image/')) return reported;
    final lower = name.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.svg')) return 'image/svg+xml';
    if (lower.endsWith('.heic') || lower.endsWith('.heif')) return 'image/heic';
    if (lower.endsWith('.webp')) return 'image/webp';
    return 'image/jpeg';
  }

  /// Een bestandsnaam met een extensie die bij [mimeType] past.
  static String fileNameFor(String name, String mimeType) {
    final base = name.trim().isEmpty ? 'logo' : name.trim();
    final extension = switch (mimeType) {
      'image/png' => '.png',
      'image/jpeg' => '.jpg',
      'image/svg+xml' => '.svg',
      _ => null,
    };
    if (extension == null) return base;
    final lower = base.toLowerCase();
    if (lower.endsWith(extension) ||
        (extension == '.jpg' && lower.endsWith('.jpeg'))) {
      return base;
    }
    final dot = base.lastIndexOf('.');
    return '${dot > 0 ? base.substring(0, dot) : base}$extension';
  }
}

final signupLogoPickerProvider = Provider<SignupLogoPicker>(
  (ref) => ImagePickerSignupLogoPicker(),
);
