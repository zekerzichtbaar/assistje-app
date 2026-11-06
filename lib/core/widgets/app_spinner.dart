import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Bezig-indicator met het native gezicht per platform: de iOS-"bloem"
/// ([CupertinoActivityIndicator]) op iPhone/iPad, de Material-cirkel op
/// Android.
///
/// Alleen voor onbepaald laden; een voortgangsring met een waarde blijft een
/// [CircularProgressIndicator].
class AppSpinner extends StatelessWidget {
  const AppSpinner({
    super.key,
    this.size = 20,
    this.color,
    this.strokeWidth = 2,
  });

  /// Buitenmaat (breedte = hoogte).
  final double size;
  final Color? color;

  /// Lijndikte van de Material-cirkel (niet gebruikt op iOS).
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final cupertino =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
    return SizedBox.square(
      dimension: size,
      child: cupertino
          ? CupertinoActivityIndicator(radius: size / 2, color: color)
          : CircularProgressIndicator(strokeWidth: strokeWidth, color: color),
    );
  }
}
