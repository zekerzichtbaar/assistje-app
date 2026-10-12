import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/theme/team_color.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/settings_models.dart';
import 'settings_ui.dart';

/// Wat de Team-tab kan doen; elke actie geeft de fout terug of `null`.
class TeamTabActions {
  const TeamTabActions({
    required this.save,
    required this.pickLogo,
    required this.removeLogo,
    required this.copyLink,
    required this.shareLink,
    required this.rotateIcal,
  });

  final Future<Object?> Function(TeamBranding branding) save;

  /// Kiest en uploadt een logo; `null` als het lukte of werd afgebroken.
  final Future<Object?> Function() pickLogo;
  final Future<Object?> Function() removeLogo;
  final Future<void> Function(String url) copyLink;
  final Future<void> Function(String url, Rect? origin) shareLink;
  final Future<Object?> Function() rotateIcal;
}

/// Clubkleuren om snel uit te kiezen (de hex-invoer blijft vrij).
const List<String> settingsColorSwatches = [
  '#006837',
  '#C8102E',
  '#E30613',
  '#F18A00',
  '#FFD200',
  '#0055A4',
  '#00A3E0',
  '#6A1B9A',
  '#000000',
  '#5B6770',
];

final RegExp _hex = RegExp(r'^#[0-9A-Fa-f]{6}$');

/// Teamnaam, logo, clubkleur en vaste opstelling (`TeamTab.tsx`), plus de
/// agenda-abonnementen (iCal).
class SettingsTeamTab extends StatefulWidget {
  const SettingsTeamTab({
    super.key,
    required this.settings,
    required this.readOnly,
    required this.actions,
  });

  final TeamSettings settings;
  final bool readOnly;
  final TeamTabActions actions;

  @override
  State<SettingsTeamTab> createState() => _SettingsTeamTabState();
}

class _SettingsTeamTabState extends State<SettingsTeamTab> {
  late final TextEditingController _name;
  late final TextEditingController _color;
  late String? _formation;
  late bool _logoFills;
  bool _saving = false;
  bool _logoBusy = false;
  bool _rotating = false;
  Object? _error;

