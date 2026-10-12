import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../session/session_providers.dart';
import 'glass_tab_bar.dart';
import 'nav_items.dart';
import 'shell_insets.dart';

/// De vaste volgorde van de takken in de `StatefulShellRoute`. De Poule-tak
/// bestaat altijd; de tab is alleen zichtbaar met een poulekoppeling (en de
/// route-guard stuurt anders terug).
const List<NavItem> tabBranches = [
  NavItem.agenda,
  NavItem.stats,
  NavItem.hallOfFame,
  NavItem.poule,
  NavItem.profile,
];

/// Het tabdeel van de shell: de tak-navigators plus de glazen tabbalk.
class TabShell extends ConsumerWidget {
  const TabShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membership = ref.watch(currentMembershipProvider);
    final user = ref.watch(meProvider).value?.user;
    if (membership == null) return navigationShell;

    final items = buildTabItems(membership);
    final activeIndex = items.indexOf(
      tabBranches[navigationShell.currentIndex],
    );

    void select(int index) {
      final branch = tabBranches.indexOf(items[index]);
      final same = branch == navigationShell.currentIndex;
      if (!same) HapticFeedback.selectionClick();
      // Nogmaals op de actieve tab: terug naar de wortel van die tab.
      navigationShell.goBranch(branch, initialLocation: same);
    }

    return Stack(
      children: [
        Positioned.fill(child: navigationShell),
        Positioned(
          left: 16,
          right: 16,
          bottom: ShellInsets.tabBarBottomGap(context),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: GlassTabBar(
                key: const Key('glass-tab-bar'),
                items: items,
                activeIndex: activeIndex,
                membership: membership,
                user: user,
                onSelect: select,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
