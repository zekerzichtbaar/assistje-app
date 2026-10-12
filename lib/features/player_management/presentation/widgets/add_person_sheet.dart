import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/player_management_models.dart';
import 'csv_import_form.dart';
import 'pm_ui.dart';

/// Wie er toegevoegd wordt; [csv] is het tabblad met de spelersimport.
enum AddPersonKind { player, trainer, spectator, csv }

/// Wat "Teamleden toevoegen" doet, losgekoppeld van de controller.
class AddPersonActions {
  const AddPersonActions({
    required this.createPlayer,
    required this.addTrainer,
    required this.addSpectator,
    required this.openTeamLink,
    required this.pickCsv,
    required this.importCsv,
  });

  final Future<Object?> Function(NewPlayer player) createPlayer;
  final Future<Object?> Function({required String name, required String email})
  addTrainer;
  final Future<Object?> Function({required String name, required String email})
  addSpectator;
  final VoidCallback openTeamLink;

  /// Kiest een CSV voor de import.
  final PickCsv pickCsv;

  /// `POST players/import`; ververst het overzicht.
  final ImportCsv importCsv;
}

/// "Teamleden toevoegen" (`CreatePersonSheet.tsx`): bovenaan de teamlink
/// (de snelste weg), daaronder één voor één een speler, trainer of
/// toeschouwer, of in bulk uit een CSV (tabblad "CSV", `ImportCsvForm.tsx`).
/// Geeft het soort terug dat is toegevoegd (niet bij de CSV: die toont zelf
/// de samenvatting).
Future<AddPersonKind?> showAddPersonSheet(
  BuildContext context, {
  required Map<String, String> positions,
  required AddPersonActions actions,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<AddPersonKind>(
    context: context,
    title: l10n.pmAddTitle,
    scrollable: true,
    builder: (context) =>
        _AddPersonForm(positions: positions, actions: actions),
  );
}

class _AddPersonForm extends StatefulWidget {
  const _AddPersonForm({required this.positions, required this.actions});

  final Map<String, String> positions;
  final AddPersonActions actions;

  @override
  State<_AddPersonForm> createState() => _AddPersonFormState();
}

class _AddPersonFormState extends State<_AddPersonForm> {
  AddPersonKind _kind = AddPersonKind.player;
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _shirt = TextEditingController();
  String? _position;
  bool _isGuest = false;
  bool _sendInvite = false;
  bool _busy = false;
  Map<String, String> _fieldErrors = const {};
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _shirt.dispose();
    super.dispose();
  }

  bool get _needsEmail => _kind != AddPersonKind.player || _sendInvite;

  Future<void> _submit() async {
    if (_busy || _kind == AddPersonKind.csv) return;
    final l10n = AppLocalizations.of(context);
    final name = _name.text.trim();
    final email = _email.text.trim();
    final errors = <String, String>{
      if (name.isEmpty) 'name': l10n.pmNameRequired,
      if (_needsEmail && email.isEmpty) 'email': l10n.pmEmailRequired,
      if (_needsEmail && email.isNotEmpty && !looksLikeEmail(email))
        'email': l10n.pmEmailInvalid,
    };
    if (errors.isNotEmpty) {
      setState(() {
        _fieldErrors = errors;
        _error = null;
      });
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
      _fieldErrors = const {};
    });
    final kind = _kind;
    final error = switch (kind) {
      AddPersonKind.player => await widget.actions.createPlayer(
        NewPlayer(
          name: name,
          shirtNumber: int.tryParse(_shirt.text.trim()),
          position: _position,
          isGuest: _isGuest,
          sendInvite: _sendInvite,
          email: _sendInvite ? email : null,
        ),
      ),
      AddPersonKind.trainer => await widget.actions.addTrainer(
        name: name,
        email: email,
      ),
      AddPersonKind.spectator => await widget.actions.addSpectator(
        name: name,
        email: email,
      ),
      AddPersonKind.csv => null,
    };
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(kind);
      return;
    }
    setState(() {
      _busy = false;
      if (error is ValidationException) {
        _fieldErrors = {
          for (final field in const [
            'name',
            'email',
            'shirt_number',
            'position',
            'is_guest',
          ])
            field: ?error.fieldError(field),
        };
      }
      if (_fieldErrors.isEmpty) _error = pmErrorText(l10n, error);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TeamLinkHint(onOpen: widget.actions.openTeamLink),
        const SizedBox(height: 16),
        Center(
          child: AppTabPills<AddPersonKind>(
            key: const ValueKey('pm-add-tabs'),
            tabs: [
              AppTabPill(
                value: AddPersonKind.player,
                label: l10n.pmAddTabPlayer,
              ),
              AppTabPill(
                value: AddPersonKind.trainer,
                label: l10n.pmAddTabTrainer,
              ),
              AppTabPill(
                value: AddPersonKind.spectator,
                label: l10n.pmAddTabSpectator,
              ),
              AppTabPill(value: AddPersonKind.csv, label: l10n.pmAddTabCsv),
            ],
            selected: _kind,
            onChanged: _busy
                ? (_) {}
                : (kind) => setState(() {
                    _kind = kind;
                    _fieldErrors = const {};
                    _error = null;
                  }),
          ),
        ),
        const SizedBox(height: 16),
        if (_kind == AddPersonKind.csv)
          CsvImportForm(
            positions: widget.positions,
            pickCsv: widget.actions.pickCsv,
            importCsv: widget.actions.importCsv,
            onBusyChanged: (busy) => setState(() => _busy = busy),
          )
        else
          ..._personFields(l10n, t),
      ],
    );
  }

  List<Widget> _personFields(AppLocalizations l10n, AssistjeTokens t) => [
    if (_error != null)
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          _error!,
          key: const ValueKey('pm-add-error'),
          style: const TextStyle(fontSize: 14, color: StatusColors.red600),
        ),
      ),
    PmFieldLabel(l10n.pmFieldName),
    TextField(
      key: const ValueKey('pm-add-name'),
      controller: _name,
      maxLength: 120,
      enabled: !_busy,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      decoration: InputDecoration(
        counterText: '',
        errorText: _fieldErrors['name'],
      ),
    ),
    const SizedBox(height: 12),
    if (_kind == AddPersonKind.player) ..._playerFields(l10n, t),
    if (_kind != AddPersonKind.player)
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          _kind == AddPersonKind.trainer
              ? l10n.pmTrainerHint
              : l10n.pmSpectatorHint,
          style: TextStyle(fontSize: 13, color: t.muted),
        ),
      ),
    if (_needsEmail) ...[
      PmFieldLabel(l10n.pmFieldEmail),
      TextField(
        key: const ValueKey('pm-add-email'),
        controller: _email,
        enabled: !_busy,
        maxLength: 255,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        decoration: InputDecoration(
          counterText: '',
          errorText: _fieldErrors['email'],
        ),
      ),
      const SizedBox(height: 12),
    ],
    const SizedBox(height: 8),
    PrimaryButton(
      key: const ValueKey('pm-add-submit'),
      label: switch (_kind) {
        AddPersonKind.player => l10n.pmAddPlayerSubmit,
        AddPersonKind.trainer => l10n.pmAddTrainerSubmit,
        AddPersonKind.spectator => l10n.pmAddSpectatorSubmit,
        // Het CSV-tabblad heeft een eigen formulier.
        AddPersonKind.csv => l10n.pmCsvSubmit,
      },
      expand: true,
      loading: _busy,
      onPressed: _busy ? null : _submit,
    ),
  ];

  List<Widget> _playerFields(AppLocalizations l10n, AssistjeTokens t) => [
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PmFieldLabel(l10n.pmFieldShirt),
              TextField(
                key: const ValueKey('pm-add-shirt'),
                controller: _shirt,
                enabled: !_busy,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                decoration: InputDecoration(
                  hintText: l10n.pmOptional,
                  errorText: _fieldErrors['shirt_number'],
                ),
              ),
            ],
          ),
        ),
        if (widget.positions.isNotEmpty) ...[
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PmFieldLabel(l10n.pmFieldPosition),
                PositionDropdown(
                  key: const ValueKey('pm-add-position'),
                  positions: widget.positions,
                  value: _position,
                  errorText: _fieldErrors['position'],
                  onChanged: _busy
                      ? null
                      : (value) => setState(() => _position = value),
                ),
              ],
            ),
          ),
        ],
      ],
    ),
    const SizedBox(height: 8),
    CheckboxListTile(
      key: const ValueKey('pm-add-guest'),
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      value: _isGuest,
      onChanged: _busy ? null : (v) => setState(() => _isGuest = v ?? false),
      title: Text(l10n.pmFieldGuest, style: const TextStyle(fontSize: 14)),
    ),
    CheckboxListTile(
      key: const ValueKey('pm-add-invite'),
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      value: _sendInvite,
      onChanged: _busy ? null : (v) => setState(() => _sendInvite = v ?? false),
      title: Text(
        l10n.pmSendInvite,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        l10n.pmSendInviteHint,
        style: TextStyle(fontSize: 12, color: t.muted),
      ),
    ),
    const SizedBox(height: 4),
  ];
}

