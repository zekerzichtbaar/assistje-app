import 'package:flutter/material.dart';

import '../theme/assistje_tokens.dart';

/// Opent een iOS-stijl bottom sheet zoals `BottomSheet.tsx` in de PWA:
/// afgeronde top (24), greep, zwart/40-backdrop, max. 88% schermhoogte.
///
/// - Omlaag slepen of op de backdrop tikken sluit de sheet (tenzij
///   [isDismissible]/[enableDrag] uit staan).
/// - Safe-area-bewust: onderaan minstens de home-indicator-ruimte, en het
///   toetsenbord duwt de inhoud omhoog.
/// - [scrollable]: de inhoud scrolt binnen de sheet; titel en greep blijven staan.
///
/// Geeft de waarde terug waarmee de sheet via `Navigator.pop` sloot.
Future<T?> showAppSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  String? title,
  List<Widget>? actions,
  bool scrollable = false,
  bool isDismissible = true,
  bool enableDrag = true,
  bool useRootNavigator = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    backgroundColor: Colors.transparent,
    barrierColor: const Color(0x66000000),
    elevation: 0,
    constraints: const BoxConstraints(maxWidth: 640),
    builder: (sheetContext) => AppSheet(
      title: title,
      actions: actions,
      scrollable: scrollable,
      child: Builder(builder: builder),
    ),
  );
}

/// Het vlak van een sheet: greep, optionele titel/acties en inhoud.
///
/// Normaal via [showAppSheet]; los bruikbaar als je zelf een route bouwt.
class AppSheet extends StatelessWidget {
  const AppSheet({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.scrollable = false,
    this.padding = const EdgeInsets.fromLTRB(20, 12, 20, 0),
  });

  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final bool scrollable;
  final EdgeInsets padding;

  /// Maximale hoogte als fractie van het scherm (PWA: `max-h-[88dvh]`).
  static const double maxHeightFactor = 0.88;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final mq = MediaQuery.of(context);
    final bottomSafe = mq.viewPadding.bottom > 20
        ? mq.viewPadding.bottom
        : 20.0;

    final header = <Widget>[
      // Greep: h-1.5 w-10 rounded-full bg-line.
      Center(
        child: Container(
          key: const ValueKey('app-sheet-grabber'),
          width: 40,
          height: 6,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: t.line,
            borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
          ),
        ),
      ),
      if (title != null || (actions?.isNotEmpty ?? false))
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Expanded(
                child: title == null
                    ? const SizedBox.shrink()
                    : Text(
                        title!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: t.ink,
                        ),
                      ),
              ),
              ...?actions,
            ],
          ),
        ),
    ];

    final body = scrollable
        ? Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: bottomSafe),
              child: child,
            ),
          )
        : Padding(
            padding: EdgeInsets.only(bottom: bottomSafe),
            child: child,
          );

    return Padding(
      // Toetsenbord duwt de sheet omhoog.
      padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: (mq.size.height - mq.viewInsets.bottom) * maxHeightFactor,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: t.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AssistjeTokens.radius3xl),
            ),
            border: Border(top: BorderSide(color: t.surfaceHairline)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, -8),
                blurRadius: 28,
              ),
            ],
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: padding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [...header, body],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
