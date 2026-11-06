import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../theme/assistje_tokens.dart';
import '../widgets/app_sheet.dart';
import '../widgets/haptics.dart';
import '../widgets/status_colors.dart';

/// Eén actie van een scherm, achter de ⋯-knop in de topbar.
class ShellAction {
  const ShellAction({
    required this.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
  });

  /// Sleutel van de menuregel (tests, en de knop in de losse balk).
  final Key key;
  final IconData icon;
  final String label;

  /// `null` = uitgeschakeld (bijvoorbeeld tijdens het opslaan).
  final VoidCallback? onTap;
  final bool destructive;

  bool _sameAs(ShellAction o) =>
      key == o.key &&
      icon == o.icon &&
      label == o.label &&
      destructive == o.destructive &&
      (onTap == null) == (o.onTap == null);
}

/// Wat een scherm in de topbar zet: titel, acties en de kleur achter de
/// pills.
@immutable
class ShellBarData {
  const ShellBarData({
    this.title,
    this.titleKey,
    this.actions = const [],
    this.background,
    this.foreground,
  });

  final String? title;
  final Key? titleKey;
  final List<ShellAction> actions;

  /// Kleur achter de pills (de veilige zone plus de fade). `null` = de
  /// schermachtergrond. De opstelling zet hier zijn groene kop, zodat die
  /// doorloopt tot boven in beeld.
  final Color? background;

  /// Kleur van de titel; `null` = inkt.
  final Color? foreground;

  bool _sameAs(ShellBarData o) {
    if (title != o.title ||
        titleKey != o.titleKey ||
        background != o.background ||
        foreground != o.foreground ||
        actions.length != o.actions.length) {
      return false;
    }
    for (var i = 0; i < actions.length; i++) {
      if (!actions[i]._sameAs(o.actions[i])) return false;
    }
    return true;
  }
}

/// Houdt bij welk scherm de topbar nu vult. Alleen het scherm dat bovenop
/// ligt (en zichtbaar is) claimt hem; zonder claim is de balk leeg.
class ShellBarController extends ChangeNotifier {
  Object? _owner;
  ShellBarData? _data;

  /// Een scherm kan na de shell opruimen (bij uitloggen gaat alles tegelijk
  /// weg); dan valt er niets meer te melden.
  bool _disposed = false;

  ShellBarData? get data => _data;

  void _claim(Object owner, ShellBarData data) {
    if (_disposed) return;
    final same =
        identical(_owner, owner) && _data != null && _data!._sameAs(data);
    _owner = owner;
    _data = data;
    // Alleen nieuwe callbacks: stil bijwerken, geen herbouw van de shell.
    if (!same) notifyListeners();
  }