  SettingsTeam get _team => widget.settings.team;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: _team.name);
    _color = TextEditingController(text: _team.primaryColor.toUpperCase());
    _formation = _team.formation;
    _logoFills = _team.logoFills;
  }

  @override
  void didUpdateWidget(SettingsTeamTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    final before = oldWidget.settings.team;
    // Een nieuw logo zet de kleur op de server: die overnemen.
    if (before.primaryColor != _team.primaryColor) {
      _color.text = _team.primaryColor.toUpperCase();
    }
    if (before.name != _team.name) _name.text = _team.name;
    if (before.formation != _team.formation) _formation = _team.formation;
    if (before.logoFills != _team.logoFills) _logoFills = _team.logoFills;
  }

  @override
  void dispose() {
    _name.dispose();
    _color.dispose();
    super.dispose();
  }

  String get _colorValue {
    final raw = _color.text.trim();
    return raw.startsWith('#') ? raw : '#$raw';
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    FocusScope.of(context).unfocus();
    final name = _name.text.trim();
    if (name.isEmpty) {
      setState(
        () => _error = _LocalError('name', l10n.settingsTeamNameRequired),
      );
      return;
    }
    if (!_hex.hasMatch(_colorValue)) {
      setState(
        () => _error = _LocalError('primary_color', l10n.settingsColorInvalid),
      );
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    final error = await widget.actions.save(
      TeamBranding(
        name: name,
        primaryColor: _colorValue.toUpperCase(),
        formation: _formation,
        logoFills: _team.logoUrl == null ? null : _logoFills,
      ),
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

  Future<void> _pickLogo() async {
    setState(() => _logoBusy = true);
    final error = await widget.actions.pickLogo();
    if (!mounted) return;
    setState(() => _logoBusy = false);
    if (error != null) showSettingsError(context, error);
  }

  Future<void> _removeLogo() async {
    final l10n = AppLocalizations.of(context);
    if (!await confirmSettings(
      context,
      message: l10n.settingsLogoRemoveConfirm,
      confirmLabel: l10n.settingsRemove,
      destructive: true,
    )) {
      return;
    }
    setState(() => _logoBusy = true);
    final error = await widget.actions.removeLogo();
    if (!mounted) return;
    setState(() => _logoBusy = false);
    if (error != null) showSettingsError(context, error);
  }

  Future<void> _rotate() async {
    final l10n = AppLocalizations.of(context);
    if (!await confirmSettings(
      context,
      title: l10n.settingsIcalRotateTitle,
      message: l10n.settingsIcalRotateConfirm,
      confirmLabel: l10n.settingsIcalRotate,
      destructive: true,
    )) {
      return;
    }
    setState(() => _rotating = true);
    final error = await widget.actions.rotateIcal();
    if (!mounted) return;
    setState(() => _rotating = false);
    if (error == null) {
      showSettingsSuccess(context, l10n.settingsIcalRotated);
    } else {
      showSettingsError(context, error);
    }
  }

  String? _fieldError(String field) {
    final error = _error;
    if (error is _LocalError) return error.field == field ? error.text : null;
    return settingsFieldError(error, [field]);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final readOnly = widget.readOnly;
    final previewHex = _hex.hasMatch(_colorValue)
        ? _colorValue
        : _team.primaryColor;
    final formations = widget.settings.formations;

    final form = SettingsSection(
      key: const ValueKey('settings-team-card'),
      title: l10n.settingsTabTeam,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SettingsFieldLabel(l10n.settingsLogo),
            _LogoRow(
              logoUrl: _team.logoUrl,
              busy: _logoBusy,
              onUpload: readOnly ? null : _pickLogo,
              onRemove: readOnly || _team.logoUrl == null ? null : _removeLogo,
            ),
            SettingsHint(l10n.settingsLogoHint),
            if (_team.logoUrl != null) ...[
              const SizedBox(height: 8),
              SettingsToggleRow(
                switchKey: const ValueKey('settings-logo-fills'),
                inset: true,
                title: l10n.settingsLogoFills,
                subtitle: l10n.settingsLogoFillsHint,
                value: _logoFills,
                onChanged: readOnly
                    ? null
                    : (v) => setState(() => _logoFills = v),
              ),
            ],
            const SizedBox(height: 20),
            SettingsFieldLabel(l10n.settingsTeamName),
            TextField(
              key: const ValueKey('settings-team-name'),
              controller: _name,
              enabled: !readOnly,
              maxLength: 120,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                isDense: true,
                counterText: '',
                errorText: _fieldError('name'),
              ),
            ),
            const SizedBox(height: 20),
            SettingsFieldLabel(l10n.settingsColor),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final hex in settingsColorSwatches)
                  _Swatch(
                    key: ValueKey('settings-swatch-$hex'),
                    hex: hex,
                    selected: _colorValue.toUpperCase() == hex,
                    onTap: readOnly
                        ? null
                        : () => setState(() => _color.text = hex),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: TextField(
                    key: const ValueKey('settings-team-color'),
                    controller: _color,
                    enabled: !readOnly,
                    maxLength: 7,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[#0-9A-Fa-f]')),
                    ],
                    style: const TextStyle(fontFamily: 'monospace'),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      counterText: '',
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    key: const ValueKey('settings-color-preview'),
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: TeamColor.toColor(previewHex),
                      borderRadius: BorderRadius.circular(
                        AssistjeTokens.radiusLg,
                      ),
                    ),
                    child: Text(
                      l10n.settingsColorPreview,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: TeamColor.toColor(
                          TeamColor.luminanceContrast(previewHex),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_fieldError('primary_color') case final error?)
              SettingsHint(error, error: true),
            SettingsHint(l10n.settingsColorHint),
            if (formations.isNotEmpty) ...[
              const SizedBox(height: 20),
              SettingsFieldLabel(l10n.settingsFormation),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final f in formations)
                    AppPill(
                      key: ValueKey('settings-formation-$f'),
                      label: '1-$f',
                      selected: _formation == f,
                      onTap: readOnly
                          ? null
                          : () => setState(() => _formation = f),
                    ),
                ],
              ),
              if (_fieldError('formation') case final error?)
                SettingsHint(error, error: true),
              SettingsHint(l10n.settingsFormationHint),
            ],
            if (!readOnly) ...[
              const SizedBox(height: 20),
              PrimaryButton(
                key: const ValueKey('settings-team-save'),
                label: l10n.settingsSave,
                expand: true,
                loading: _saving,
                onPressed: _save,
              ),
            ],
          ],
        ),
      ),
    );

    final ical = widget.settings.ical;
    final links = [
      if (ical.eventsUrl case final url?)
        (key: 'events', label: l10n.settingsIcalMatches, url: url),
      if (ical.trainingsUrl case final url?)
        (key: 'trainings', label: l10n.settingsIcalTrainings, url: url),
    ];

    final icalCard = SettingsSection(
      key: const ValueKey('settings-ical-card'),
      title: l10n.settingsIcalTitle,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.settingsIcalIntro,
              style: TextStyle(fontSize: 14, color: t.inkSoft),
            ),
            if (links.isEmpty)
              SettingsHint(l10n.settingsIcalNone)
            else
              for (final link in links)
                _IcalRow(
                  key: ValueKey('settings-ical-${link.key}'),
                  keyName: link.key,
                  label: link.label,
                  url: link.url,
                  onCopy: () async {
                    await widget.actions.copyLink(link.url);
                    if (context.mounted) {
                      showSettingsSuccess(context, l10n.settingsIcalCopied);
                    }
                  },
                  onShare: (origin) =>
                      widget.actions.shareLink(link.url, origin),
                ),
            if (!readOnly) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: SecondaryButton(
                  key: const ValueKey('settings-ical-rotate'),
                  label: l10n.settingsIcalRotate,
                  loading: _rotating,
                  icon: const PhosphorIcon(
                    PhosphorIconsBold.arrowsClockwise,
                    size: 16,
                  ),
                  onPressed: _rotate,
                ),
              ),
              SettingsHint(l10n.settingsIcalRotateHint),
            ],
          ],
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [form, const SizedBox(height: 12), icalCard],
    );
  }
}

