import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../player_management/application/share_service.dart';
import '../application/settings_controller.dart';
import '../data/logo_picker.dart';
import '../data/models/settings_models.dart';
import 'widgets/duty_type_sheet.dart';
import 'widgets/duty_types_tab.dart';
import 'widgets/features_tab.dart';
import 'widgets/rsvp_tab.dart';
import 'widgets/season_tab.dart';
import 'widgets/settings_ui.dart';
import 'widgets/team_tab.dart';

/// De bladen van het scherm, in de volgorde van de PWA: van "wat is dit
/// team" naar "hoe werkt het".
enum SettingsTab { team, season, rsvp, features, types }

/// Instellingen voor de trainer (`Settings/Index.tsx`): team (naam, logo,
/// kleur, opstelling, agenda-links), seizoen (alleen-lezen, beheer op
/// `/seasons`), deadlines, functies (met gasten, trainingspunt en carpool)
/// en diensttypes. Trekken = verversen.
class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key, required this.title});

  final String title;

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  SettingsTab _tab = SettingsTab.team;

  AppLocalizations get _l10n => AppLocalizations.of(context);

  SettingsController _controller(int teamId) =>
      ref.read(settingsControllerProvider(teamId).notifier);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showSettingsError(context, error, title: _l10n.settingsLoadError);
    }
  }

  Future<void> _openDutyType(
    int teamId,
    TeamSettings data,
    DutyTypeSetting? type,
  ) async {
    unawaited(Haptics.light());
    final l10n = _l10n;
    final controller = _controller(teamId);
    final saved = await showDutyTypeSheet(
      context,
      initial: type,
      people: data.dutyPeople,
      helpersEnabled: data.featureEnabled('duty_helpers'),
      onSubmit: (input) => type == null
          ? controller.createDutyType(input)
          : controller.updateDutyType(type.id, input),
    );
    if ((saved ?? false) && mounted) {
      showSettingsSuccess(
        context,
        type == null ? l10n.settingsDutyAdded : l10n.settingsSaved,
      );
    }
  }

  Future<void> _deleteDutyType(int teamId, DutyTypeSetting type) async {
    final l10n = _l10n;
    if (!await confirmSettings(
      context,
      message: l10n.settingsDutyDeleteConfirm(type.name),
      confirmLabel: l10n.settingsRemove,
      destructive: true,
    )) {
      return;
    }
    final error = await _controller(teamId).deleteDutyType(type.id);
    if (!mounted) return;
    if (error != null) {
      showSettingsError(context, error);
    } else {
      showSettingsSuccess(context, l10n.settingsDutyDeleted);
    }
  }

  Future<Object?> _pickLogo(int teamId) async {
    final picked = await ref.read(logoPickerProvider).pick();
    if (picked == null) return null;
    return _controller(teamId).uploadLogo(picked.toDataUri());
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final t = AssistjeTokens.of(context);
    final l10n = _l10n;
    final async = ref.watch(settingsControllerProvider(teamId));
    final state = async.value;
    final readOnly =
        membership.team.isDemo || (state?.writesForbidden ?? false);

    final List<Widget> content;
    if (state != null) {
      content = [
        if (readOnly) ...[
          SettingsNotice(
            key: const ValueKey('settings-read-only'),
            icon: PhosphorIconsDuotone.eye,
            text: membership.team.isDemo
                ? l10n.settingsReadOnlyDemo
                : l10n.settingsReadOnlyForbidden,
          ),
          const SizedBox(height: 12),
        ],
        KeyedSubtree(
          key: ValueKey('settings-tab-${_tab.name}'),
          child: _tabContent(
            teamId,
            membership.team.name,
            state.data,
            readOnly,
          ),
        ),
      ];
    } else if (async.hasError) {
      content = [_errorState(teamId, async.error)];
    } else {
      content = const [
        Column(
          key: ValueKey('settings-loading'),
          children: [
            Skeleton(height: 72, radius: AssistjeTokens.radius2xl),
            SizedBox(height: 12),
            SkeletonList(count: 6),
          ],
        ),
      ];
    }

    return Scaffold(
      key: const ValueKey('settings-screen'),
      backgroundColor: t.sunken,
      body: AppRefresh(
        onRefresh: () => _refresh(teamId),
        padding: EdgeInsets.fromLTRB(
          12,
          ShellInsets.top(context),
          12,
          ShellInsets.bottom(context),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(
                        widget.title,
                        // Zelfde key als de placeholder: de shell-tests
                        // lezen de schermtitel via `placeholder-title`.
                        key: const Key('placeholder-title'),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: t.ink,
                        ),
                      ),
                    ),
                  ),
                  if (state != null && !readOnly && _tab == SettingsTab.types)
                    PrimaryButton(
                      key: const ValueKey('settings-duty-add'),
                      label: l10n.settingsDutyNewShort,
                      icon: const PhosphorIcon(
                        PhosphorIconsBold.plus,
                        size: 16,
                      ),
                      onPressed: () => _openDutyType(teamId, state.data, null),
                    ),
                ],
              ),
            ),
          ),
          if (state != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SingleChildScrollView(
                  key: const ValueKey('settings-tabs'),
                  scrollDirection: Axis.horizontal,
                  child: AppTabPills<SettingsTab>(
                    darkTrack: true,
                    selected: _tab,
                    onChanged: (tab) {
                      unawaited(Haptics.selection());
                      setState(() => _tab = tab);
                    },
                    tabs: [
                      for (final tab in SettingsTab.values)
                        AppTabPill(value: tab, label: _tabLabel(tab)),
                    ],
                  ),
                ),
              ),
            ),
          SliverList.list(children: content),
        ],
      ),
    );
  }

  String _tabLabel(SettingsTab tab) => switch (tab) {
    SettingsTab.team => _l10n.settingsTabTeam,
    SettingsTab.season => _l10n.settingsTabSeason,
    SettingsTab.rsvp => _l10n.settingsTabRsvp,
    SettingsTab.features => _l10n.settingsTabFeatures,
    SettingsTab.types => _l10n.settingsTabDuties,
  };

  Widget _tabContent(
    int teamId,
    String teamName,
    TeamSettings data,
    bool readOnly,
  ) {
    final controller = _controller(teamId);
    switch (_tab) {
      case SettingsTab.team:
        final share = ref.read(shareServiceProvider);
        return SettingsTeamTab(
          settings: data,
          readOnly: readOnly,
          actions: TeamTabActions(
            save: controller.updateTeam,
            pickLogo: () => _pickLogo(teamId),
            removeLogo: controller.removeLogo,
            copyLink: share.copy,
            shareLink: (url, origin) => share.share(
              url,
              subject: _l10n.settingsIcalShareSubject(teamName),
              origin: origin,
            ),
            rotateIcal: controller.rotateIcal,
          ),
        );
      case SettingsTab.season:
        return SettingsSeasonTab(
          period: data.period,
          onOpenSeasons: () => unawaited(context.push(AppRoutes.seasons)),
        );
      case SettingsTab.rsvp:
        return SettingsRsvpTab(
          rsvp: data.rsvp,
          finesEnabled: data.featureEnabled('fines'),
          readOnly: readOnly,
          onSave: controller.updateRsvp,
        );
      case SettingsTab.features:
        return SettingsFeaturesTab(
          settings: data,
          readOnly: readOnly,
          actions: FeaturesTabActions(
            setFeature: (key, enabled) =>
                controller.setFeature(key, enabled: enabled),
            setCarpoolHours: controller.setCarpoolHours,
            updateGuests: controller.updateGuests,
            setAttendancePoint: (enabled) =>
                controller.setTrainingAttendancePoint(enabled: enabled),
          ),
        );
      case SettingsTab.types:
        return SettingsDutyTypesTab(
          types: data.dutyTypes,
          readOnly: readOnly,
          onCreate: () => _openDutyType(teamId, data, null),
          onEdit: (type) => _openDutyType(teamId, data, type),
          onDelete: (type) => _deleteDutyType(teamId, type),
        );
    }
  }

  Widget _errorState(int teamId, Object? error) {
    final l10n = _l10n;
    return switch (error) {
      ForbiddenException() => EmptyState(
        key: const ValueKey('settings-forbidden'),
        icon: PhosphorIconsDuotone.lockSimple,
        title: l10n.settingsForbiddenTitle,
        description: l10n.settingsForbidden,
      ),
      _ => EmptyState(
        key: const ValueKey('settings-error'),
        icon: PhosphorIconsDuotone.warningCircle,
        title: l10n.settingsLoadError,
        description: settingsErrorText(l10n, error),
        action: PrimaryButton(
          key: const ValueKey('settings-retry'),
          label: l10n.retry,
          onPressed: () => _refresh(teamId),
        ),
      ),
    };
  }
}
