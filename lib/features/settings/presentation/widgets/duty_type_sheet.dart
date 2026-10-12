import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../agenda/presentation/widgets/duty_icons.dart';
import '../../data/models/settings_models.dart';
import 'settings_ui.dart';

/// De gecureerde iconen van de PWA (`DUTY_ICON_KEYS` in dutyIcons.ts), in
/// grid-volgorde. De sleutel wordt op `duty_types.icon` opgeslagen.
const List<String> dutyIconKeys = [
  'BeerStein',
  'Coffee',
  'ForkKnife',
  'Orange',
  'Cookie',
  'Flag',
  'SoccerBall',
  'CourtBasketball',
  'Megaphone',
  'TShirt',
  'WashingMachine',
  'Broom',
  'Drop',
  'Trash',
  'Car',
  'Bicycle',
  'Wrench',
  'Toolbox',
  'Key',
  'FirstAidKit',
  'ClipboardText',
  'Calendar',
  'Money',
  'Ticket',
  'Camera',
  'Gift',
  'Cake',
  'Confetti',
  'UsersThree',
];

/// De vier standen van "wie kan deze dienst doen" (`DutyPoolField.tsx`).
enum DutyPoolChoice {
  players,
  staff,
  spectators,
  custom;

  static DutyPoolChoice of(List<String> pool) {
    if (pool.contains(DutyPool.custom)) return custom;
    if (pool.contains(DutyPool.spectators)) return spectators;
    if (pool.contains(DutyPool.staff)) return staff;
    return players;
  }

  List<String> get pool => switch (this) {
    custom => const [DutyPool.custom],
    spectators => const [DutyPool.players, DutyPool.staff, DutyPool.spectators],
    staff => const [DutyPool.players, DutyPool.staff],
    players => const [DutyPool.players],
  };
}

/// Opent het formulier voor een nieuw ([initial] `null`) of bestaand
/// diensttype. [onSubmit] slaat op en geeft de fout terug (of `null`); de
/// sheet sluit met `true` als het lukte.
Future<bool?> showDutyTypeSheet(
  BuildContext context, {
  required DutyTypeSetting? initial,
  required List<DutyPerson> people,
  required bool helpersEnabled,
  required Future<Object?> Function(DutyTypeInput input) onSubmit,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    scrollable: true,
    title: initial == null ? l10n.settingsDutyNew : l10n.settingsDutyEdit,
    builder: (context) => DutyTypeForm(
      initial: initial == null
          ? const DutyTypeInput(name: '')
          : DutyTypeInput.from(initial),
      isNew: initial == null,
      people: people,
      helpersEnabled: helpersEnabled,
      onSubmit: onSubmit,
    ),
  );
}

/// Het diensttype-formulier (`DutyTypeForm` in DutyTypesTab.tsx).
class DutyTypeForm extends StatefulWidget {
  const DutyTypeForm({
    super.key,
    required this.initial,
    required this.isNew,
    required this.people,
    required this.helpersEnabled,
    required this.onSubmit,
  });

  final DutyTypeInput initial;
  final bool isNew;
  final List<DutyPerson> people;
  final bool helpersEnabled;
  final Future<Object?> Function(DutyTypeInput input) onSubmit;

  @override
  State<DutyTypeForm> createState() => _DutyTypeFormState();
}

class _DutyTypeFormState extends State<DutyTypeForm> {
  late final TextEditingController _name = TextEditingController(
    text: widget.initial.name,
  );
  late String? _icon = widget.initial.icon;
  late DutyMode _mode = widget.initial.mode;
  late DutyScope _scope = widget.initial.scope;
  late bool _autoRotate = widget.initial.autoRotate;
  late DutyOnUnavailable _onUnavailable = widget.initial.onUnavailable;
  late List<String> _pool = [...widget.initial.pool];
  late List<String> _members = [...widget.initial.poolMembers];
  bool _saving = false;
  Object? _error;
  String? _nameError;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  bool get _rotates =>
      _mode == DutyMode.individual && _scope == DutyScope.match;

  void _setMode(DutyMode mode) => setState(() {
    _mode = mode;
    if (mode != DutyMode.individual) _autoRotate = false;
    // Een groepsdienst kent geen eigen keuze: daar ís de groep de lijst.
    if (mode == DutyMode.group && _pool.contains(DutyPool.custom)) {
      _pool = [
        DutyPool.players,
        if (_pool.contains(DutyPool.guests)) DutyPool.guests,
      ];
    }
  });

