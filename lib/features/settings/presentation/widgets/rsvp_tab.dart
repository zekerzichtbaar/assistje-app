import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/settings_models.dart';
import 'settings_ui.dart';

const List<int> _hourPresets = [12, 24, 48, 72];

/// Naam van weekdag [iso] (1 = maandag … 7 = zondag).
String settingsWeekday(AppLocalizations l10n, int iso) => switch (iso) {
  1 => l10n.settingsDayMonday,
  2 => l10n.settingsDayTuesday,
  3 => l10n.settingsDayWednesday,
  4 => l10n.settingsDayThursday,
  5 => l10n.settingsDayFriday,
  6 => l10n.settingsDaySaturday,
  _ => l10n.settingsDaySunday,
};

/// Rekent een deadline van [hours] uur voor met een gangbare starttijd
/// [exampleStart] (`describe()` in RsvpTab.tsx).
String describeRsvpDeadline(
  AppLocalizations l10n,
  int hours, {
  required bool match,
  required String exampleStart,
}) {
  final parts = exampleStart.split(':').map(int.parse).toList();
  final deadline = parts[0] * 60 + parts[1] - hours * 60;
  final daysBack = deadline >= 0 ? 0 : (-deadline / 1440).ceil();
  final minutes = ((deadline % 1440) + 1440) % 1440;
  final time =
      '${(minutes ~/ 60).toString().padLeft(2, '0')}:'
      '${(minutes % 60).toString().padLeft(2, '0')}';
  final day = switch (daysBack) {
    0 => l10n.settingsRsvpSameDay,
    1 => l10n.settingsRsvpDayBefore,
    _ => l10n.settingsRsvpDaysBefore(daysBack),
  };
  return match
      ? l10n.settingsRsvpDescribeMatch(hours, exampleStart, day, time)
      : l10n.settingsRsvpDescribeTraining(hours, exampleStart, day, time);
}

/// De beschikbaarheidsdeadline (`RsvpTab.tsx`): per event of wekelijks.
class SettingsRsvpTab extends StatefulWidget {
  const SettingsRsvpTab({
    super.key,
    required this.rsvp,
    required this.finesEnabled,
    required this.readOnly,
    required this.onSave,
  });

  final RsvpSettings rsvp;
  final bool finesEnabled;
  final bool readOnly;
  final Future<Object?> Function(RsvpUpdate update) onSave;

  @override
  State<SettingsRsvpTab> createState() => _SettingsRsvpTabState();
}

