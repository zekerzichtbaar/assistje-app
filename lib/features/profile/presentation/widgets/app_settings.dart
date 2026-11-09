import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/app_icon/app_icon_service.dart';
import '../../../../core/auth/auth_controller.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/session/session_providers.dart';
import '../../../../core/shell/team_switcher.dart';
import '../../../../core/store/review_prompt.dart';
import '../../../../core/store/store_links.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/theme/theme_providers.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../player_management/application/share_service.dart';
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

/// Het privacybeleid op assistje.nl (Apple 5.1.1 en Google Play willen het
/// in de app vindbaar).
class PrivacyLinkCard extends StatelessWidget {
  const PrivacyLinkCard({super.key});

  static final Uri url = Uri.parse('https://assistje.nl/privacy');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return AppCard(
      key: const ValueKey('profile-privacy'),
      onTap: () {
        unawaited(Haptics.light());
        unawaited(launchUrl(url, mode: LaunchMode.inAppBrowserView));
      },
      child: Row(
        children: [
          Expanded(
            child: ProfileCardHeader(
              icon: PhosphorIconsDuotone.shieldCheck,
              title: l10n.profilePrivacyTitle,
              body: l10n.profilePrivacyBody,
            ),
          ),
          Icon(PhosphorIconsRegular.arrowSquareOut, size: 18, color: t.muted),
        ],
      ),
    );
  }
}

/// Naar de store-pagina om Assistje te beoordelen. Beoordelingen tellen zwaar
/// mee voor waar Assistje in de zoekresultaten staat.
class RateAppCard extends ConsumerWidget {
  const RateAppCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return AppCard(
      key: const ValueKey('profile-rate'),
      onTap: () {
        unawaited(Haptics.light());
        unawaited(
          ref
              .read(reviewRequesterProvider)
              .openStoreListing()
              .catchError((Object _) {}),
        );
      },
      child: Row(
        children: [
          Expanded(
            child: ProfileCardHeader(
              icon: PhosphorIconsDuotone.star,
              title: l10n.profileRateTitle,
              body: l10n.profileRateBody,
            ),
          ),
          Icon(PhosphorIconsRegular.arrowSquareOut, size: 18, color: t.muted),
        ],
      ),
    );
  }
}

/// Assistje aanraden aan een ander team, met een directe store-link (zoeken
/// op "assistje" verbetert de App Store nog naar "assistent").
class TellAFriendCard extends ConsumerWidget {
  const TellAFriendCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return Builder(
      builder: (cardContext) => AppCard(
        key: const ValueKey('profile-tell'),
        onTap: () {
          unawaited(Haptics.light());
          final box = cardContext.findRenderObject() as RenderBox?;
          final origin = box == null || !box.hasSize
              ? null
              : box.localToGlobal(Offset.zero) & box.size;
          unawaited(
            ref
                .read(shareServiceProvider)
                .share(
                  l10n.profileTellMessage(StoreLinks.shareLink().toString()),
                  subject: l10n.profileTellSubject,
                  origin: origin,
                )
                .catchError((Object _) {}),
          );
        },
        child: Row(
          children: [
            Expanded(
              child: ProfileCardHeader(
                icon: PhosphorIconsDuotone.shareNetwork,
                title: l10n.profileTellTitle,
                body: l10n.profileTellBody,
              ),
            ),
            Icon(PhosphorIconsRegular.export, size: 18, color: t.muted),
          ],
        ),
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

/// Kiezen tussen het Assistje-icoon en het clublogo als app-icoon: twee
/// tegels met een voorbeeld. Alleen als het wapen van deze club in de build
/// zit. Standaard het clublogo; [appIconSyncProvider] wisselt het icoon mee
/// met het actieve team (iOS toont na een wissel zelf een melding, Android
/// wisselt als de app naar de achtergrond gaat).
class AppIconCard extends ConsumerWidget {
  const AppIconCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final icon = ref.watch(clubIconProvider).value;
    final team = ref.watch(currentMembershipProvider)?.team;
    if (icon == null || team == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final club = ref.watch(clubAppIconEnabledProvider);

    void choose({required bool club}) {
      unawaited(Haptics.selection());
      unawaited(
        ref.read(clubAppIconEnabledProvider.notifier).set(enabled: club),
      );
    }

    return AppCard(
      key: const ValueKey('profile-app-icon'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileCardHeader(
            icon: PhosphorIconsDuotone.squaresFour,
            title: l10n.profileAppIconTitle,
            body: l10n.profileAppIconBody(team.name),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _AppIconOption(
                  key: const ValueKey('profile-app-icon-default'),
                  label: l10n.profileAppIconDefault,
                  selected: !club,
                  onTap: () => choose(club: false),
                  preview: Image.asset(
                    'assets/app_icon/assistje.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _AppIconOption(
                  key: const ValueKey('profile-app-icon-club'),
                  label: l10n.profileAppIconClub,
                  selected: club,
                  onTap: () => choose(club: true),
                  preview: _ClubIconPreview(url: team.logoUrl),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Eén keuze: icoonvoorbeeld (afgeronde hoeken zoals op het beginscherm),
/// label en een rand + vinkje als hij gekozen is.
class _AppIconOption extends StatelessWidget {
  const _AppIconOption({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.preview,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Widget preview;

  static const double _size = 60;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Semantics(
      button: true,
      selected: selected,
      inMutuallyExclusiveGroup: true,
      label: label,
      excludeSemantics: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: selected ? null : onTap,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            decoration: BoxDecoration(
              color: selected ? t.primary.withValues(alpha: 0.08) : t.sunken,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selected ? t.primary : t.line,
                width: selected ? 2 : 1,
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: _size,
                  height: _size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_size * 0.225),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(_size * 0.225),
                    child: preview,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      selected
                          ? PhosphorIconsFill.checkCircle
                          : PhosphorIconsRegular.circle,
                      size: 18,
                      color: selected ? t.primary : t.muted,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: t.ink,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Het clublogo zoals `tool/app_icons.dart` het icoon maakt: gecentreerd op
/// wit met wat ruimte eromheen.
class _ClubIconPreview extends StatelessWidget {
  const _ClubIconPreview({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final fallback = Icon(
      PhosphorIconsDuotone.shield,
      size: 28,
      color: t.muted,
    );
    final url = this.url;
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(60 * 0.14),
        child: url == null || url.isEmpty
            ? Center(child: fallback)
            : Image.network(
                url,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => Center(child: fallback),
              ),
      ),
    );
  }
}