  void _setScope(DutyScope scope) => setState(() {
    _scope = scope;
    if (scope == DutyScope.free) _autoRotate = false;
  });

  void _pickPool(DutyPoolChoice choice) => setState(() {
    _pool = [
      ...choice.pool,
      if (_pool.contains(DutyPool.guests)) DutyPool.guests,
    ];
  });

  void _toggleMember(String key) => setState(() {
    _members = _members.contains(key)
        ? [
            for (final m in _members)
              if (m != key) m,
          ]
        : [..._members, key];
  });

  void _toggleGuests(bool on) => setState(() {
    _pool = on
        ? [..._pool, DutyPool.guests]
        : [
            for (final g in _pool)
              if (g != DutyPool.guests) g,
          ];
  });

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final name = _name.text.trim();
    if (name.isEmpty) {
      setState(() => _nameError = l10n.settingsDutyNameRequired);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
      _nameError = null;
    });
    final error = await widget.onSubmit(
      DutyTypeInput(
        name: name,
        icon: _icon,
        mode: _mode,
        scope: _scope,
        autoRotate: _autoRotate,
        onUnavailable: _onUnavailable,
        pool: _pool,
        poolMembers: _members,
      ),
    );
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      _saving = false;
      _error = error;
      _nameError = settingsFieldError(error, ['name']);
    });
    if (_nameError == null) showSettingsError(context, error);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final choice = DutyPoolChoice.of(_pool);
    final choices = _mode == DutyMode.group
        ? DutyPoolChoice.values.where((c) => c != DutyPoolChoice.custom)
        : DutyPoolChoice.values;

    String choiceLabel(DutyPoolChoice c) => switch (c) {
      DutyPoolChoice.players => l10n.settingsDutyPoolPlayers,
      DutyPoolChoice.staff => l10n.settingsDutyPoolStaff,
      DutyPoolChoice.spectators => l10n.settingsDutyPoolSpectators,
      DutyPoolChoice.custom => l10n.settingsDutyPoolCustom,
    };
    String choiceHint(DutyPoolChoice c) => switch (c) {
      DutyPoolChoice.players => l10n.settingsDutyPoolPlayersHint,
      DutyPoolChoice.staff => l10n.settingsDutyPoolStaffHint,
      DutyPoolChoice.spectators => l10n.settingsDutyPoolSpectatorsHint,
      DutyPoolChoice.custom =>
        _members.isEmpty
            ? l10n.settingsDutyPoolCustomEmpty
            : l10n.settingsDutyPoolCustomHint,
    };
    String? groupHeading(String kind) => switch (kind) {
      'staff' => l10n.settingsDutyPeopleStaff,
      'spectator' => l10n.settingsDutyPeopleSpectators,
      _ => null,
    };

    const gap = SizedBox(height: 16);

    return Column(
      key: const ValueKey('settings-duty-form'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SettingsFieldLabel(l10n.settingsDutyName),
        TextField(
          key: const ValueKey('settings-duty-name'),
          controller: _name,
          autofocus: widget.isNew,
          maxLength: 80,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            isDense: true,
            counterText: '',
            hintText: l10n.settingsDutyNameHint,
            errorText: _nameError,
          ),
        ),
        gap,
        SettingsFieldLabel(l10n.settingsDutyIcon),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final key in dutyIconKeys)
              _IconChoice(
                key: ValueKey('settings-duty-icon-$key'),
                icon: dutyIconFor(key),
                selected: _icon == key,
                label: key,
                onTap: () => setState(() => _icon = _icon == key ? null : key),
              ),
          ],
        ),
        gap,
        SettingsFieldLabel(l10n.settingsDutyMode),
        SettingsOptionTile(
          key: const ValueKey('settings-duty-mode-group'),
          title: l10n.settingsDutyModeGroup,
          description: l10n.settingsDutyModeGroupHint,
          selected: _mode == DutyMode.group,
          onTap: () => _setMode(DutyMode.group),
        ),
        const SizedBox(height: 8),
        SettingsOptionTile(
          key: const ValueKey('settings-duty-mode-individual'),
          title: l10n.settingsDutyModeIndividual,
          description: l10n.settingsDutyModeIndividualHint,
          selected: _mode == DutyMode.individual,
          onTap: () => _setMode(DutyMode.individual),
        ),
        const SizedBox(height: 8),
        SettingsOptionTile(
          key: const ValueKey('settings-duty-mode-multi'),
          title: l10n.settingsDutyModeMulti,
          description: l10n.settingsDutyModeMultiHint,
          selected: _mode == DutyMode.multi,
          onTap: () => _setMode(DutyMode.multi),
        ),
        gap,
        SettingsFieldLabel(l10n.settingsDutyScope),
        SettingsOptionTile(
          key: const ValueKey('settings-duty-scope-free'),
          title: l10n.settingsDutyScopeFree,
          description: l10n.settingsDutyScopeFreeHint,
          selected: _scope == DutyScope.free,
          onTap: () => _setScope(DutyScope.free),
        ),
        const SizedBox(height: 8),
        SettingsOptionTile(
          key: const ValueKey('settings-duty-scope-match'),
          title: l10n.settingsDutyScopeMatch,
          description: l10n.settingsDutyScopeMatchHint,
          selected: _scope == DutyScope.match,
          onTap: () => _setScope(DutyScope.match),
        ),
        if (_rotates) ...[
          gap,
          SettingsFieldLabel(l10n.settingsDutyTurn),
          SettingsToggleRow(
            switchKey: const ValueKey('settings-duty-auto-rotate'),
            inset: true,
            title: l10n.settingsDutyAutoRotate,
            subtitle: l10n.settingsDutyAutoRotateHint,
            value: _autoRotate,
            onChanged: (v) => setState(() => _autoRotate = v),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.settingsDutyOnUnavailable,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: t.inkSoft,
            ),
          ),
          const SizedBox(height: 6),
          SettingsOptionTile(
            key: const ValueKey('settings-duty-unavailable-reassign'),
            title: l10n.settingsDutyReassign,
            description: l10n.settingsDutyReassignHint,
            selected: _onUnavailable == DutyOnUnavailable.reassign,
            onTap: () =>
                setState(() => _onUnavailable = DutyOnUnavailable.reassign),
          ),
          const SizedBox(height: 8),
          SettingsOptionTile(
            key: const ValueKey('settings-duty-unavailable-notify'),
            title: l10n.settingsDutyNotify,
            description: l10n.settingsDutyNotifyHint,
            selected: _onUnavailable == DutyOnUnavailable.notify,
            onTap: () =>
                setState(() => _onUnavailable = DutyOnUnavailable.notify),
          ),
        ],
        if (widget.helpersEnabled) ...[
          gap,
          SettingsFieldLabel(l10n.settingsDutyPool),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final c in choices)
                AppPill(
                  key: ValueKey('settings-duty-pool-${c.name}'),
                  label: choiceLabel(c),
                  selected: choice == c,
                  onTap: () => _pickPool(c),
                ),
            ],
          ),
          if (choice == DutyPoolChoice.custom) ...[
            for (final kind in const ['player', 'staff', 'spectator'])
              if (widget.people.where((p) => p.kind == kind).toList()
                  case final list when list.isNotEmpty) ...[
                const SizedBox(height: 10),
                if (groupHeading(kind) case final heading?)
                  SettingsFieldLabel(heading),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final person in list)
                      AppPill(
                        key: ValueKey('settings-duty-member-${person.key}'),
                        label: person.name,
                        selected: _members.contains(person.key),
                        onTap: () => _toggleMember(person.key),
                      ),
                  ],
                ),
              ],
          ],
          SettingsHint(choiceHint(choice)),
          SettingsHint(l10n.settingsDutyPoolFooter),
        ],
        gap,
        SettingsToggleRow(
          switchKey: const ValueKey('settings-duty-guests'),
          inset: true,
          title: l10n.settingsDutyGuests,
          subtitle: l10n.settingsDutyGuestsHint,
          value: _pool.contains(DutyPool.guests),
          onChanged: _toggleGuests,
        ),
        if (_error != null && _nameError == null)
          SettingsHint(settingsErrorText(l10n, _error), error: true),
        const SizedBox(height: 20),
        PrimaryButton(
          key: const ValueKey('settings-duty-submit'),
          label: widget.isNew ? l10n.settingsDutyAdd : l10n.settingsSave,
          expand: true,
          loading: _saving,
          onPressed: _submit,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _IconChoice extends StatelessWidget {
  const _IconChoice({
    super.key,
    required this.icon,
    required this.selected,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final bool selected;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: Material(
        color: selected ? t.primary.withValues(alpha: 0.12) : t.raised,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AssistjeTokens.radiusLg),
          side: BorderSide(
            color: selected ? t.primary : const Color(0x00000000),
            width: 2,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 44,
            height: 44,
            child: Center(
              child: PhosphorIcon(
                icon,
                size: 22,
                color: selected ? t.primary : t.inkSoft,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
