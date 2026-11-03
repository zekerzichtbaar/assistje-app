import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../router/app_routes.dart';
import '../session/session_providers.dart';
import 'floating_pills.dart';
import 'nav_items.dart';
import 'shell_insets.dart';

/// De ingelogde shell rond álle ingelogde schermen (tabs én gepushte
/// schermen): de zwevende pills bovenin (logo/terug links, bel rechts). De
/// tabbalk zit een laag dieper, in `TabShell`.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.child});

  /// De navigator van de shell.
  final Widget child;

  /// Het pad van het bovenste scherm (ook als dat gepusht is).
  static String _currentPath(GoRouter router) => router.state.uri.path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter.of(context);
    final membership = ref.watch(currentMembershipProvider);
    final padding = MediaQuery.paddingOf(context);
    final background = Theme.of(context).scaffoldBackgroundColor;

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
      listenable: router.routerDelegate,
      builder: (context, _) {
        final path = _currentPath(router);
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
                Positioned.fill(child: child),
                // Effen veilige zone + zachte fade achter de pills.
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
                  left: padding.left + 12,
                  child: HomeBackPill(
                    team: membership?.team,
                    showBack: !isTabRoot(path),
                    onHome: () => router.go(AppRoutes.home),
                    onBack: back,
                  ),
                ),
                Positioned(
                  top: padding.top + ShellInsets.pillTopGap,
                  right: padding.right + 12,
                  child: BellPill(
                    unread: membership?.unreadNotificationsCount ?? 0,
                    onBell: openNotifications,
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