/// Een fout uit de eigen invoercheck (vóór de server).
class _LocalError {
  const _LocalError(this.field, this.text);

  final String field;
  final String text;
}

class _LogoRow extends StatelessWidget {
  const _LogoRow({
    required this.logoUrl,
    required this.busy,
    required this.onUpload,
    required this.onRemove,
  });

  final String? logoUrl;
  final bool busy;
  final VoidCallback? onUpload;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final url = logoUrl;
    return Row(
      children: [
        Container(
          key: const ValueKey('settings-logo-preview'),
          width: 64,
          height: 64,
          alignment: Alignment.center,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: t.raised,
            borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
            border: Border.all(color: t.line),
          ),
          child: busy
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : url == null
              ? Text(
                  l10n.settingsLogoNone,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: t.muted),
                )
              : Image.network(
                  url,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stack) => PhosphorIcon(
                    PhosphorIconsDuotone.imageBroken,
                    color: t.muted,
                  ),
                ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (onUpload != null)
                SecondaryButton(
                  key: const ValueKey('settings-logo-upload'),
                  label: l10n.settingsLogoUpload,
                  icon: const PhosphorIcon(
                    PhosphorIconsBold.uploadSimple,
                    size: 16,
                  ),
                  onPressed: busy ? null : onUpload,
                ),
              if (onRemove != null)
                TextButton.icon(
                  key: const ValueKey('settings-logo-remove'),
                  onPressed: busy ? null : onRemove,
                  style: TextButton.styleFrom(
                    foregroundColor: StatusColors.red600,
                  ),
                  icon: const PhosphorIcon(PhosphorIconsBold.trash, size: 16),
                  label: Text(l10n.settingsRemove),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({
    super.key,
    required this.hex,
    required this.selected,
    required this.onTap,
  });

  final String hex;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Semantics(
      button: true,
      selected: selected,
      label: hex,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: TeamColor.toColor(hex),
            shape: BoxShape.circle,
            border: Border.all(
              color: selected ? t.ink : t.line,
              width: selected ? 3 : 1,
            ),
          ),
        ),
      ),
    );
  }
}

class _IcalRow extends StatelessWidget {
  const _IcalRow({
    super.key,
    required this.keyName,
    required this.label,
    required this.url,
    required this.onCopy,
    required this.onShare,
  });

  final String keyName;
  final String label;
  final String url;
  final VoidCallback onCopy;
  final void Function(Rect? origin) onShare;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          PhosphorIcon(
            PhosphorIconsDuotone.calendarBlank,
            size: 22,
            color: t.inkSoft,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: t.ink,
                  ),
                ),
                Text(
                  url,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: t.muted),
                ),
              ],
            ),
          ),
          IconButton(
            key: ValueKey('settings-ical-copy-$keyName'),
            tooltip: l10n.settingsIcalCopy,
            onPressed: onCopy,
            icon: PhosphorIcon(
              PhosphorIconsBold.copy,
              size: 18,
              color: t.inkSoft,
            ),
          ),
          Builder(
            builder: (buttonContext) => IconButton(
              key: ValueKey('settings-ical-share-$keyName'),
              tooltip: l10n.settingsIcalShare,
              onPressed: () {
                final box = buttonContext.findRenderObject() as RenderBox?;
                final origin = box == null
                    ? null
                    : box.localToGlobal(Offset.zero) & box.size;
                unawaited(Haptics.light());
                onShare(origin);
              },
              icon: PhosphorIcon(
                PhosphorIconsBold.shareNetwork,
                size: 18,
                color: t.inkSoft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
