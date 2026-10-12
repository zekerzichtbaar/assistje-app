import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/duties_models.dart';
import 'duties_ui.dart';

const _fields = ['name', 'member_keys', 'duty_type_id'];

/// Nieuwe groep, of (met [group]) groep bewerken of verwijderen, zoals
/// `GroupModal` in de PWA: naam plus leden uit [people] (`all_people`).
/// [onSave]/[onDelete] doen het verzoek en geven de fout terug; bij succes
/// sluit de sheet met `true`.
Future<bool?> showDutyGroupSheet(
  BuildContext context, {
  DutyGroup? group,
  required List<DutyPerson> people,
  required Future<Object?> Function(String name, List<String> memberKeys)
  onSave,
  Future<Object?> Function()? onDelete,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: group == null
        ? l10n.dutiesGroupFormTitleNew
        : l10n.dutiesGroupFormTitleEdit,
    scrollable: true,
    builder: (context) => DutyGroupForm(
      group: group,
      people: people,
      onSave: onSave,
      onDelete: onDelete,
    ),
  );
}

class DutyGroupForm extends StatefulWidget {
  const DutyGroupForm({
    super.key,
    this.group,
    required this.people,
    required this.onSave,
    this.onDelete,
  });

  final DutyGroup? group;
  final List<DutyPerson> people;
  final Future<Object?> Function(String name, List<String> memberKeys) onSave;
  final Future<Object?> Function()? onDelete;

  @override
  State<DutyGroupForm> createState() => _DutyGroupFormState();
}

class _DutyGroupFormState extends State<DutyGroupForm> {
  late final _name = TextEditingController(text: widget.group?.name ?? '');
  late final List<String> _members = [
    for (final m in widget.group?.members ?? const <DutyMember>[]) m.key,
  ];
  bool _busy = false;
  bool _tried = false;
  Object? _error;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _run(Future<Object?> Function() request) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await request();
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    unawaited(Haptics.error());
    setState(() {
      _busy = false;
      _error = error;
    });
  }

  Future<void> _save() async {
    setState(() => _tried = true);
    if (_name.text.trim().isEmpty) return;
    // In de volgorde van de lijst, niet van aanvinken.
    final keys = [
      for (final p in widget.people)
        if (_members.contains(p.key)) p.key,
      for (final key in _members)
        if (!widget.people.any((p) => p.key == key)) key,
    ];
    await _run(() => widget.onSave(_name.text, keys));
  }

  Future<void> _delete() async {
    final onDelete = widget.onDelete;
    final group = widget.group;
    if (onDelete == null || group == null) return;
    final l10n = AppLocalizations.of(context);
    if (!await confirmDuties(
      context,
      l10n.dutiesGroupDeleteConfirm(group.name),
    )) {
      return;
    }
    await _run(onDelete);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final error = _error;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null && !isDutiesFieldError(error, _fields))
          DutiesErrorText(
            dutiesErrorText(l10n, error),
            key: const ValueKey('duty-group-form-error'),
          ),
        DutiesFieldLabel(l10n.dutiesGroupFormName),
        TextField(
          key: const ValueKey('duty-group-form-name'),
          controller: _name,
          maxLength: 80,
          textCapitalization: TextCapitalization.sentences,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            counterText: '',
            hintText: l10n.dutiesGroupFormNameHint,
            errorText:
                dutiesFieldError(error, const ['name']) ??
                (_tried && _name.text.trim().isEmpty
                    ? l10n.dutiesGroupFormNameRequired
                    : null),
          ),
        ),
        const SizedBox(height: 16),
        DutiesFieldLabel(l10n.dutiesGroupFormMembers),
        if (widget.people.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              l10n.dutiesNoPeople,
              style: TextStyle(fontSize: 14, color: t.muted),
            ),
          )
        else
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: t.line),
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
            ),
            child: Column(
              children: [
                for (final person in widget.people)
                  CheckboxListTile(
                    key: ValueKey('duty-group-form-member-${person.key}'),
                    dense: true,
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    value: _members.contains(person.key),
                    onChanged: _busy
                        ? null
                        : (checked) {
                            Haptics.selection();
                            setState(() {
                              if (checked ?? false) {
                                _members.add(person.key);
                              } else {
                                _members.remove(person.key);
                              }
                            });
                          },
                    title: Text(
                      dutiesPersonLabel(l10n, person),
                      style: TextStyle(fontSize: 14, color: t.ink),
                    ),
                  ),
              ],
            ),
          ),
        if (dutiesFieldError(error, const ['member_keys']) case final message?)
          DutiesErrorText(message, bottom: 0),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('duty-group-form-save'),
          label: l10n.dutiesSave,
          expand: true,
          loading: _busy,
          onPressed: _busy ? null : _save,
        ),
        const SizedBox(height: 8),
        if (widget.onDelete != null)
          TextButton(
            key: const ValueKey('duty-group-form-delete'),
            onPressed: _busy ? null : _delete,
            style: TextButton.styleFrom(foregroundColor: StatusColors.red600),
            child: Text(l10n.dutiesDelete),
          )
        else
          TextButton(
            key: const ValueKey('duty-group-form-cancel'),
            onPressed: _busy ? null : () => Navigator.of(context).pop(false),
            style: TextButton.styleFrom(foregroundColor: t.muted),
            child: Text(l10n.dutiesCancel),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}
