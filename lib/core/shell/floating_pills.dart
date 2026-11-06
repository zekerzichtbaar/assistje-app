import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../l10n/generated/app_localizations.dart';
import '../app_icon/app_icon_service.dart';
import '../session/models/team.dart';
import '../theme/assistje_tokens.dart';
import '../widgets/status_colors.dart';
import 'shell_bar.dart';
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
    required this.clubIcon,
    required this.showBack,
    required this.onHome,
    required this.onBack,
  });

  final Team? team;

  /// Het clubwapen is het app-icoon (Profiel → *App-icoon*).
  final bool clubIcon;
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
                    child: Center(
                      child: _TeamLogo(team: team, clubIcon: clubIcon),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

/// Hetzelfde beeld als het app-icoon ([desiredAppIconProvider]): met
/// [clubIcon] aan het clubwapen (zoals `tool/app_icons.dart` het inbakt, op
/// wit), anders het Assistje-icoon. Het teamlogo zelf is vaak leeg; het
/// wapen hangt aan de club.
class _TeamLogo extends StatelessWidget {
  const _TeamLogo({required this.team, required this.clubIcon});

  final Team? team;
  final bool clubIcon;

  static const double _size = 28;

  @override
  Widget build(BuildContext context) {
    final assistje = Image.asset(
      'assets/app_icon/assistje.png',
      width: _size,
      height: _size,
      fit: BoxFit.cover,
    );
    final clubId = team?.clubId;
    if (!clubIcon || clubId == null) return ClipOval(child: assistje);
    return ClipOval(
      child: Container(
        width: _size,
        height: _size,
        color: Colors.white,
        padding: const EdgeInsets.all(3),
        child: Image.network(
          AppIconService.clubLogoUrl(clubId),
          fit: BoxFit.contain,
          // Geen (leesbaar) wapen: dan is het app-icoon ook het standaardicoon.
          errorBuilder: (context, error, stackTrace) =>
              OverflowBox(maxWidth: _size, maxHeight: _size, child: assistje),
        ),
      ),
    );
  }
}

/// Rechtsboven: de bel, met ongelezen-badge.
class BellPill extends StatelessWidget {
  const BellPill({super.key, required this.unread, required this.onBell});

  final int unread;
  final VoidCallback onBell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = AssistjeTokens.of(context);

    return Semantics(
      button: true,
      label: l10n.shellNotificationsUnread(unread),
      excludeSemantics: true,
      child: GestureDetector(
        key: const Key('shell-bell'),
        behavior: HitTestBehavior.opaque,
        onTap: onBell,
        child: _PillSurface(
          width: ShellInsets.pillSize,
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
                  top: 6,
                  right: 4,
                  // Vaste chrome: de badge schaalt niet mee met grote tekst
                  // (net als de systeembadges op iOS); het aantal zit in het
                  // VoiceOver-label.
                  child: MediaQuery.withNoTextScaling(
                    child: Container(
                      key: const Key('shell-bell-badge'),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: StatusColors.red600,
                        borderRadius: BorderRadius.circular(
                          AssistjeTokens.radiusFull,
                        ),
                        border: Border.all(color: tokens.surface, width: 1.5),
                      ),
                      child: Text(
                        unread > 99 ? '99+' : '$unread',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          height: 1,
                          fontWeight: FontWeight.w700,
                        ),
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

/// Rechtsboven, naast de bel: de acties van het scherm onder een ⋯.
class ActionsPill extends StatelessWidget {
  const ActionsPill({super.key, required this.onTap, this.single});

  final VoidCallback onTap;

  /// Heeft het scherm maar één actie, dan staat die als eigen knop in de
  /// balk (met zijn eigen icoon, zoals een iOS-balkknop) in plaats van achter
  /// een ⋯ met een sheet van één regel. Uitgeschakeld = half doorzichtig.
  final ShellAction? single;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tokens = AssistjeTokens.of(context);
    final action = single;
    final enabled = action == null || action.onTap != null;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final color = action != null && action.destructive
        ? (dark ? StatusColors.red400 : StatusColors.red600)
        : tokens.ink;
    return Semantics(
      button: true,
      enabled: enabled,
      label: action?.label ?? l10n.shellActions,
      excludeSemantics: true,
      child: GestureDetector(
        key: const Key('shell-actions'),
        behavior: HitTestBehavior.opaque,
        onTap: enabled ? onTap : null,
        child: AnimatedOpacity(
          opacity: enabled ? 1 : 0.4,
          duration: const Duration(milliseconds: 150),
          child: _PillSurface(
            width: ShellInsets.pillSize,
            child: Center(
              child: action == null
                  ? PhosphorIcon(
                      PhosphorIconsBold.dotsThree,
                      size: 22,
                      color: tokens.ink,
                    )
                  // De eigen key van de actie, zodat tests en schermen hem
                  // net zo vinden als de regel in de sheet.
                  : KeyedSubtree(
                      key: action.key,
                      child: PhosphorIcon(action.icon, size: 22, color: color),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
