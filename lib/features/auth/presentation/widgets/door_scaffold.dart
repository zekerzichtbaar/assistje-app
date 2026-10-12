import 'package:flutter/material.dart';

/// Kleuren van de "deur"-schermen (inloggen, onboarding): grasgroen met
/// maaistrepen, bijna-zwarte inkt en een gele actieknop (ANALYSIS §6).
abstract final class DoorColors {
  static const Color grass = Color(0xFF61F6A9);
  static const Color stripe = Color(0x0F000000);
  static const Color ink = Color(0xFF0C120D);
  static const Color action = Color(0xFFFFFF87);
  static const Color paper = Color(0xFFFFFFFF);
}

/// Scaffold voor de deur-schermen: altijd licht, ongeacht thema.
class DoorScaffold extends StatelessWidget {
  const DoorScaffold({required this.child, this.leading, super.key});

  final Widget child;

  /// Optionele knop linksboven (bv. terug).
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DoorColors.grass,
      body: CustomPaint(
        painter: const _MowingStripesPainter(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (leading != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: leading,
                ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: child,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Brede schuine banen, zoals een gemaaid veld.
class _MowingStripesPainter extends CustomPainter {
  const _MowingStripesPainter();

  static const double _band = 56;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = DoorColors.stripe;
    final span = size.width + size.height;
    for (var x = -size.height; x < span; x += _band * 2) {
      final path = Path()
        ..moveTo(x, 0)
        ..lineTo(x + _band, 0)
        ..lineTo(x + _band + size.height * 0.4, size.height)
        ..lineTo(x + size.height * 0.4, size.height)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_MowingStripesPainter oldDelegate) => false;
}

/// Kop op een deur-scherm.
class DoorHeadline extends StatelessWidget {
  const DoorHeadline(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 34,
        height: 1.05,
        fontWeight: FontWeight.w900,
        color: DoorColors.ink,
        letterSpacing: -0.5,
      ),
    );
  }
}

/// Gele pill met harde schaduw.
class DoorButton extends StatelessWidget {
  const DoorButton({
    required this.label,
    required this.onPressed,
    this.busy = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !busy;
    return Semantics(
      button: true,
      enabled: enabled,
      child: GestureDetector(
        onTap: enabled ? onPressed : null,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 120),
          opacity: onPressed == null ? 0.6 : 1,
          child: Container(
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: DoorColors.action,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: DoorColors.ink, width: 2),
              boxShadow: const [
                BoxShadow(color: DoorColors.ink, offset: Offset(0, 4)),
              ],
            ),
            child: busy
                ? const SizedBox.square(
                    dimension: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: DoorColors.ink,
                    ),
                  )
                : Text(
                    label,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: DoorColors.ink,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

/// Wit invoerveld met inktrand, passend bij de deur-stijl.
InputDecoration doorInputDecoration({required String label, String? hint}) {
  const border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide(color: DoorColors.ink, width: 2),
  );
  return InputDecoration(
    labelText: label,
    hintText: hint,
    filled: true,
    fillColor: DoorColors.paper,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    labelStyle: const TextStyle(color: Color(0x990C120D)),
    hintStyle: const TextStyle(color: Color(0x660C120D)),
    border: border,
    enabledBorder: border,
    focusedBorder: border.copyWith(
      borderSide: const BorderSide(color: DoorColors.ink, width: 3),
    ),
    errorBorder: border,
    focusedErrorBorder: border,
    counterText: '',
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
  );
}

/// Foutmelding op een deur-scherm.
class DoorError extends StatelessWidget {
  const DoorError(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: DoorColors.paper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDC2626), width: 2),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: Color(0xFFB91C1C),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
