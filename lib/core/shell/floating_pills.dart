import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../l10n/generated/app_localizations.dart';
import '../session/models/team.dart';
import '../theme/assistje_tokens.dart';
import 'nav_presentation.dart';
import 'shell_insets.dart';

/// Ronde/pilvormige glazen knopachtergrond voor de zwevende pills.
class _PillSurface extends StatelessWidget {
  const _PillSurface({required this.child, this.width});

  final Widget child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final tokens = AssistjeTokens.of(context);
    final radius = BorderRadius.circular(AssistjeTokens.radiusFull);
    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: width,
          height: ShellInsets.pillSize,
          decoration: BoxDecoration(
            borderRadius: radius,
            color: tokens.surface.withValues(alpha: 0.9),
            border: Border.all(color: tokens.line),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Linksboven: het clublogo (→ agenda), of de terugknop als het scherm een
/// ouder heeft. Beide vloeien in elkaar over, als één knop die van vorm
/// verandert.
class HomeBackPill extends StatelessWidget {
  const HomeBackPill({
    super.key,
    required this.team,
    required this.showBack,
    required this.onHome,
    required this.onBack,
  });

  final Team? team;
  final bool showBack;
  final VoidCallback onHome;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = AssistjeTokens.of(context);
    final duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : const Duration(milliseconds: 200);

    return SizedBox.square(
      dimension: ShellInsets.pillSize,
      child: AnimatedSwitcher(
        duration: duration,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1).animate(animation),
            child: child,
          ),
        ),
        child: showBack
            ? Semantics(
                key: const ValueKey('back'),
                button: true,
                label: l10n.shellBack,
                excludeSemantics: true,
                child: GestureDetector(
                  key: const Key('shell-back'),
                  onTap: onBack,
                  child: _PillSurface(
                    width: ShellInsets.pillSize,
                    child: Center(
                      child: PhosphorIcon(
                        PhosphorIconsBold.caretLeft,
                        size: 20,
                        color: tokens.ink,
                      ),
                    ),
                  ),
                ),
              )
            : Semantics(
                key: const ValueKey('home'),
                button: true,
                label: l10n.shellHome,
                excludeSemantics: true,
                child: GestureDetector(
                  key: const Key('shell-home'),
                  onTap: onHome,
                  child: _PillSurface(
                    width: ShellInsets.pillSize,
                    child: Center(child: _TeamLogo(team: team)),
                  ),
                ),
              ),
      ),
    );
  }
}

class _TeamLogo extends StatelessWidget {
  const _TeamLogo({required this.team});

  final Team? team;

  @override
  Widget build(BuildContext context) {
    final tokens = AssistjeTokens.of(context);
    final fallback = Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: tokens.primary, shape: BoxShape.circle),
      child: Text(
        initials(team?.name ?? 'Assistje'),
        style: TextStyle(
          color: tokens.primaryContrast,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
    final url = team?.logoUrl;
    if (url == null || url.isEmpty) return fallback;
    return ClipOval(
      child: Image.network(
        url,
        width: 28,
        height: 28,
        fit: team!.logoFills ? BoxFit.cover : BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => fallback,
      ),
    );
  }
}

/// Rechtsboven: bel (met ongelezen-badge) | hamburger.
class BellMenuPill extends StatelessWidget {
  const BellMenuPill({
    super.key,
    required this.unread,
    required this.onBell,
    required this.onMenu,
  });

  final int unread;
  final VoidCallback onBell;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = AssistjeTokens.of(context);

    return _PillSurface(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              button: true,
              label: l10n.shellNotificationsUnread(unread),
              excludeSemantics: true,
              child: GestureDetector(
                key: const Key('shell-bell'),
                behavior: HitTestBehavior.opaque,
                onTap: onBell,
                child: SizedBox(
                  width: 38,
                  height: ShellInsets.pillSize,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      PhosphorIcon(
                        PhosphorIconsRegular.bell,
                        size: 22,
                        color: tokens.ink,
                      ),
                      if (unread > 0)
                        Positioned(
                          top: 7,
                          right: 3,
                          child: Container(
                            key: const Key('shell-bell-badge'),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDC2626),
                              borderRadius: BorderRadius.circular(
                                AssistjeTokens.radiusFull,
                              ),
                              border: Border.all(
                                color: tokens.surface,
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              unread > 99 ? '99+' : '$unread',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9.5,
                                height: 1,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Container(width: 1, height: 20, color: tokens.line),
            Semantics(
              button: true,
              label: l10n.shellMenu,
              excludeSemantics: true,
              child: GestureDetector(
                key: const Key('shell-menu'),
                behavior: HitTestBehavior.opaque,
                onTap: onMenu,
                child: SizedBox(
                  width: 38,
                  height: ShellInsets.pillSize,
                  child: Center(
                    child: PhosphorIcon(
                      PhosphorIconsRegular.list,
                      size: 22,
                      color: tokens.ink,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
