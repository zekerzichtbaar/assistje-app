import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/app_icon/app_icon_service.dart';
import '../../../../core/app_icon/club_logo_repository.dart';
import '../../../../core/auth/auth_controller.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/session/models/team.dart';
import '../../../../core/session/session_providers.dart';
import '../../../../core/shell/team_switcher.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/theme/theme_providers.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import 'profile_ui.dart';

/// Het actieve team en je rol; met meer teams opent een tik de
/// teamwisselaar.
class TeamCard extends ConsumerWidget {
  const TeamCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final current = ref.watch(currentMembershipProvider);
    final teams = ref.watch(meProvider).value?.teams ?? const [];
    if (current == null) return const SizedBox.shrink();
    final canSwitch = teams.length > 1;

    return AppCard(
      key: const ValueKey('profile-team'),
      onTap: canSwitch
          ? () {
              unawaited(Haptics.light());
              unawaited(
                showAppSheet<void>(
                  context: context,
                  scrollable: true,
                  builder: (sheetContext) => TeamSwitcher(
                    onSwitched: () => Navigator.of(sheetContext).pop(),
                  ),
                ),
              );
            }
          : null,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  current.team.name,
                  key: const Key('profile-team-name'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: t.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  roleLabel(l10n, current.role),
                  style: TextStyle(fontSize: 13, color: t.muted),
                ),
              ],
            ),
          ),
          if (canSwitch)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.profileTeamSwitch,
                  key: const ValueKey('profile-team-switch'),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: t.primary,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  PhosphorIconsRegular.arrowsLeftRight,
                  size: 16,
                  color: t.primary,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

/// Licht, donker of het toestel volgen (`ThemeCard` in de PWA).
class ThemeCard extends ConsumerWidget {
  const ThemeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final choice = ref.watch(themeModeProvider);
    final options = [
      (ThemeMode.light, l10n.themeModeLight, l10n.profileThemeLightHint),
      (ThemeMode.dark, l10n.themeModeDark, l10n.profileThemeDarkHint),
      (ThemeMode.system, l10n.themeModeSystem, l10n.profileThemeSystemHint),
    ];

