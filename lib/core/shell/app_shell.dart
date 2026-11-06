import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app_icon/app_icon_service.dart';
import '../router/app_routes.dart';
import '../session/session_providers.dart';
import 'floating_pills.dart';
import 'nav_items.dart';
import 'shell_bar.dart';
import 'shell_insets.dart';

/// De ingelogde shell rond álle ingelogde schermen (tabs én gepushte
/// schermen): de zwevende pills bovenin (logo/terug links, bel rechts). De
/// tabbalk zit een laag dieper, in `TabShell`.
class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key, required this.child});

  /// De navigator van de shell.
  final Widget child;

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  /// Titel, acties en kopkleur van het scherm dat bovenop ligt.
  final _bar = ShellBarController();

  /// Het pad van het bovenste scherm (ook als dat gepusht is).
  static String _currentPath(GoRouter router) => router.state.uri.path;

  @override
  void dispose() {
    _bar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.child;
    final router = GoRouter.of(context);
    final membership = ref.watch(currentMembershipProvider);
    final padding = MediaQuery.paddingOf(context);
    final screenBackground = Theme.of(context).scaffoldBackgroundColor;

    /// Naar meldingen: vanaf een tab gepusht; vanaf een gepusht scherm
    /// vervangt het dat scherm, zodat de stapel niet eindeloos groeit.
    void openNotifications() {
      final current = _currentPath(router);
      if (current == AppRoutes.notifications) return;
      if (isTabRoot(current)) {
        router.push<void>(AppRoutes.notifications);
      } else {
        router.pushReplacement<void>(AppRoutes.notifications);
      }
    }

    void back() {
      if (router.canPop()) {
        router.pop();
      } else {
        router.go(parentPath(membership, _currentPath(router)));
      }
    }

    return ListenableBuilder(
      listenable: Listenable.merge([router.routerDelegate, _bar]),
      builder: (context, _) {
        final path = _currentPath(router);
        final bar = _bar.data ?? const ShellBarData();
        final background = bar.background ?? screenBackground;
        final duration = MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 200);
        // Systeem-terug (knop en Android-gebaar) doet hetzelfde als de
        // terugpil: na een deep link valt er niets te poppen en zou Android
        // de app sluiten; dan naar [parentPath]. Alleen op een tabwortel
        // mag terug de app verlaten.
        //
        // Pills en tabbalk liggen buiten de Scaffolds van de schermen:
        // zonder Material-voorouder krijgt hun tekst geen DefaultTextStyle
        // (gele debug-onderstreping).
        return PopScope<Object?>(
          canPop: isTabRoot(path) || router.canPop(),
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) back();
          },
          child: Material(
            type: MaterialType.transparency,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: ShellBarScope(controller: _bar, child: child),
                ),
                // Effen veilige zone + fade achter de pills; dicht genoeg
                // dat de titel leesbaar blijft boven scrollende inhoud.
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    child: Column(
                      children: [
                        Container(height: padding.top, color: background),
                        Container(
                          height: 64,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0, 0.6, 1],
                              colors: [
                                background,
                                background.withValues(alpha: 0.92),
                                background.withValues(alpha: 0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Topbar: logo/terug, de titel van het scherm, en rechts
                // de acties (⋯) naast de bel.
                Positioned(
                  top: padding.top + ShellInsets.pillTopGap,
                  left: padding.left + 12,
                  right: padding.right + 12,
                  child: Row(
                    children: [
                      HomeBackPill(
                        team: membership?.team,
                        clubIcon: ref.watch(clubAppIconEnabledProvider),
                        showBack: !isTabRoot(path),
                        onHome: () => router.go(AppRoutes.home),
                        onBack: back,
                      ),
                      const SizedBox(width: 12),
                      // De titel vangt geen tikken: inhoud die onder de
                      // balk doorschuift blijft bereikbaar, net als vóór de
                      // titel er stond.
                      Expanded(
                        child: IgnorePointer(
                          child: AnimatedSwitcher(
                            duration: duration,
                            layoutBuilder: (current, previous) => Stack(
                              alignment: Alignment.centerLeft,
                              children: [...previous, ?current],
                            ),
                            child: KeyedSubtree(
                              key: ValueKey(bar.title),
                              child: ShellBarTitle(data: bar),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (bar.actions.isNotEmpty) ...[
                        ActionsPill(
                          single: bar.actions.length == 1
                              ? bar.actions.single
                              : null,
                          onTap: () => showShellActions(context, bar.actions),
                        ),
                        const SizedBox(width: 8),
                      ],
                      BellPill(
                        unread: membership?.unreadNotificationsCount ?? 0,
                        onBell: openNotifications,
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
  }
}
