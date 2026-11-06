import 'package:flutter/material.dart';

import '../theme/assistje_tokens.dart';

/// Losse ronde chip met geselecteerd-staat (filters, keuzes).
///
/// Niet geselecteerd: `bg-sunken text-ink-soft`; geselecteerd: teamkleur met
/// contrasttekst — dezelfde verhouding als de RSVP-knoppen in de PWA.
class AppPill extends StatelessWidget {
  const AppPill({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.icon,
    this.selectedColor,
    this.selectedForeground,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final IconData? icon;

  /// Overschrijft de teamkleur als selectiekleur (bijv. een statuskleur).
  final Color? selectedColor;
  final Color? selectedForeground;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final bg = selected ? (selectedColor ?? t.primary) : t.sunken;
    final fg = selected ? (selectedForeground ?? t.primaryContrast) : t.inkSoft;
    return Semantics(
      button: onTap != null,
      selected: selected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        // Het tikvlak is 44 pt hoog; de pil zelf blijft compact.
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: onTap == null ? 0 : 6),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 16, color: fg),
                  const SizedBox(width: 6),
                ],
                // Lange labels breken af in plaats van over te lopen (grote
                // tekst), ook binnen een horizontaal scrollende rij.
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width - 96,
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: fg,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Eén tab in [AppTabPills].
@immutable
class AppTabPill<T> {
  const AppTabPill({required this.value, required this.label, this.icon});

  final T value;
  final String label;
  final IconData? icon;
}

/// Segmented control als ronde baan met pills (`TabPills.tsx`).
///
/// Baan `bg-track/60` (of vol met [darkTrack]), actieve knop `bg-control`
/// met `shadow-sm` en tekst in de teamkleur. Bij wisselen glijdt die ene
/// actieve pil naar de nieuwe tab (positie én breedte), in plaats van dat
/// de knoppen hard van kleur verspringen.
class AppTabPills<T> extends StatefulWidget {
  const AppTabPills({
    super.key,
    required this.tabs,
    required this.selected,
    required this.onChanged,
    this.fullWidth = false,
    this.darkTrack = false,
  });

  final List<AppTabPill<T>> tabs;
  final T selected;
  final ValueChanged<T> onChanged;
  final bool fullWidth;

  /// Iets donkerdere baan, voor gebruik op een grijze achtergrond.
  final bool darkTrack;

  @override
  State<AppTabPills<T>> createState() => _AppTabPillsState<T>();
}

class _AppTabPillsState<T> extends State<AppTabPills<T>> {
  /// Zacht uitlopend glijden, zonder voorbij te schieten: de pil zit tegen
  /// de rand van de baan, een overshoot zou er aan de buitenste tabs uit
  /// steken.
  static const Curve _glide = Cubic(0.2, 0.9, 0.25, 1);
  static const Duration _slide = Duration(milliseconds: 340);
  static const Duration _fade = Duration(milliseconds: 220);

  /// De baan-marge (4 pt) die bij het tikvlak hoort, niet bij de pil.
  static const double _inset = 4;

  final _rowKey = GlobalKey();
  List<GlobalKey> _keys = const [];

  /// Waar de actieve pil staat, binnen de rij; `null` tot er gemeten is.
  Rect? _pill;

  /// Alleen een tabwissel glijdt; een nieuwe maat (draaien, grotere tekst)
  /// zet de pil direct goed.
  bool _sliding = false;

  void _syncKeys() {
    if (_keys.length != widget.tabs.length) {
      _keys = List.generate(widget.tabs.length, (_) => GlobalKey());
    }
  }

  @override
  void didUpdateWidget(AppTabPills<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected && _pill != null) {
      _sliding = true;
    }
  }

  void _measure() {
    if (!mounted) return;
    final index = widget.tabs.indexWhere((t) => t.value == widget.selected);
    final row = _rowKey.currentContext?.findRenderObject() as RenderBox?;
    final item = index < 0 || index >= _keys.length
        ? null
        : _keys[index].currentContext?.findRenderObject() as RenderBox?;
    Rect? next;
    if (row != null && item != null && row.hasSize && item.hasSize) {
      final offset = item.localToGlobal(Offset.zero, ancestor: row);
      next = Rect.fromLTWH(
        offset.dx,
        offset.dy + _inset,
        item.size.width,
        item.size.height - 2 * _inset,
      );
    }
    if (next != _pill) setState(() => _pill = next);
  }

  @override
  Widget build(BuildContext context) {
    _syncKeys();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());

    final t = AssistjeTokens.of(context);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final radius = BorderRadius.circular(AssistjeTokens.radiusFull);
    final measured = _pill != null;

    Widget item(int index) {
      final tab = widget.tabs[index];
      final active = tab.value == widget.selected;
      return TweenAnimationBuilder<Color?>(
        tween: ColorTween(end: active ? t.primary : t.inkSoft),
        duration: reduceMotion ? Duration.zero : _fade,
        curve: Curves.easeOut,
        builder: (context, fg, _) {
          final label = Text(
            tab.label,
            maxLines: 1,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: fg,
            ),
          );
          final pill = Semantics(
            button: true,
            selected: active,
            child: GestureDetector(
              key: _keys[index],
              behavior: HitTestBehavior.opaque,
              onTap: () => widget.onChanged(tab.value),
              // De baan-marge (4 pt) hoort bij het tikvlak: samen 44 pt hoog.
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: _inset),
                child: Container(
                  constraints: const BoxConstraints(minHeight: 36),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  // Tot de glijdende pil gemeten is (eerste frame) tekent
                  // de actieve knop zijn eigen achtergrond.
                  decoration: active && !measured
                      ? BoxDecoration(
                          color: t.control,
                          borderRadius: radius,
                          boxShadow: AssistjeTokens.shadowSm,
                        )
                      : null,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (tab.icon != null) ...[
                        Icon(tab.icon, size: 16, color: fg),
                        const SizedBox(width: 6),
                      ],
                      if (widget.fullWidth)
                        // Vaste breedte: bij grote tekst verkleint het label
                        // binnen zijn segment, zoals een iOS-segmented control.
                        Flexible(
                          child: FittedBox(fit: BoxFit.scaleDown, child: label),
                        )
                      else
                        label,
                    ],
                  ),
                ),
              ),
            ),
          );
          return pill;
        },
      );
    }

    final children = <Widget>[];
    for (var i = 0; i < widget.tabs.length; i++) {
      if (i > 0) children.add(const SizedBox(width: 4));
      final child = item(i);
      children.add(widget.fullWidth ? Expanded(child: child) : child);
    }

    final row = Row(
      key: _rowKey,
      mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
      children: children,
    );

    final pill = _pill;
    final track = Stack(
      children: [
        if (pill != null)
          AnimatedPositioned(
            key: const ValueKey('pills-indicator'),
            duration: _sliding && !reduceMotion ? _slide : Duration.zero,
            curve: _glide,
            onEnd: () => _sliding = false,
            left: pill.left,
            top: pill.top,
            width: pill.width,
            height: pill.height,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: t.control,
                  borderRadius: radius,
                  boxShadow: AssistjeTokens.shadowSm,
                ),
              ),
            ),
          ),
        row,
      ],
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: widget.darkTrack ? t.track : t.track.withValues(alpha: 0.6),
        borderRadius: radius,
      ),
      child: widget.fullWidth
          ? track
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: track,
            ),
    );
  }
}
