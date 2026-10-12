import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/generated/app_localizations.dart';
import '../router/app_routes.dart';
import '../session/session_providers.dart';
import '../theme/assistje_tokens.dart';
import 'floating_pills.dart';
import 'nav_items.dart';
import 'shell_insets.dart';
import 'shell_menu.dart';

/// De ingelogde shell rond álle ingelogde schermen (tabs én gepushte
/// schermen): zwevende pills bovenin en het push-menu dat de app 80% opzij
/// schuift. De tabbalk zit een laag dieper, in `TabShell`.
class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key, required this.child});

  /// De navigator van de shell.
  final Widget child;

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell>
    with SingleTickerProviderStateMixin {
  /// Fractie van de breedte die het menu inneemt (en de app opzij schuift).
  static const double menuFraction = 0.8;

  late final AnimationController _menu = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 480),
  );
  late final Animation<double> _slide = CurvedAnimation(
    parent: _menu,
    curve: const Cubic(0.32, 0.72, 0.16, 1),
  );

  @override
  void dispose() {
    _menu.dispose();
    super.dispose();
  }

  bool get _menuOpen =>
      _menu.status == AnimationStatus.forward ||
      _menu.status == AnimationStatus.completed;

  void _openMenu() {
    HapticFeedback.lightImpact();
    if (MediaQuery.disableAnimationsOf(context)) {
      _menu.value = 1;
    } else {
      _menu.forward();
    }
  }

  void _closeMenu() {
    if (MediaQuery.disableAnimationsOf(context)) {
      _menu.value = 0;
    } else {
      _menu.reverse();
    }
  }

  /// Het pad van het bovenste scherm (ook als dat gepusht is).
  String _currentPath(GoRouter router) => router.state.uri.path;

  /// Naar [path] vanuit menu of bel: tabs wisselen van tak, al het andere
  /// wordt over de tabs heen gepusht (vanaf een gepusht scherm vervangt het
  /// dat scherm, zodat de stapel niet eindeloos groeit).
  void _navigate(String path) {
    _closeMenu();
    final router = GoRouter.of(context);
    final current = _currentPath(router);
    if (current == path) return;
    if (isTabRoot(path)) {
      router.go(path);
    } else if (isTabRoot(current)) {
      router.push<void>(path);
    } else {
      router.pushReplacement<void>(path);
    }
  }

  void _back() {
    final router = GoRouter.of(context);
    if (router.canPop()) {
      router.pop();
    } else {
      router.go(
        parentPath(ref.read(currentMembershipProvider), _currentPath(router)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final tokens = AssistjeTokens.of(context);
    final l10n = AppLocalizations.of(context);
    final membership = ref.watch(currentMembershipProvider);
    final padding = MediaQuery.paddingOf(context);
    final background = Theme.of(context).scaffoldBackgroundColor;

    return ListenableBuilder(
      listenable: router.routerDelegate,
      builder: (context, _) {
        final path = _currentPath(router);
        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            // Pills en tabbalk liggen buiten de Scaffolds van de schermen:
            // zonder Material-voorouder krijgt hun tekst geen
            // DefaultTextStyle (gele debug-onderstreping).
            return Material(
              type: MaterialType.transparency,
              child: ColoredBox(
                color: tokens.surface,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Het menu ligt rechts áchter de app.
                    AnimatedBuilder(
                      animation: _menu,
                      builder: (context, child) =>
                          _menu.value == 0 ? const SizedBox.shrink() : child!,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: width * menuFraction,
                          child: ShellMenu(
                            currentPath: path,
                            onNavigate: _navigate,
                            onClose: _closeMenu,
                            onTeamSwitched: () {
                              _closeMenu();
                              router.go(AppRoutes.home);
                            },
                          ),
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _slide,
                      builder: (context, child) {
                        final t = _slide.value;
                        return Transform.translate(
                          offset: Offset(-width * menuFraction * t, 0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28 * t),
                              boxShadow: t == 0
                                  ? null
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.25 * t,
                                        ),
                                        blurRadius: 40,
                                      ),
                                    ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(28 * t),
                              child: child,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned.fill(child: widget.child),
                          // Effen veilige zone + zachte fade achter de pills.
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: IgnorePointer(
                              child: Column(
                                children: [
                                  Container(
                                    height: padding.top,
                                    color: background,
                                  ),
                                  Container(
                                    height: 64,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          background,
                                          background.withValues(alpha: 0.85),
                                          background.withValues(alpha: 0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: padding.top + ShellInsets.pillTopGap,
                            left: 12,
                            child: HomeBackPill(
                              team: membership?.team,
                              showBack: !isTabRoot(path),
                              onHome: () => router.go(AppRoutes.home),
                              onBack: _back,
                            ),
                          ),
                          Positioned(
                            top: padding.top + ShellInsets.pillTopGap,
                            right: 12,
                            child: BellMenuPill(
                              unread: membership?.unreadNotificationsCount ?? 0,
                              onBell: () => _navigate(AppRoutes.notifications),
                              onMenu: _openMenu,
                            ),
                          ),
                          // Open menu: een tik op de app sluit het.
                          AnimatedBuilder(
                            animation: _menu,
                            builder: (context, _) => _menuOpen
                                ? Positioned.fill(
                                    child: Semantics(
                                      button: true,
                                      label: l10n.shellCloseMenu,
                                      child: GestureDetector(
                                        key: const Key('shell-menu-scrim'),
                                        behavior: HitTestBehavior.opaque,
                                        onTap: _closeMenu,
                                        onHorizontalDragEnd: (details) {
                                          if ((details.primaryVelocity ?? 0) >
                                              0) {
                                            _closeMenu();
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