  void _release(Object owner) {
    if (_disposed || !identical(_owner, owner)) return;
    _owner = null;
    _data = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

/// Geeft de [ShellBarController] van de shell door aan de schermen.
class ShellBarScope extends InheritedWidget {
  const ShellBarScope({
    super.key,
    required this.controller,
    required super.child,
  });

  final ShellBarController controller;

  static ShellBarController? maybeOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<ShellBarScope>()?.controller;

  @override
  bool updateShouldNotify(ShellBarScope oldWidget) =>
      controller != oldWidget.controller;
}

/// Zet de titel en acties van een scherm in de topbar van de shell, naast
/// de terugknop; de acties komen onder de ⋯-knop naast de bel. Zo hoeft
/// een scherm geen eigen grote titelregel meer te tekenen.
///
/// Buiten de shell (een los gepusht scherm, widgettests) tekent het zelf
/// een eenvoudige balk met titel en actieknoppen boven [child].
class ShellBar extends StatefulWidget {
  const ShellBar({
    super.key,
    this.title,
    this.titleKey,
    this.actions = const [],
    this.background,
    this.foreground,
    required this.child,
  });

  final String? title;
  final Key? titleKey;
  final List<ShellAction> actions;
  final Color? background;
  final Color? foreground;
  final Widget child;

  @override
  State<ShellBar> createState() => _ShellBarState();
}

class _ShellBarState extends State<ShellBar> {
  ShellBarController? _controller;

  ShellBarData get _data => ShellBarData(
    title: widget.title,
    titleKey: widget.titleKey,
    actions: widget.actions,
    background: widget.background,
    foreground: widget.foreground,
  );

  /// Na de frame bijwerken: de shell herbouwen tijdens de build van een
  /// scherm mag niet.
  void _sync(bool active) {
    final controller = _controller;
    if (controller == null) return;
    final data = _data;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (active && mounted) {
        controller._claim(this, data);
      } else {
        controller._release(this);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller = ShellBarScope.maybeOf(context);
    if (_controller == null) {
      return _InlineBar(data: _data, child: widget.child);
    }
    // Bovenop én zichtbaar: ModalRoute.of herbouwt als de route niet meer
    // bovenop ligt, TickerMode als de tak of route eronder verdwijnt (een
    // andere tab, of een scherm dat erover gepusht is).
    final active =
        (ModalRoute.of(context)?.isCurrent ?? true) &&
        TickerMode.valuesOf(context).enabled;
    _sync(active);
    return widget.child;
  }

  @override
  void dispose() {
    _sync(false);
    super.dispose();
  }
}

/// De titel in de topbar: één regel, afgekapt.
class ShellBarTitle extends StatelessWidget {
  const ShellBarTitle({super.key, required this.data});

  final ShellBarData data;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final title = data.title;
    if (title == null || title.isEmpty) return const SizedBox.shrink();
    return Semantics(
      header: true,
      child: Text(
        title,
        key: data.titleKey,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: data.foreground ?? t.ink,
        ),
      ),
    );
  }
}

/// Opent de acties van het scherm als lijst in een sheet.
///
/// Is er maar één actie, dan voert de ⋯ die meteen uit: een sheet met één
/// regel is een overbodige tussenstap.
Future<void> showShellActions(
  BuildContext context,
  List<ShellAction> actions, {
  String? title,
}) async {
  if (actions.length == 1) {
    actions.single.onTap?.call();
    return;
  }
  unawaited(Haptics.light());
  final picked = await showAppSheet<ShellAction>(
    context: context,
    title: title,
    builder: (sheetContext) => _ActionList(actions: actions),
  );
  picked?.onTap?.call();
}

class _ActionList extends StatelessWidget {
  const _ActionList({required this.actions});

  final List<ShellAction> actions;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Column(
      key: const ValueKey('shell-actions-sheet'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final a in actions)
          Builder(
            builder: (context) {
              final enabled = a.onTap != null;
              final dark = Theme.of(context).brightness == Brightness.dark;
              final color = a.destructive
                  ? (dark ? StatusColors.red400 : StatusColors.red600)
                  : t.ink;
              return Opacity(
                opacity: enabled ? 1 : 0.4,
                child: InkWell(
                  key: a.key,
                  borderRadius: BorderRadius.circular(AssistjeTokens.radiusLg),
                  onTap: enabled ? () => Navigator.of(context).pop(a) : null,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 52),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          PhosphorIcon(a.icon, size: 22, color: color),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              a.label,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

/// Balk voor buiten de shell: titel links, acties als ronde knoppen.
class _InlineBar extends StatelessWidget {
  const _InlineBar({required this.data, required this.child});

  final ShellBarData data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final hasTitle = data.title != null && data.title!.isNotEmpty;
    if (!hasTitle && data.actions.isEmpty) return child;
    return Material(
      color: data.background ?? t.sunken,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
              child: Row(
                children: [
                  Expanded(child: ShellBarTitle(data: data)),
                  for (final a in data.actions)
                    IconButton(
                      key: a.key,
                      tooltip: a.label,
                      onPressed: a.onTap,
                      icon: PhosphorIcon(
                        a.icon,
                        size: 20,
                        color: a.destructive
                            ? StatusColors.red600
                            : (data.foreground ?? t.ink),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
