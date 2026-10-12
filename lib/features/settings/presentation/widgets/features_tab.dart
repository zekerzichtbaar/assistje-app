import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/settings_models.dart';
import 'settings_ui.dart';

/// Vaste categorie-volgorde uit FeaturesTab.tsx; 'Vervoer' staat bewust
/// onderaan, onbekende categorieën daarna.
const List<String> _categoryOrder = [
  'Communicatie',
  'Geld',
  'Plezier',
  'Spelers',
  'Statistieken',
  'Wedstrijd',
  'Vervoer',
];

const List<int> _carpoolPresets = [2, 4, 6, 12];

/// De functies per categorie, in de volgorde van de PWA.
List<(String, List<SettingsFeature>)> groupSettingsFeatures(
  List<SettingsFeature> features,
  String fallbackCategory,
) {
  final grouped = <String, List<SettingsFeature>>{};
  for (final f in features) {
    final category = (f.category == null || f.category!.isEmpty)
        ? fallbackCategory
        : f.category!;
    (grouped[category] ??= []).add(f);
  }
  int rank(String c) {
    final i = _categoryOrder.indexOf(c);
    return i == -1 ? _categoryOrder.length : i;
  }

  final keys = grouped.keys.toList();
  // Stabiel: gelijke rang houdt de volgorde van de server.
  final indexed = [for (var i = 0; i < keys.length; i++) (i, keys[i])]
    ..sort((a, b) {
      final r = rank(a.$2).compareTo(rank(b.$2));
      return r != 0 ? r : a.$1.compareTo(b.$1);
    });
  return [for (final (_, key) in indexed) (key, grouped[key]!)];
}

/// Wat de Functies-tab kan doen; elke actie geeft de fout terug of `null`.
class FeaturesTabActions {
  const FeaturesTabActions({
    required this.setFeature,
    required this.setCarpoolHours,
    required this.updateGuests,
    required this.setAttendancePoint,
  });

  final Future<Object?> Function(String key, bool enabled) setFeature;
  final Future<Object?> Function(int hours) setCarpoolHours;
  final Future<Object?> Function(GuestUpdate update) updateGuests;
  final Future<Object?> Function(bool enabled) setAttendancePoint;
}

/// Functies aan/uit met hun sub-instellingen, en de gastspelers
/// (`FeaturesTab.tsx`). Alles slaat meteen op.
class SettingsFeaturesTab extends StatelessWidget {
  const SettingsFeaturesTab({
    super.key,
    required this.settings,
    required this.readOnly,
    required this.actions,
  });

  final TeamSettings settings;
  final bool readOnly;
  final FeaturesTabActions actions;

