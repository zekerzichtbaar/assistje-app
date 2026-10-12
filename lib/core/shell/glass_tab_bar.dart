import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../l10n/generated/app_localizations.dart';
import '../session/models/team_membership.dart';
import '../session/models/user.dart';
import '../theme/assistje_tokens.dart';
import 'nav_items.dart';
import 'nav_presentation.dart';
import 'shell_insets.dart';

/// De zwevende glazen tabbalk (`BottomNav.tsx`): blur achter de balk, een
/// glazen pil die met een veer naar de actieve tab schuift en kort uitrekt,
/// duotone-iconen die `fill` worden als ze actief zijn.
class GlassTabBar extends StatefulWidget {
  const GlassTabBar({
    super.key,
    required this.items,
    required this.activeIndex,
    required this.membership,
    required this.user,
    required this.onSelect,
  });

  final List<NavItem> items;

  /// `-1` als geen tab bij het huidige scherm hoort: dan geen pil.
  final int activeIndex;
  final TeamMembership membership;
  final User? user;
  final ValueChanged<int> onSelect;

  @override
  State<GlassTabBar> createState() => _GlassTabBarState();
}

class _GlassTabBarState extends State<GlassTabBar>
    with SingleTickerProviderStateMixin {
  /// `cubic-bezier(0.34, 1.45, 0.5, 1)`: schiet iets voorbij en veert terug.
  static const Curve _spring = Cubic(0.34, 1.45, 0.5, 1);
  static const double _padding = 10;

  late final AnimationController _squish = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
  );
  late final Animation<double> _stretch = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 1, end: 1.45), weight: 45),
    TweenSequenceItem(
      tween: Tween<double>(
        begin: 1.45,
        end: 1,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 55,
    ),
  ]).animate(_squish);

  @override
  void didUpdateWidget(GlassTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activeIndex != widget.activeIndex &&
        oldWidget.activeIndex >= 0 &&
        widget.activeIndex >= 0 &&
        !MediaQuery.disableAnimationsOf(context)) {
      _squish.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _squish.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = AssistjeTokens.of(context);
    final l10n = AppLocalizations.of(context);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final radius = BorderRadius.circular(AssistjeTokens.radiusFull);

    return Semantics(
      container: true,
      label: l10n.shellTabBar,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: tokens.glassShadow,
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: radius,
                color: tokens.glassFill,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: radius,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [tokens.glassSheenTop, tokens.glassSheenBottom],
                  ),
                  border: Border.all(color: tokens.glassEdge),
                ),
                child: SizedBox(
                  height: ShellInsets.tabBarHeight,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final slot =
                          (constraints.maxWidth - 2 * _padding) /
                          widget.items.length;
                      return Stack(
                        children: [
                          if (widget.activeIndex >= 0)
                            AnimatedPositioned(
                              key: const Key('tab-pill'),
                              duration: reduceMotion
                                  ? Duration.zero
                                  : const Duration(milliseconds: 450),
                              curve: _spring,
                              left: _padding + widget.activeIndex * slot + 2,
                              width: slot - 4,
                              top: 7,
                              bottom: 7,
                              child: AnimatedBuilder(
                                animation: _stretch,
                                builder: (context, child) => Transform.scale(
                                  scaleX: _stretch.value,
                                  child: child,
                                ),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: radius,
                                    color: tokens.control.withValues(
                                      alpha: 0.85,
                                    ),
                                    border: Border.all(color: tokens.glassRing),
                                    boxShadow: AssistjeTokens.shadowSm,
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: _padding,
                            ),
                            child: Row(
                              children: [
                                for (var i = 0; i < widget.items.length; i++)
                                  Expanded(
                                    child: _TabButton(
                                      item: widget.items[i],
                                      active: i == widget.activeIndex,
                                      membership: widget.membership,
                                      user: widget.user,
                                      onTap: () => widget.onSelect(i),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.item,
    required this.active,
    required this.membership,
    required this.user,
    required this.onTap,
  });

  final NavItem item;
  final bool active;
  final TeamMembership membership;
  final User? user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = AssistjeTokens.of(context);
    final label = tabLabel(AppLocalizations.of(context), item);

    return Semantics(
      button: true,
      selected: active,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        key: ValueKey('tab-${item.name}'),
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
              child: item == NavItem.profile
                  ? _ProfileBadge(user: user, active: active)
                  : PhosphorIcon(
                      tabIcon(membership, item, active: active),
                      size: 24,
                      color: tokens.primary,
                    ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                fontSize: 10.5,
                height: 1,
                color: active ? tokens.primary : tokens.muted,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// De Mij-tab: je avatar, of je initialen als er (nog) geen foto is.
class _ProfileBadge extends StatelessWidget {
  const _ProfileBadge({required this.user, required this.active});

  final User? user;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final tokens = AssistjeTokens.of(context);
    final fallback = Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? tokens.control : tokens.line,
        shape: BoxShape.circle,
      ),
      child: Text(
        initials(user?.name ?? ''),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: active ? tokens.ink : tokens.inkSoft,
        ),
      ),
    );
    final url = user?.avatarUrl;
    if (url == null || url.isEmpty) return fallback;
    return ClipOval(
      child: Image.network(
        url,
        width: 24,
        height: 24,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => fallback,
      ),
    );
  }
}
