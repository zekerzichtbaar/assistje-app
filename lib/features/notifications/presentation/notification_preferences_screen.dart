import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/notification_preferences_controller.dart';
import '../data/models/notification_models.dart';

/// Pushvoorkeuren (`/profile/notifications`): de categorieën uit de
/// API-catalogus (`types`), in die volgorde, elk met een schakelaar.
/// Poule-categorieën alleen als het actieve team een poule heeft.
class NotificationPreferencesScreen extends ConsumerWidget {
  const NotificationPreferencesScreen({super.key});

  static String _errorText(AppLocalizations l10n, Object? error) =>
      switch (error) {
        NetworkException() => l10n.errorNetwork,
        final ApiException e when e.message != null => e.message!,
        _ => l10n.errorGeneric,
      };

  Future<void> _refresh(BuildContext context, WidgetRef ref) async {
    final error = await ref
        .read(notificationPreferencesControllerProvider.notifier)
        .refresh();
    if (error != null && context.mounted) {
      final l10n = AppLocalizations.of(context);
      showAppToast(
        context,
        title: _errorText(l10n, error),
        variant: AppToastVariant.error,
        closeLabel: l10n.close,
      );
    }
  }

  Future<void> _toggle(
    BuildContext context,
    WidgetRef ref,
    String key,
    bool enabled,
  ) async {
    final l10n = AppLocalizations.of(context);
    unawaited(Haptics.selection());
    final error = await ref
        .read(notificationPreferencesControllerProvider.notifier)
        .toggle(key, enabled: enabled);
    if (error != null && context.mounted) {
      unawaited(Haptics.error());
      showAppToast(
        context,
        title: l10n.notificationsPreferencesSaveFailed,
        message: error is ApiException ? error.message : null,
        variant: AppToastVariant.error,
        closeLabel: l10n.close,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(notificationPreferencesControllerProvider);
    final prefs = async.value;
    // Zonder team (of `/me`) alles tonen.
    final hasPoule = ref.watch(currentMembershipProvider)?.hasPoule ?? true;

    final List<Widget> content;
    if (prefs != null) {
      final types = [
        for (final type in prefs.types)
          if (!type.pouleOnly || hasPoule) type,
      ];
      content = [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
            child: Text(
              l10n.notificationsPreferencesIntro,
              style: TextStyle(fontSize: 14, height: 1.4, color: t.muted),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: AppCard(
            key: const ValueKey('notification-preferences-list'),
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                for (var i = 0; i < types.length; i++) ...[
                  if (i > 0)
                    Divider(height: 1, thickness: 1, color: t.lineSoft),
                  _PreferenceRow(
                    type: types[i],
                    onChanged: (value) =>
                        _toggle(context, ref, types[i].key, value),
                  ),
                ],
              ],
            ),
          ),
        ),
      ];
    } else if (async.hasError) {
      content = [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('notification-preferences-error'),
            icon: PhosphorIconsDuotone.warningCircle,
            title: l10n.notificationsPreferencesLoadError,
            description: _errorText(l10n, async.error),
            action: PrimaryButton(
              key: const ValueKey('notification-preferences-retry'),
              label: l10n.retry,
              onPressed: () => _refresh(context, ref),
            ),
          ),
        ),
      ];
    } else {
      content = const [
        SliverToBoxAdapter(
          child: AppCard(
            key: ValueKey('notification-preferences-skeleton'),
            padding: EdgeInsets.zero,
            child: SkeletonList(count: 6),
          ),
        ),
      ];
    }

    return Scaffold(
      key: const ValueKey('notification-preferences-screen'),
      backgroundColor: t.sunken,
      body: AppRefresh(
        onRefresh: () => _refresh(context, ref),
        padding: EdgeInsets.fromLTRB(
          12,
          ShellInsets.top(context),
          12,
          ShellInsets.bottom(context),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
              child: Semantics(
                header: true,
                child: Text(
                  l10n.screenNotificationPreferences,
                  key: const Key('placeholder-title'),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: t.ink,
                  ),
                ),
              ),
            ),
          ),
          ...content,
        ],
      ),
    );
  }
}

class _PreferenceRow extends StatelessWidget {
  const _PreferenceRow({required this.type, required this.onChanged});

  final NotificationPreferenceType type;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return MergeSemantics(
      child: InkWell(
        onTap: () => onChanged(!type.enabled),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type.label,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: t.ink,
                      ),
                    ),
                    if (type.description.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          type.description,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.35,
                            color: t.muted,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Switch.adaptive(
                key: ValueKey('pref-${type.key}'),
                value: type.enabled,
                activeTrackColor: t.primary,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
