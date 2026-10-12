import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/// Waar een nieuwe profielfoto vandaan komt.
enum AvatarSource { camera, gallery }

/// Een gekozen (en al verkleinde) foto.
class PickedAvatar {
  const PickedAvatar({required this.bytes, required this.mimeType});

  final Uint8List bytes;

  /// `image/jpeg`, `image/png`, …
  final String mimeType;

  /// Als data-URI voor `POST profile/avatar` (`avatar_base64`).
  String toDataUri() => 'data:$mimeType;base64,${base64Encode(bytes)}';
}

/// Kiest een profielfoto. Achter een interface zodat tests de plugin niet
/// raken.
// ignore: one_member_abstracts
abstract interface class AvatarPicker {
  /// `null` als de gebruiker afbrak.
  Future<PickedAvatar?> pick(AvatarSource source);
}

/// [AvatarPicker] via `image_picker`. Verkleint op het toestel tot max.
/// 1024 px en JPEG-kwaliteit 82, net als de PWA (`downscaleToDataUrl`).
class ImagePickerAvatarPicker implements AvatarPicker {
  ImagePickerAvatarPicker([ImagePicker? picker])
    : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  static const double maxSize = 1024;
  static const int quality = 82;

  @override
  Future<PickedAvatar?> pick(AvatarSource source) async {
    final file = await _picker.pickImage(
      source: source == AvatarSource.camera
          ? ImageSource.camera
          : ImageSource.gallery,
      maxWidth: maxSize,
      maxHeight: maxSize,
      imageQuality: quality,
      preferredCameraDevice: CameraDevice.front,
    );
    if (file == null) return null;
    final bytes = await file.readAsBytes();
    return PickedAvatar(
      bytes: bytes,
      mimeType: mimeTypeFor(file.mimeType, file.name),
    );
  }

  /// Het MIME-type: wat de plugin meldt, anders op extensie, anders JPEG
  /// (verkleinde foto's komen als JPEG terug).
  static String mimeTypeFor(String? reported, String name) {
    if (reported != null && reported.startsWith('image/')) return reported;
    final lower = name.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.gif')) return 'image/gif';
    if (lower.endsWith('.heic')) return 'image/heic';
    if (lower.endsWith('.heif')) return 'image/heif';
    return 'image/jpeg';
  }
}

final avatarPickerProvider = Provider<AvatarPicker>(
  (ref) => ImagePickerAvatarPicker(),
);
