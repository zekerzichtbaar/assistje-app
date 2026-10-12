import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/player_management_models.dart';
import 'add_person_sheet.dart';
import 'pm_ui.dart';

/// "Speler bewerken" (`Trainer/Players/Edit.tsx`): naam, rugnummer, positie,
/// sterkte, geboortedatum, gast en e-mail. 422-fouten komen onder het veld.
/// Geeft `true` terug als er is opgeslagen.
Future<bool?> showPlayerEditSheet(
  BuildContext context, {
  required ManagedPlayer player,
  required Map<String, String> positions,
  required Future<Object?> Function(PlayerUpdate update) onSave,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: l10n.pmEditTitle,
    scrollable: true,
    builder: (context) =>
        _PlayerEditForm(player: player, positions: positions, onSave: onSave),
  );
}

class _PlayerEditForm extends StatefulWidget {
  const _PlayerEditForm({
    required this.player,
    required this.positions,
    required this.onSave,
  });

  final ManagedPlayer player;
  final Map<String, String> positions;
  final Future<Object?> Function(PlayerUpdate update) onSave;

  @override
  State<_PlayerEditForm> createState() => _PlayerEditFormState();
}

class _PlayerEditFormState extends State<_PlayerEditForm> {
  late final _name = TextEditingController(text: widget.player.name);
  late final _shirt = TextEditingController(
    text: widget.player.shirtNumber?.toString() ?? '',
  );
  late final _email = TextEditingController(text: widget.player.email ?? '');
  late String? _position = widget.player.position;
  late int? _strength = widget.player.strength;
  late bool _isGuest = widget.player.isGuest;
  late DateTime? _birthdate = DateTime.tryParse(widget.player.birthdate ?? '');
  bool _busy = false;
  Map<String, String> _fieldErrors = const {};
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _shirt.dispose();
    _email.dispose();
    super.dispose();
  }

  static String _dateOnly(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  Future<void> _pickBirthdate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthdate ?? DateTime(now.year - 25),
      firstDate: DateTime(1920),
      lastDate: now.subtract(const Duration(days: 1)),
    );
    if (picked != null && mounted) setState(() => _birthdate = picked);
  }

  Future<void> _save() async {
    if (_busy) return;
    final l10n = AppLocalizations.of(context);
    final name = _name.text.trim();
    final email = _email.text.trim();
    final errors = <String, String>{
      if (name.isEmpty) 'name': l10n.pmNameRequired,
      if (email.isNotEmpty && !looksLikeEmail(email))
        'email': l10n.pmEmailInvalid,
    };
    if (errors.isNotEmpty) {
      setState(() => _fieldErrors = errors);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
      _fieldErrors = const {};
    });
    final error = await widget.onSave(
      PlayerUpdate(
        name: name,
        shirtNumber: int.tryParse(_shirt.text.trim()),
        position: _position,
        birthdate: _birthdate == null ? null : _dateOnly(_birthdate!),
        email: email,
        strength: _strength,
        isGuest: _isGuest,
      ),
    );
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      _busy = false;
      if (error is ValidationException) {
        _fieldErrors = {
          for (final field in const [
            'name',
            'shirt_number',
            'position',
            'strength',
            'birthdate',
            'email',
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
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              _error!,
              key: const ValueKey('pm-edit-error'),
              style: const TextStyle(fontSize: 14, color: StatusColors.red600),
            ),
          ),
        PmFieldLabel(l10n.pmFieldName),
        TextField(
          key: const ValueKey('pm-edit-name'),
          controller: _name,
          enabled: !_busy,
          maxLength: 120,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          decoration: InputDecoration(
            counterText: '',
            errorText: _fieldErrors['name'],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PmFieldLabel(l10n.pmFieldShirt),
                  TextField(
                    key: const ValueKey('pm-edit-shirt'),
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
            if (widget.positions.isNotEmpty || _position != null) ...[
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PmFieldLabel(l10n.pmFieldPosition),
                    PositionDropdown(
                      key: const ValueKey('pm-edit-position'),
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
        const SizedBox(height: 12),
        PmFieldLabel(l10n.pmFieldStrength),
        Row(
          key: const ValueKey('pm-edit-strength'),
          children: [
            for (var level = 1; level <= 5; level++)
              IconButton(
                key: ValueKey('pm-edit-strength-$level'),
                tooltip: '$level',
                onPressed: _busy
                    ? null
                    : () => setState(() => _strength = level),
                icon: Icon(
                  (_strength ?? 0) >= level
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  color: (_strength ?? 0) >= level
                      ? StatusColors.amber500
                      : t.muted,
                ),
              ),
          ],
        ),
        if (_fieldErrors['strength'] != null)
          Text(
            _fieldErrors['strength']!,
            style: const TextStyle(fontSize: 12, color: StatusColors.red600),
          ),
        const SizedBox(height: 8),
        PmFieldLabel(l10n.pmFieldBirthdate),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                key: const ValueKey('pm-edit-birthdate'),
                onPressed: _busy ? null : _pickBirthdate,
                style: OutlinedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  minimumSize: const Size.fromHeight(48),
                ),
                child: Text(
                  _birthdate == null
                      ? l10n.pmBirthdatePick
                      : DateFormat('d MMMM y', 'nl').format(_birthdate!),
                  style: TextStyle(color: _birthdate == null ? t.muted : t.ink),
                ),
              ),
            ),
            if (_birthdate != null)
              TextButton(
                key: const ValueKey('pm-edit-birthdate-clear'),
                onPressed: _busy
                    ? null
                    : () => setState(() => _birthdate = null),
                child: Text(l10n.pmClear),
              ),
          ],
        ),
        if (_fieldErrors['birthdate'] != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _fieldErrors['birthdate']!,
              style: const TextStyle(fontSize: 12, color: StatusColors.red600),
            ),
          ),
        const SizedBox(height: 4),
        CheckboxListTile(
          key: const ValueKey('pm-edit-guest'),
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: _isGuest,
          onChanged: _busy
              ? null
              : (v) => setState(() => _isGuest = v ?? false),
          title: Text(l10n.pmFieldGuest, style: const TextStyle(fontSize: 14)),
        ),
        PmFieldLabel(l10n.pmFieldEmail),
        TextField(
          key: const ValueKey('pm-edit-email'),
          controller: _email,
          enabled: !_busy,
          maxLength: 255,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          decoration: InputDecoration(
            counterText: '',
            hintText: l10n.pmOptional,
            errorText: _fieldErrors['email'],
          ),
        ),
        const SizedBox(height: 20),
        PrimaryButton(
          key: const ValueKey('pm-edit-save'),
          label: l10n.pmSave,
          expand: true,
          loading: _busy,
          onPressed: _busy ? null : _save,
        ),
      ],
    );
  }
}
