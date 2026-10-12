import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../theme/assistje_tokens.dart';
import 'status_colors.dart';

/// Soort toast; bepaalt alleen het icoon en de kleur ervan.
enum AppToastVariant { success, error, info }

/// Handvat om een getoonde toast eerder te sluiten.
class AppToastHandle {
  AppToastHandle._(this._key);

  final GlobalKey<_ToastHostState> _key;

  /// Start de uit-animatie en verwijdert de toast daarna.
  void dismiss() => _key.currentState?.dismiss();
}

OverlayEntry? _activeEntry;
GlobalKey<_ToastHostState>? _activeKey;

/// Toont een zwevende toast bovenaan het scherm (`Toast.tsx`), die na
/// [duration] (standaard 4 s) vanzelf verdwijnt. Een nieuwe toast vervangt
/// een eventuele vorige.
///
/// Alle tekst komt van de aanroeper: [title] (bijv. "Opgeslagen"), [message]
/// en [closeLabel] voor de sluitknop (schermlezer).
AppToastHandle showAppToast(
  BuildContext context, {
  required String title,
  String? message,
  AppToastVariant variant = AppToastVariant.success,
  Duration duration = const Duration(seconds: 4),
  String? closeLabel,
}) {
  _removeActive();
  final overlay = Overlay.of(context, rootOverlay: true);
  final key = GlobalKey<_ToastHostState>();
  late final OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => _ToastHost(
      key: key,
      title: title,
      message: message,
      variant: variant,
      duration: duration,
      closeLabel: closeLabel,
      onGone: () {
        if (identical(_activeEntry, entry)) {
          _activeEntry = null;
          _activeKey = null;
        }
        if (entry.mounted) entry.remove();
      },
    ),
  );
  _activeEntry = entry;
  _activeKey = key;
  overlay.insert(entry);
  return AppToastHandle._(key);
}

void _removeActive() {
  final entry = _activeEntry;
  _activeEntry = null;
  _activeKey = null;
  if (entry != null && entry.mounted) entry.remove();
}

/// Sluit de huidige toast direct (zonder animatie), bijv. bij uitloggen.
void hideAppToast() => _removeActive();

/// Is er nu een toast zichtbaar? (Vooral voor tests.)
bool get isAppToastVisible => _activeKey?.currentState != null;

class _ToastHost extends StatefulWidget {
  const _ToastHost({
    super.key,
    required this.title,
    required this.message,
    required this.variant,
    required this.duration,
    required this.closeLabel,
    required this.onGone,
  });

  final String title;
  final String? message;
  final AppToastVariant variant;
  final Duration duration;
  final String? closeLabel;
  final VoidCallback onGone;

  @override
  State<_ToastHost> createState() => _ToastHostState();
}

class _ToastHostState extends State<_ToastHost>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Timer? _timer;
  bool _dismissing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();
    _timer = Timer(widget.duration, dismiss);
  }

  void dismiss() {
    final controller = _controller;
    if (_dismissing || controller == null || !mounted) return;
    _dismissing = true;
    _timer?.cancel();
    controller.reverse().whenCompleteOrCancel(() {
      if (mounted) widget.onGone();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final mq = MediaQuery.of(context);
    final top = mq.viewPadding.top > 16 ? mq.viewPadding.top : 16.0;
    final curved = CurvedAnimation(
      parent: _controller!,
      curve: const Cubic(0.16, 1, 0.3, 1),
    );

    final (IconData icon, Color color) = switch (widget.variant) {
      AppToastVariant.success => (
        PhosphorIconsFill.checkCircle,
        StatusColors.success,
      ),
      AppToastVariant.error => (
        PhosphorIconsFill.warningCircle,
        StatusColors.error,
      ),
      AppToastVariant.info => (PhosphorIconsFill.info, StatusColors.info),
    };

    final card = Container(
      constraints: const BoxConstraints(maxWidth: 384),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(AssistjeTokens.radius2xl),
        border: Border.all(color: t.line),
        boxShadow: AssistjeTokens.shadowMd,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PhosphorIcon(icon, size: 24, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.w600, color: t.ink),
                ),
                if (widget.message != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      widget.message!,
                      style: TextStyle(fontSize: 14, color: t.inkSoft),
                    ),
                  ),
              ],
            ),
          ),
          Semantics(
            container: true,
            button: true,
            label: widget.closeLabel,
            child: GestureDetector(
              key: const ValueKey('app-toast-close'),
              behavior: HitTestBehavior.opaque,
              onTap: dismiss,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: PhosphorIcon(
                  PhosphorIconsRegular.x,
                  size: 18,
                  color: t.muted,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Positioned(
      top: top,
      left: 16,
      right: 16,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Center(
          child: FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween(
                begin: const Offset(0, -0.15),
                end: Offset.zero,
              ).animate(curved),
              child: Material(
                type: MaterialType.transparency,
                child: Semantics(liveRegion: true, child: card),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
