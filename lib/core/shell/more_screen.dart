import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../l10n/generated/app_localizations.dart';
import '../auth/auth_controller.dart';
import '../router/app_routes.dart';
import '../session/session_providers.dart';
import '../theme/assistje_tokens.dart';
import '../widgets/widgets.dart';
import 'nav_items.dart';
import 'nav_presentation.dart';
import 'shell_insets.dart';
import 'team_switcher.dart';

/// De Meer-tab, het iOS-patroon voor bestemmingen die niet in de tabbalk
/// passen (vgl. Instellingen): bovenaan je profiel, dan de teamwissel, dan de
/// schermen van je rol zonder eigen tab, en onderaan Uitloggen.
///
/// Vervangt het hamburgermenu van de PWA: alles blijft zichtbaar in de
/// tabbalk-navigatie en elke rij duwt een scherm met een terug-gebaar.
class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = AssistjeTokens.of(context);
    final membership = ref.watch(currentMembershipProvider);
    final me = ref.watch(meProvider).value;
    final items = membership == null
        ? const <NavItem>[]
        : buildMenuItems(membership).where((item) => !item.isTab).toList();

    return Scaffold(
      body: ListView(
        key: const Key('more-list'),
        padding: EdgeInsets.fromLTRB(
          16,
          ShellInsets.top(context),
          16,
          ShellInsets.bottom(context),
        ),
        children: [
          Semantics(
            header: true,
            child: Text(
              l10n.navMore,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: tokens.ink,
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (me != null)
            _Group(
              children: [
                _Row(
                  key: const ValueKey('menu-profile'),
                  leading: AppAvatar(
                    name: me.user.name,
                    imageUrl: me.user.avatarUrl,
                    size: 48,
                  ),
                  title: me.user.name,
                  subtitle: me.user.email ?? l10n.navProfile,
                  semanticsLabel: '${l10n.navProfile}, ${me.user.name}',
                  onTap: () => context.push(AppRoutes.profile),
                ),
              ],
            ),
          if ((me?.teams.length ?? 0) > 1) ...[
            const SizedBox(height: 24),
            _Group(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                TeamSwitcher(onSwitched: () => context.go(AppRoutes.home)),
              ],
            ),
          ],
          if (items.isNotEmpty) ...[
            const SizedBox(height: 24),
            _Group(
              children: [
                for (final item in items)
                  _Row(
                    key: ValueKey('menu-${item.name}'),
                    leading: PhosphorIcon(
                      navIcon(item, active: false),
                      size: 24,
                      color: tokens.primary,
                    ),
                    title: navLabel(l10n, item),
                    onTap: () => context.push(item.path),
                  ),
              ],
            ),
          ],
          const SizedBox(height: 24),
          _Group(
            children: [
              _Row(
                key: const ValueKey('menu-logout'),
                title: l10n.logout,
                titleColor: StatusColors.red600,
                showChevron: false,
                onTap: () => ref.read(authControllerProvider.notifier).logout(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Een afgerond blok rijen met haarlijnen ertussen (iOS "inset grouped").
class _Group extends StatelessWidget {
  const _Group({required this.children, this.padding = EdgeInsets.zero});

  final List<Widget> children;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final tokens = AssistjeTokens.of(context);
    return AppCard(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0)
              Divider(height: 1, thickness: 1, indent: 56, color: tokens.line),
            children[i],
          ],
        ],
      ),
    );
  }
}

/// Een tikbare rij van minstens 44 pt hoog, met chevron als hij doorduwt.
class _Row extends StatelessWidget {
  const _Row({
    super.key,
    required this.title,
    required this.onTap,
    this.leading,
    this.subtitle,
    this.titleColor,
    this.semanticsLabel,
    this.showChevron = true,
  });

  final Widget? leading;
  final String title;
  final String? subtitle;
  final Color? titleColor;
  final String? semanticsLabel;
  final bool showChevron;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = AssistjeTokens.of(context);
    return Semantics(
      button: true,
      label: semanticsLabel,
      excludeSemantics: semanticsLabel != null,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 52),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                if (leading != null) ...[leading!, const SizedBox(width: 16)],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: subtitle == null
                              ? FontWeight.w500
                              : FontWeight.w600,
                          color: titleColor ?? tokens.ink,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: TextStyle(fontSize: 15, color: tokens.muted),
                        ),
                    ],
                  ),
                ),
                if (showChevron)
                  PhosphorIcon(
                    PhosphorIconsBold.caretRight,
                    size: 16,
                    color: tokens.muted,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
