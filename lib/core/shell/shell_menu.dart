import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../l10n/generated/app_localizations.dart';
import '../auth/auth_controller.dart';
import '../router/app_routes.dart';
import '../session/session_providers.dart';
import '../theme/assistje_tokens.dart';
import 'nav_items.dart';
import 'nav_presentation.dart';
import 'team_switcher.dart';

/// De inhoud van het push-menu: teamwissel, de menu-items van de rol en
/// onderaan je naam, Profiel en Uitloggen (als de PWA).
class ShellMenu extends ConsumerWidget {
  const ShellMenu({
    super.key,
    required this.currentPath,
    required this.onNavigate,
    required this.onTeamSwitched,
    required this.onClose,
  });

  final String currentPath;
  final ValueChanged<String> onNavigate;
  final VoidCallback onTeamSwitched;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = AssistjeTokens.of(context);
    final membership = ref.watch(currentMembershipProvider);
    final me = ref.watch(meProvider).value;
    final items = membership == null
        ? const <NavItem>[]
        : buildMenuItems(membership);
    final padding = MediaQuery.paddingOf(context);

    bool isActive(String path) =>
        currentPath == path || currentPath.startsWith('$path/');

    return Material(
      color: tokens.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              key: const Key('shell-menu-list'),
              padding: EdgeInsets.fromLTRB(
                8,
                (padding.top < 16 ? 16 : padding.top) + 8,
                8,
                8,
              ),
              children: [
                if ((me?.teams.length ?? 0) > 1) ...[
                  TeamSwitcher(onSwitched: onTeamSwitched),
                  Divider(height: 24, color: tokens.line),
                ],
                for (final item in items)
                  _MenuTile(
                    key: ValueKey('menu-${item.name}'),
                    icon: navIcon(item, active: isActive(item.path)),
                    label: navLabel(l10n, item),
                    active: isActive(item.path),
                    onTap: () => onNavigate(item.path),
                  ),
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: tokens.line)),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                8,
                16,
                8,
                padding.bottom < 12 ? 12 : padding.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (me != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            me.user.name,
                            style: TextStyle(
                              color: tokens.ink,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (me.user.email != null)
                            Text(
                              me.user.email!,
                              style: TextStyle(
                                color: tokens.muted,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    ),
                  _MenuTile(
                    key: const ValueKey('menu-profile'),
                    icon: PhosphorIconsDuotone.user,
                    label: l10n.screenProfile,
                    active: false,
                    onTap: () => onNavigate(AppRoutes.profile),
                  ),
                  _MenuTile(
                    key: const Key('menu-logout'),
                    icon: PhosphorIconsDuotone.signOut,
                    label: l10n.logout,
                    active: false,
                    onTap: () {
                      onClose();
                      ref.read(authControllerProvider.notifier).logout();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    super.key,
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = AssistjeTokens.of(context);
    return Semantics(
      selected: active,
      child: Material(
        color: active ? tokens.sunken : Colors.transparent,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
        child: InkWell(
          borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                PhosphorIcon(
                  icon,
                  size: 20,
                  color: active ? tokens.primary : tokens.muted,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: active ? tokens.ink : tokens.inkSoft,
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