    return AppCard(
      key: const ValueKey('profile-theme'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileCardHeader(title: l10n.profileThemeTitle),
          const SizedBox(height: 12),
          Row(
            children: [
              for (final (index, (mode, label, hint)) in options.indexed) ...[
                if (index > 0) const SizedBox(width: 8),
                Expanded(
                  child: _ThemeOption(
                    key: ValueKey('profile-theme-${mode.name}'),
                    label: label,
                    hint: hint,
                    active: mode == choice,
                    onTap: () {
                      unawaited(Haptics.selection());
                      unawaited(ref.read(themeModeProvider.notifier).set(mode));
                    },
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    super.key,
    required this.label,
    required this.hint,
    required this.active,
    required this.onTap,
  });

  final String label;
  final String hint;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final radius = BorderRadius.circular(AssistjeTokens.radiusXl);
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: active,
      button: true,
      child: Material(
        color: active ? t.primary.withValues(alpha: 0.05) : t.surface,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(color: active ? t.primary : t.line),
        ),
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: active ? t.primary : t.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  hint,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: t.muted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Doorklik naar de pushvoorkeuren (`/profile/notifications`).
class NotificationsLinkCard extends StatelessWidget {
  const NotificationsLinkCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return AppCard(
      key: const ValueKey('profile-notifications'),
      onTap: () {
        unawaited(Haptics.light());
        unawaited(context.push(AppRoutes.notificationPreferences));
      },
      child: Row(
        children: [
          Expanded(
            child: ProfileCardHeader(
              icon: PhosphorIconsDuotone.bellRinging,
              iconColor: StatusColors.emerald500,
              title: l10n.profileNotificationsTitle,
              body: l10n.profileNotificationsBody,
            ),
          ),
          Icon(PhosphorIconsRegular.caretRight, size: 18, color: t.muted),
        ],
      ),
    );
  }
}

/// Uitloggen.
class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SecondaryButton(
      key: const Key('logout'),
      label: l10n.logout,
      expand: true,
      icon: const Icon(PhosphorIconsRegular.signOut, size: 18),
      onPressed: () {
        unawaited(Haptics.light());
        unawaited(ref.read(authControllerProvider.notifier).logout());
      },
    );
  }
}

/// Het clublogo op het beginscherm, alleen als het wapen van deze club kan.
///
/// - iOS: een schakelaar wisselt het app-icoon (alleen als het wapen in de
///   build zit, zie `tool/app_icons.dart`); iOS toont na de wissel zelf een
///   melding.
/// - Android: een knop zet een snelkoppeling met het clublogo op het
///   beginscherm (`AppIconChannel.kt`); het gewone icoon blijft staan.
class AppIconCard extends ConsumerWidget {
  const AppIconCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final icon = ref.watch(clubIconProvider).value;
    final team = ref.watch(currentMembershipProvider)?.team;
    if (icon == null || team == null) return const SizedBox.shrink();
    return switch (icon.mode) {
      AppIconMode.alternate => _AlternateIconCard(icon: icon, team: team),
      AppIconMode.shortcut => _ShortcutIconCard(icon: icon, team: team),
    };
  }
}

/// iOS: schakelaar tussen het standaardicoon en het clubwapen.
class _AlternateIconCard extends ConsumerWidget {
  const _AlternateIconCard({required this.icon, required this.team});

  final ClubIconState icon;
  final Team team;

  Future<void> _toggle(
    BuildContext context,
    WidgetRef ref, {
    required bool on,
  }) async {
    unawaited(Haptics.selection());
    try {
      await ref.read(appIconServiceProvider).setIcon(on ? icon.name : null);
    } on Object catch (error) {
      if (context.mounted) {
        showProfileError(
          context,
          AppLocalizations.of(context).profileAppIconFailed,
          error,
        );
      }
    }
    ref.invalidate(clubIconProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return AppCard(
      key: const ValueKey('profile-app-icon'),
      child: MergeSemantics(
        child: Row(
          children: [
            Expanded(
              child: ProfileCardHeader(
                icon: PhosphorIconsDuotone.squaresFour,
                title: l10n.profileAppIconTitle,
                body: l10n.profileAppIconBody(team.name),
              ),
            ),
            const SizedBox(width: 12),
            Semantics(
              label: l10n.profileAppIconLabel,
              child: Switch.adaptive(
                key: const ValueKey('profile-app-icon-switch'),
                value: icon.active,
                onChanged: (on) => _toggle(context, ref, on: on),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Android: het clublogo als snelkoppeling op het beginscherm.
class _ShortcutIconCard extends ConsumerStatefulWidget {
  const _ShortcutIconCard({required this.icon, required this.team});

  final ClubIconState icon;
  final Team team;

  @override
  ConsumerState<_ShortcutIconCard> createState() => _ShortcutIconCardState();
}

class _ShortcutIconCardState extends ConsumerState<_ShortcutIconCard> {
  bool _busy = false;

  Future<void> _pin() async {
    final l10n = AppLocalizations.of(context);
    unawaited(Haptics.light());
    setState(() => _busy = true);
    try {
      final logos = ref.read(clubLogoRepositoryProvider);
      final png = await logos.download(widget.icon.logoUrl!);
      final result = await ref
          .read(appIconServiceProvider)
          .pinShortcut(id: widget.icon.name, label: widget.team.name, png: png);
      if (!mounted) return;
      switch (result) {
        case PinShortcutResult.requested:
          showProfileSuccess(
            context,
            l10n.profileAppIconPinRequested,
            body: l10n.profileAppIconPinRequestedBody,
          );
        case PinShortcutResult.updated:
          showProfileSuccess(context, l10n.profileAppIconPinUpdated);
      }
    } on Object catch (error) {
      if (mounted) {
        showProfileError(context, l10n.profileAppIconPinFailed, error);
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
        // `active` (staat hij al op het beginscherm?) opnieuw opvragen.
        ref.invalidate(clubIconProvider);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return AppCard(
      key: const ValueKey('profile-app-icon'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileCardHeader(
            icon: PhosphorIconsDuotone.squaresFour,
            title: l10n.profileAppIconTitle,
            body: l10n.profileAppIconShortcutBody,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Voorbeeld zoals de launcher hem toont: logo op wit, rond.
              ExcludeSemantics(
                child: Container(
                  width: 48,
                  height: 48,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    shape: BoxShape.circle,
                    border: Border.all(color: t.line),
                  ),
                  child: Image.network(
                    widget.icon.logoUrl!,
                    key: const ValueKey('profile-app-icon-logo'),
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => Icon(
                      PhosphorIconsDuotone.shieldStar,
                      color: t.muted,
                      size: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: SecondaryButton(
                  key: const ValueKey('profile-app-icon-pin'),
                  label: widget.icon.active
                      ? l10n.profileAppIconPinUpdate
                      : l10n.profileAppIconPin,
                  loading: _busy,
                  onPressed: _busy ? null : _pin,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
