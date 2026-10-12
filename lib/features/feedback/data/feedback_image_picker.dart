import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/// Een gekozen schermafbeelding voor een melding.
class PickedFeedbackImage {
  const PickedFeedbackImage({
    required this.bytes,
    required this.mimeType,
    required this.name,
  });

  final Uint8List bytes;

  /// `image/png`, `image/jpeg`, `image/webp` — of iets anders, dat de
  /// sheet dan weigert.
  final String mimeType;

  /// Bestandsnaam voor het multipart-veld.
  final String name;

  /// Wat de server accepteert (`image`: PNG, JPEG of WebP, geen HEIC).
  static const allowedTypes = {'image/png', 'image/jpeg', 'image/webp'};

  /// Max. 5 MB, zoals de server.
  static const maxBytes = 5 * 1024 * 1024;

  bool get hasAllowedType => allowedTypes.contains(mimeType);

  bool get isTooLarge => bytes.length > maxBytes;
}

/// Kiest een schermafbeelding uit de fotobibliotheek. Achter een interface
/// zodat tests de plugin niet raken.
// ignore: one_member_abstracts
abstract interface class FeedbackImagePicker {
  /// `null` als de gebruiker afbrak.
  Future<PickedFeedbackImage?> pick();
}

/// [FeedbackImagePicker] via `image_picker`. Met `imageQuality` (en een
/// maximale maat) codeert de plugin de foto opnieuw: op iOS wordt HEIC dan
/// JPEG, dus de server krijgt nooit HEIC. PNG blijft PNG (screenshots).
/// 2048 px houdt schermafbeeldingen leesbaar en ruim onder de 5 MB.
class ImagePickerFeedbackImagePicker implements FeedbackImagePicker {
  ImagePickerFeedbackImagePicker([ImagePicker? picker])
    : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  static const double maxSize = 2048;
  static const int quality = 85;

  @override
  Future<PickedFeedbackImage?> pick() async {
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
    return PickedFeedbackImage(
      bytes: bytes,
      mimeType: mimeType,
      name: fileNameFor(file.name, mimeType),
    );
  }

  /// Het MIME-type: wat de plugin meldt, anders op extensie, anders JPEG
  /// (opnieuw gecodeerde foto's komen als JPEG terug).
  static String mimeTypeFor(String? reported, String name) {
    if (reported != null && reported.startsWith('image/')) return reported;
    final lower = name.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.heic') || lower.endsWith('.heif')) return 'image/heic';
    return 'image/jpeg';
  }

  /// Een bestandsnaam met een extensie die bij [mimeType] past.
  static String fileNameFor(String name, String mimeType) {
    final base = name.trim().isEmpty ? 'schermafbeelding' : name.trim();
    final extension = switch (mimeType) {
      'image/png' => '.png',
      'image/webp' => '.webp',
      'image/jpeg' => '.jpg',
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

final feedbackImagePickerProvider = Provider<FeedbackImagePicker>(
  (ref) => ImagePickerFeedbackImagePicker(),
);
