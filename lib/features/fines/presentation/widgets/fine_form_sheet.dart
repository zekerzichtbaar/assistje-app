import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/money.dart';
import '../../data/fines_repository.dart';
import '../../data/models/fines_models.dart';
import 'fines_ui.dart';

/// Wat het uitdeelformulier instuurt.
class FineDraft {
  const FineDraft({
    required this.targets,
    required this.typeId,
    required this.amountCents,
    this.description,
  });

  final FineTargets targets;
  final int typeId;
  final int amountCents;
  final String? description;
}

/// Hoogste bedrag van één boete (`amount_cents` max. 100000).
const int maxFineCents = 100000;

/// "Boete uitdelen": wie (hele team of een selectie), soort, bedrag en
/// omschrijving. [onSubmit] doet het verzoek en geeft de fout terug (of
/// `null`); bij succes sluit de sheet met `true`.
Future<bool?> showFineFormSheet(
  BuildContext context, {
  required List<FineRow> people,
  required List<FineType> types,
  required Future<Object?> Function(FineDraft draft) onSubmit,
  String? preselectedKey,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: l10n.finesFormTitle,
    scrollable: true,
    builder: (context) => FineForm(
      people: people,
      types: types,
      onSubmit: onSubmit,
      preselectedKey: preselectedKey,
    ),
  );
}

class FineForm extends StatefulWidget {
  const FineForm({
    super.key,
    required this.people,
    required this.types,
    required this.onSubmit,
    this.preselectedKey,
  });

  final List<FineRow> people;
  final List<FineType> types;
  final Future<Object?> Function(FineDraft draft) onSubmit;
  final String? preselectedKey;

  @override
  State<FineForm> createState() => _FineFormState();
}

class _FineFormState extends State<FineForm> {
  final _amount = TextEditingController();
  final _description = TextEditingController();
  late final Set<String> _selected = {?widget.preselectedKey};
  bool _everyone = false;
  FineType? _type;
  bool _saving = false;
  bool _tried = false;
  Object? _error;

  @override
  void dispose() {
    _amount.dispose();
    _description.dispose();
    super.dispose();
  }

  void _pickType(FineType type) {
    Haptics.selection();
    setState(() {
      _type = type;
      _amount.text = centsToInput(type.defaultCents);
    });
  }

  void _togglePerson(String key) {
    Haptics.selection();
    setState(() {
      _everyone = false;
      if (!_selected.remove(key)) _selected.add(key);
    });
  }

  int? get _cents {
    final cents = parseEuroToCents(_amount.text);
    if (cents == null || cents < 0 || cents > maxFineCents) return null;
    return cents;
  }

  bool get _hasPeople => _everyone || _selected.isNotEmpty;

  FineTargets get _targets {
    if (_everyone) return const FineTargets.everyone();
    final players = <int>[];
    final users = <int>[];
    for (final row in widget.people) {
      if (!_selected.contains(row.key)) continue;
      if (row.playerId != null) {
        players.add(row.playerId!);
      } else if (row.userId != null) {
        users.add(row.userId!);
      }
    }
    return FineTargets(playerIds: players, userIds: users);
  }

  Future<void> _submit() async {
    setState(() => _tried = true);
    final type = _type;
    final cents = _cents;
    if (!_hasPeople || type == null || cents == null) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    final description = _description.text.trim();
    final error = await widget.onSubmit(
      FineDraft(
        targets: _targets,
        typeId: type.id,
        amountCents: cents,
        description: description.isEmpty ? null : description,
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final label = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: t.inkSoft,
    );
    final error = _error;
    final amountError =
        finesFieldError(error, 'amount_cents') ??
        (_tried && _cents == null ? l10n.finesFormAmountInvalid : null);

    if (widget.types.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          l10n.finesNoTypes,
          key: const ValueKey('fine-form-no-types'),
          style: TextStyle(fontSize: 14, color: t.muted),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null)
          FinesFormError(
            finesErrorText(l10n, error),
            key: const ValueKey('fine-form-error'),
          ),
        Text(
          l10n.finesFormCurrentPeriodNote,
          style: TextStyle(fontSize: 13, color: t.muted),
        ),
        const SizedBox(height: 12),
        Text(l10n.finesFormWho, style: label),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            AppPill(
              key: const ValueKey('fine-form-everyone'),
              label: l10n.finesFormEveryone,
              selected: _everyone,
              onTap: () {
                Haptics.selection();
                setState(() {
                  _everyone = !_everyone;
                  if (_everyone) _selected.clear();
                });
              },
            ),
            for (final row in widget.people)
              AppPill(
                key: ValueKey('fine-form-person-${row.key}'),
                label: row.name,
                selected: _selected.contains(row.key),
                onTap: () => _togglePerson(row.key),
              ),
          ],
        ),
        if (_tried && !_hasPeople)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              l10n.finesFormNoPerson,
              key: const ValueKey('fine-form-no-person'),
              style: const TextStyle(fontSize: 13, color: StatusColors.red600),
            ),
          ),
        const SizedBox(height: 16),
        Text(l10n.finesFormType, style: label),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final type in widget.types)
              AppPill(
                key: ValueKey('fine-form-type-${type.id}'),
                label: '${type.label} · ${formatCents(type.defaultCents)}',
                selected: _type?.id == type.id,
                onTap: () => _pickType(type),
              ),
          ],
        ),
        if (_tried && _type == null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              l10n.finesFormNoType,
              key: const ValueKey('fine-form-no-type'),
              style: const TextStyle(fontSize: 13, color: StatusColors.red600),
            ),
          ),
        const SizedBox(height: 16),
        Text(l10n.finesFormAmount, style: label),
        const SizedBox(height: 4),
        TextField(
          key: const ValueKey('fine-form-amount'),
          controller: _amount,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: l10n.finesFormAmountHint,
            errorText: amountError,
          ),
        ),
        const SizedBox(height: 12),
        Text(l10n.finesFormDescription, style: label),
        const SizedBox(height: 4),
        TextField(
          key: const ValueKey('fine-form-description'),
          controller: _description,
          maxLength: 255,
          decoration: InputDecoration(
            counterText: '',
            errorText: finesFieldError(error, 'description'),
          ),
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('fine-form-submit'),
          label: l10n.finesFormSubmit,
          expand: true,
          loading: _saving,
          onPressed: _saving ? null : _submit,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