/// Kiest een positiecode uit het sportprofiel (of geen).
class PositionDropdown extends StatelessWidget {
  const PositionDropdown({
    super.key,
    required this.positions,
    required this.value,
    required this.onChanged,
    this.errorText,
  });

  final Map<String, String> positions;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Een positie die de sport niet (meer) kent blijft kiesbaar.
    final options = {
      ...positions,
      if (value != null && !positions.containsKey(value)) value!: value!,
    };
    return DropdownButtonFormField<String?>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(errorText: errorText),
      items: [
        DropdownMenuItem<String?>(child: Text(l10n.pmPositionNone)),
        for (final entry in options.entries)
          DropdownMenuItem<String?>(
            value: entry.key,
            child: Text(
              entry.key == entry.value
                  ? entry.key
                  : '${entry.key} · ${entry.value}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      onChanged: onChanged,
    );
  }
}

class _TeamLinkHint extends StatelessWidget {
  const _TeamLinkHint({required this.onOpen});

  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: t.raised,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      ),
      child: Row(
        children: [
          PhosphorIcon(
            PhosphorIconsDuotone.linkSimple,
            size: 22,
            color: t.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              l10n.pmAddTeamlinkHint,
              style: TextStyle(fontSize: 13, color: t.inkSoft),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            key: const ValueKey('pm-add-open-teamlink'),
            onPressed: onOpen,
            child: Text(l10n.pmOpenTeamlink),
          ),
        ],
      ),
    );
  }
}