  Future<void> _run(BuildContext context, Future<Object?> request) async {
    final error = await request;
    if (error != null && context.mounted) showSettingsError(context, error);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final s = settings;
    final finesOn = s.featureEnabled('fines');
    final statsOn = s.featureEnabled('stats');
    final guestsJoin = s.guests.attendance != GuestAttendance.none;

    Widget? extra(SettingsFeature f) {
      if (!f.enabled) return null;
      switch (f.key) {
        case 'training_points':
          return SettingsToggleRow(
            switchKey: const ValueKey('settings-attendance-point'),
            inset: true,
            title: l10n.settingsAttendancePoint,
            subtitle: l10n.settingsAttendancePointHint,
            value: s.trainingPoints.attendancePoint,
            onChanged: readOnly
                ? null
                : (v) => _run(context, actions.setAttendancePoint(v)),
          );
        case 'fines':
          return SettingsToggleRow(
            switchKey: const ValueKey('settings-staff-in-fines'),
            inset: true,
            title: l10n.settingsStaffInFines,
            subtitle: l10n.settingsStaffInFinesHint,
            value: s.guests.staffInFines,
            onChanged: readOnly
                ? null
                : (v) => _run(
                    context,
                    actions.updateGuests(GuestUpdate(staffInFines: v)),
                  ),
          );
        case 'carpool':
          return Column(
            key: const ValueKey('settings-carpool-hours'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsFieldLabel(l10n.settingsCarpoolTitle),
              Text(
                l10n.settingsCarpoolIntro,
                style: TextStyle(fontSize: 14, color: t.inkSoft),
              ),
              const SizedBox(height: 10),
              HourPicker(
                keyPrefix: 'settings-carpool',
                value: s.carpool.reminderHours,
                presets: _carpoolPresets,
                max: 48,
                onChanged: readOnly
                    ? null
                    : (h) => _run(context, actions.setCarpoolHours(h)),
              ),
            ],
          );
      }
      return null;
    }

    final sections = <Widget>[
      for (final (category, items) in groupSettingsFeatures(
        s.features,
        l10n.settingsCategoryOther,
      ))
        SettingsSection(
          key: ValueKey('settings-category-$category'),
          title: category,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0) Divider(height: 1, color: t.lineSoft),
                SettingsToggleRow(
                  key: ValueKey('settings-feature-${items[i].key}'),
                  switchKey: ValueKey(
                    'settings-feature-switch-${items[i].key}',
                  ),
                  title: items[i].name,
                  subtitle: items[i].description,
                  value: items[i].enabled,
                  onChanged: readOnly
                      ? null
                      : (v) =>
                            _run(context, actions.setFeature(items[i].key, v)),
                ),
                if (extra(items[i]) case final child?)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: child,
                  ),
              ],
            ],
          ),
        ),
      _GuestsSection(
        guests: s.guests,
        showFines: guestsJoin && finesOn,
        showStats: guestsJoin && statsOn,
        onChanged: readOnly
            ? null
            : (update) => _run(context, actions.updateGuests(update)),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < sections.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          sections[i],
        ],
      ],
    );
  }
}

class _GuestsSection extends StatelessWidget {
  const _GuestsSection({
    required this.guests,
    required this.showFines,
    required this.showStats,
    required this.onChanged,
  });

  final GuestSettings guests;
  final bool showFines;
  final bool showStats;
  final ValueChanged<GuestUpdate>? onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    String label(GuestAttendance mode) => switch (mode) {
      GuestAttendance.none => l10n.settingsGuestsNone,
      GuestAttendance.training => l10n.settingsGuestsTraining,
      GuestAttendance.all => l10n.settingsGuestsAll,
    };
    String hint(GuestAttendance mode) => switch (mode) {
      GuestAttendance.none => l10n.settingsGuestsNoneHint,
      GuestAttendance.training => l10n.settingsGuestsTrainingHint,
      GuestAttendance.all => l10n.settingsGuestsAllHint,
    };
    final change = onChanged;

    return SettingsSection(
      key: const ValueKey('settings-guests'),
      title: l10n.settingsGuestsTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.settingsGuestsIntro,
                  style: TextStyle(fontSize: 14, color: t.inkSoft),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final mode in GuestAttendance.values)
                      AppPill(
                        key: ValueKey('settings-guests-${mode.name}'),
                        label: label(mode),
                        selected: guests.attendance == mode,
                        onTap: change == null || guests.attendance == mode
                            ? null
                            : () => change(GuestUpdate(attendance: mode)),
                      ),
                  ],
                ),
                SettingsHint(hint(guests.attendance)),
              ],
            ),
          ),
          if (showFines) ...[
            Divider(height: 1, color: t.lineSoft),
            SettingsToggleRow(
              switchKey: const ValueKey('settings-guest-in-fines'),
              title: l10n.settingsGuestInFines,
              subtitle: l10n.settingsGuestInFinesHint,
              value: guests.inFines,
              onChanged: change == null
                  ? null
                  : (v) => change(GuestUpdate(inFines: v)),
            ),
          ],
          if (showStats) ...[
            Divider(height: 1, color: t.lineSoft),
            SettingsToggleRow(
              switchKey: const ValueKey('settings-guest-in-stats'),
              title: l10n.settingsGuestInStats,
              subtitle: l10n.settingsGuestInStatsHint,
              value: guests.inStats,
              onChanged: change == null
                  ? null
                  : (v) => change(GuestUpdate(inStats: v)),
            ),
          ],
        ],
      ),
    );
  }
}