class _SettingsRsvpTabState extends State<SettingsRsvpTab> {
  late RsvpMode _mode;
  late int _matchHours;
  late int _trainingHours;
  late int _weeklyDay;
  late String _weeklyTime;
  bool _saving = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load(widget.rsvp);
  }

  @override
  void didUpdateWidget(SettingsRsvpTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rsvp != widget.rsvp) _load(widget.rsvp);
  }

  void _load(RsvpSettings rsvp) {
    _mode = rsvp.mode;
    _matchHours = rsvp.matchHours ?? 24;
    _trainingHours = rsvp.trainingHours ?? 4;
    _weeklyDay = rsvp.weeklyDay ?? 2;
    _weeklyTime = rsvp.weeklyTime ?? '00:00';
  }

  Future<void> _pickTime() async {
    final parts = _weeklyTime.split(':');
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.tryParse(parts.first) ?? 0,
        minute: parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0,
      ),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (picked == null || !mounted) return;
    setState(
      () => _weeklyTime =
          '${picked.hour.toString().padLeft(2, '0')}:'
          '${picked.minute.toString().padLeft(2, '0')}',
    );
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _saving = true;
      _error = null;
    });
    final error = await widget.onSave(
      _mode == RsvpMode.relative
          ? RsvpUpdate.relative(
              matchHours: _matchHours,
              trainingHours: _trainingHours,
            )
          : RsvpUpdate.weekly(weeklyDay: _weeklyDay, weeklyTime: _weeklyTime),
    );
    if (!mounted) return;
    setState(() {
      _saving = false;
      _error = error;
    });
    if (error == null) {
      showSettingsSuccess(context, l10n.settingsSaved);
    } else {
      showSettingsError(context, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final readOnly = widget.readOnly;
    final consequence = widget.finesEnabled
        ? l10n.settingsRsvpConsequenceFines
        : l10n.settingsRsvpConsequenceNoFines;
    final body = TextStyle(fontSize: 14, color: t.inkSoft);

    Widget card(String key, String title, List<Widget> children) =>
        SettingsSection(
          key: ValueKey(key),
          title: title,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        );

    final isRelative = _mode == RsvpMode.relative;
    final cards = <Widget>[
      card('settings-rsvp-mode', l10n.settingsRsvpModeTitle, [
        Text(l10n.settingsRsvpModeIntro, style: body),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SettingsOptionTile(
                key: const ValueKey('settings-rsvp-relative'),
                title: l10n.settingsRsvpRelative,
                description: l10n.settingsRsvpRelativeHint,
                selected: isRelative,
                onTap: readOnly
                    ? null
                    : () => setState(() => _mode = RsvpMode.relative),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SettingsOptionTile(
                key: const ValueKey('settings-rsvp-weekly'),
                title: l10n.settingsRsvpWeekly,
                description: l10n.settingsRsvpWeeklyHint,
                selected: !isRelative,
                onTap: readOnly
                    ? null
                    : () => setState(() => _mode = RsvpMode.weekly),
              ),
            ),
          ],
        ),
      ]),
      if (isRelative) ...[
        card('settings-rsvp-matches', l10n.settingsRsvpMatches, [
          Text(l10n.settingsRsvpMatchesIntro(consequence), style: body),
          const SizedBox(height: 12),
          HourPicker(
            keyPrefix: 'settings-rsvp-match',
            value: _matchHours,
            presets: _hourPresets,
            max: 240,
            onChanged: readOnly ? null : (h) => setState(() => _matchHours = h),
          ),
          SettingsHint(
            describeRsvpDeadline(
              l10n,
              _matchHours,
              match: true,
              exampleStart: '14:30',
            ),
          ),
          if (settingsFieldError(_error, ['rsvp_deadline_match_hours'])
              case final e?)
            SettingsHint(e, error: true),
        ]),
        card('settings-rsvp-trainings', l10n.settingsRsvpTrainings, [
          Text(l10n.settingsRsvpTrainingsIntro, style: body),
          const SizedBox(height: 12),
          HourPicker(
            keyPrefix: 'settings-rsvp-training',
            value: _trainingHours,
            presets: _hourPresets,
            max: 240,
            onChanged: readOnly
                ? null
                : (h) => setState(() => _trainingHours = h),
          ),
          SettingsHint(
            describeRsvpDeadline(
              l10n,
              _trainingHours,
              match: false,
              exampleStart: '19:00',
            ),
          ),
          if (settingsFieldError(_error, ['rsvp_deadline_training_hours'])
              case final e?)
            SettingsHint(e, error: true),
        ]),
      ] else
        card('settings-rsvp-weekly-card', l10n.settingsRsvpWeeklyTitle, [
          Text(l10n.settingsRsvpWeeklyIntro(consequence), style: body),
          const SizedBox(height: 12),
          SettingsFieldLabel(l10n.settingsRsvpDay),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (var d = 1; d <= 7; d++)
                AppPill(
                  key: ValueKey('settings-rsvp-day-$d'),
                  label: settingsWeekday(l10n, d),
                  selected: _weeklyDay == d,
                  onTap: readOnly ? null : () => setState(() => _weeklyDay = d),
                ),
            ],
          ),
          const SizedBox(height: 12),
          SettingsFieldLabel(l10n.settingsRsvpTime),
          Align(
            alignment: Alignment.centerLeft,
            child: SecondaryButton(
              key: const ValueKey('settings-rsvp-time'),
              label: _weeklyTime,
              onPressed: readOnly ? null : _pickTime,
            ),
          ),
          SettingsHint(
            l10n.settingsRsvpWeeklySummary(
              settingsWeekday(l10n, _weeklyDay),
              _weeklyTime,
            ),
          ),
          if (settingsFieldError(_error, [
                'rsvp_weekly_day',
                'rsvp_weekly_time',
              ])
              case final e?)
            SettingsHint(e, error: true),
        ]),
      card('settings-rsvp-after', l10n.settingsRsvpAfterTitle, [
        Text(l10n.settingsRsvpAfterBody, style: body),
        SettingsHint(l10n.settingsRsvpAfterHint),
      ]),
      if (!readOnly)
        PrimaryButton(
          key: const ValueKey('settings-rsvp-save'),
          label: l10n.settingsSave,
          expand: true,
          loading: _saving,
          onPressed: _save,
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < cards.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          cards[i],
        ],
      ],
    );
  }
}
