import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/duties_repository.dart';
import '../../data/models/duties_models.dart';
import 'duties_ui.dart';

const _whoFields = ['member_key', 'player_id'];
const _groupFields = ['duty_group_id'];
const _rowFields = ['event_id', 'scheduled_for', 'starts_at', 'ends_at'];

/// Beurten inplannen, zoals `IndividualAssignmentModal` (één persoon, één
/// beurt) en `AssignmentModal` (groepen: rotatie of vaste groep, één of
/// meer datums/wedstrijden) in de PWA. [onSave] doet het verzoek en geeft
/// de fout terug; bij succes sluit de sheet met `true`.
Future<bool?> showDutyPlanSheet(
  BuildContext context, {
  required DutiesOverview overview,
  required Future<Object?> Function(DutyAssignmentDraft draft) onSave,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: overview.isIndividual
        ? l10n.dutiesAssignmentFormTitleNew
        : (overview.isMatchBound
              ? l10n.dutiesPlanFormTitleMatches
              : l10n.dutiesPlanFormTitleDates),
    scrollable: true,
    builder: (context) => DutyPlanForm(overview: overview, onSave: onSave),
  );
}

/// Eén beurt wijzigen (`EditAssignmentModal`). [onSave] krijgt de velden
/// voor `PATCH duties/assignments/{id}`.
Future<bool?> showDutyEditSheet(
  BuildContext context, {
  required DutiesOverview overview,
  required DutyAssignment assignment,
  required Future<Object?> Function(Map<String, Object?> changes) onSave,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: l10n.dutiesAssignmentFormTitleEdit,
    scrollable: true,
    builder: (context) => DutyEditForm(
      overview: overview,
      assignment: assignment,
      onSave: onSave,
    ),
  );
}

/// De invoer van één datum- of wedstrijdregel.
class _Row {
  _Row({this.date, this.eventId, this.from, this.to, String? notes})
    : notes = TextEditingController(text: notes ?? '');

  String? date;
  int? eventId;
  String? from;
  String? to;
  final TextEditingController notes;

  DutyDateRow toDraft({required bool match}) => DutyDateRow(
    date: match ? null : date,
    eventId: match ? eventId : null,
    startsAt: from,
    endsAt: to,
    notes: notes.text,
  );
}

/// Gemeenschappelijk voor beide formulieren: bezig/fout/sluiten.
mixin _FormRun<T extends StatefulWidget> on State<T> {
  bool busy = false;
  bool tried = false;
  Object? error;

  Future<void> run(Future<Object?> Function() request) async {
    setState(() {
      busy = true;
      error = null;
    });
    final result = await request();
    if (!mounted) return;
    if (result == null) {
      Navigator.of(context).pop(true);
      return;
    }
    unawaited(Haptics.error());
    setState(() {
      busy = false;
      error = result;
    });
  }
}

class DutyPlanForm extends StatefulWidget {
  const DutyPlanForm({super.key, required this.overview, required this.onSave});

  final DutiesOverview overview;
  final Future<Object?> Function(DutyAssignmentDraft draft) onSave;

  @override
  State<DutyPlanForm> createState() => _DutyPlanFormState();
}

class _DutyPlanFormState extends State<DutyPlanForm>
    with _FormRun<DutyPlanForm> {
  DutiesOverview get _o => widget.overview;

  late String? _memberKey = _o.suggestedMemberKey;
  String _mode = 'rotate';
  late int? _groupId = _o.groups.isEmpty ? null : _o.groups.first.id;
  final List<_Row> _rows = [_Row()];

  @override
  void dispose() {
    for (final row in _rows) {
      row.notes.dispose();
    }
    super.dispose();
  }

  bool get _rowsComplete =>
      _rows.every((r) => _o.isMatchBound ? r.eventId != null : r.date != null);

  Future<void> _save() async {
    setState(() => tried = true);
    if (_o.isIndividual && _memberKey == null) return;
    if (!_o.isIndividual && _mode == 'single' && _groupId == null) return;
    if (!_rowsComplete) return;
    final mode = _o.isIndividual ? 'individual' : _mode;
    await run(
      () => widget.onSave(
        DutyAssignmentDraft(
          dutyTypeId: _o.dutyTypeId,
          mode: mode,
          memberKey: mode == 'individual' ? _memberKey : null,
          groupId: mode == 'single' ? _groupId : null,
          dates: [for (final r in _rows) r.toDraft(match: _o.isMatchBound)],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final error = this.error;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null &&
            !isDutiesFieldError(
              error,
              [..._whoFields, ..._groupFields],
              prefixes: const ['dates'],
            ))
          DutiesErrorText(
            dutiesErrorText(l10n, error),
            key: const ValueKey('duty-plan-form-error'),
          ),
        if (_o.isIndividual) ...[
          DutiesFieldLabel(l10n.dutiesFormWho),
          _PersonDropdown(
            key: const ValueKey('duty-plan-form-who'),
            people: _o.peopleByCount,
            value: _memberKey,
            enabled: !busy,
            onChanged: (key) => setState(() => _memberKey = key),
            errorText:
                dutiesFieldError(error, _whoFields) ??
                (tried && _memberKey == null
                    ? l10n.dutiesFormWhoRequired
                    : null),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              l10n.dutiesFormWhoSorted,
              style: TextStyle(fontSize: 12, color: t.muted),
            ),
          ),
        ] else ...[
          DutiesFieldLabel(l10n.dutiesFormMode),
          Wrap(
            spacing: 6,
            children: [
              for (final (mode, label) in [
                ('rotate', l10n.dutiesFormModeRotate),
                ('single', l10n.dutiesFormModeSingle),
              ])
                AppPill(
                  key: ValueKey('duty-plan-form-mode-$mode'),
                  label: label,
                  selected: _mode == mode,
                  onTap: busy
                      ? null
                      : () {
                          Haptics.selection();
                          setState(() => _mode = mode);
                        },
                ),
            ],
          ),
          if (_mode == 'single') ...[
            const SizedBox(height: 12),
            DutiesFieldLabel(l10n.dutiesFormGroup),
            _GroupDropdown(
              key: const ValueKey('duty-plan-form-group'),
              groups: _o.groups,
              value: _groupId,
              enabled: !busy,
              onChanged: (id) => setState(() => _groupId = id),
              errorText:
                  dutiesFieldError(error, _groupFields) ??
                  (tried && _groupId == null
                      ? l10n.dutiesFormGroupRequired
                      : null),
            ),
          ],
        ],
        for (final (index, row) in _rows.indexed) ...[
          const SizedBox(height: 16),
          if (_rows.length > 1)
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${index + 1}.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: t.inkSoft,
                    ),
                  ),
                ),
                TextButton(
                  key: ValueKey('duty-plan-form-row-$index-remove'),
                  onPressed: busy
                      ? null
                      : () {
                          final removed = _rows.removeAt(index);
                          setState(() {});
                          WidgetsBinding.instance.addPostFrameCallback(
                            (_) => removed.notes.dispose(),
                          );
                        },
                  style: TextButton.styleFrom(foregroundColor: t.muted),
                  child: Text(l10n.dutiesFormRemoveRow),
                ),
              ],
            ),
          _RowFields(
            keyPrefix: 'duty-plan-form-row-$index',
            row: row,
            matches: _o.matches,
            match: _o.isMatchBound,
            enabled: !busy,
            onChanged: () => setState(() {}),
            requiredError: tried
                ? (_o.isMatchBound
                      ? (row.eventId == null
                            ? l10n.dutiesFormMatchRequired
                            : null)
                      : (row.date == null ? l10n.dutiesFormDateRequired : null))
                : null,
            fieldError: dutiesFieldError(error, [
              'dates.$index.event_id',
              'dates.$index.date',
              'dates.$index.starts_at',
              'dates.$index.ends_at',
              'dates.$index.notes',
              if (index == 0) 'dates',
            ]),
          ),
        ],
        if (!_o.isIndividual)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              key: const ValueKey('duty-plan-form-add-row'),
              onPressed: busy ? null : () => setState(() => _rows.add(_Row())),
              icon: const Icon(PhosphorIconsBold.plus, size: 14),
              label: Text(
                _o.isMatchBound
                    ? l10n.dutiesFormAddMatchRow
                    : l10n.dutiesFormAddDateRow,
              ),
            ),
          ),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('duty-plan-form-save'),
          label: l10n.dutiesSave,
          expand: true,
          loading: busy,
          onPressed: busy ? null : _save,
        ),
        const SizedBox(height: 8),
        TextButton(
          key: const ValueKey('duty-plan-form-cancel'),
          onPressed: busy ? null : () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(foregroundColor: t.muted),
          child: Text(l10n.dutiesCancel),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class DutyEditForm extends StatefulWidget {
  const DutyEditForm({
    super.key,
    required this.overview,
    required this.assignment,
    required this.onSave,
  });

  final DutiesOverview overview;
  final DutyAssignment assignment;
  final Future<Object?> Function(Map<String, Object?> changes) onSave;

  @override
  State<DutyEditForm> createState() => _DutyEditFormState();
}

class _DutyEditFormState extends State<DutyEditForm>
    with _FormRun<DutyEditForm> {
  DutiesOverview get _o => widget.overview;

  late String? _memberKey = widget.assignment.memberKey;
  late int? _groupId = widget.assignment.groupId;
  late final _Row _row = _Row(
    date: widget.assignment.scheduledFor.isEmpty
        ? null
        : widget.assignment.scheduledFor,
    eventId: widget.assignment.eventId,
    from: widget.assignment.startsAt,
    to: widget.assignment.endsAt,
    notes: widget.assignment.notes,
  );

  @override
  void dispose() {
    _row.notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => tried = true);
    if (_o.isIndividual && _memberKey == null) return;
    if (!_o.isIndividual && _groupId == null) return;
    if (_o.isMatchBound ? _row.eventId == null : _row.date == null) return;
    final note = _row.notes.text.trim();
    await run(
      () => widget.onSave({
        if (_o.isIndividual)
          'member_key': _memberKey
        else
          'duty_group_id': _groupId,
        if (_o.isMatchBound)
          'event_id': _row.eventId
        else
          'scheduled_for': _row.date,
        'starts_at': _row.from,
        'ends_at': _row.to,
        'notes': note.isEmpty ? null : note,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final error = this.error;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null &&
            !isDutiesFieldError(error, [
              ..._whoFields,
              ..._groupFields,
              ..._rowFields,
              'notes',
            ]))
          DutiesErrorText(
            dutiesErrorText(l10n, error),
            key: const ValueKey('duty-edit-form-error'),
          ),
        if (_o.isIndividual) ...[
          DutiesFieldLabel(l10n.dutiesFormWho),
          _PersonDropdown(
            key: const ValueKey('duty-edit-form-who'),
            people: _o.peopleByCount,
            value: _memberKey,
            enabled: !busy,
            onChanged: (key) => setState(() => _memberKey = key),
            errorText:
                dutiesFieldError(error, _whoFields) ??
                (tried && _memberKey == null
                    ? l10n.dutiesFormWhoRequired
                    : null),
          ),
        ] else ...[
          DutiesFieldLabel(l10n.dutiesFormGroup),
          _GroupDropdown(
            key: const ValueKey('duty-edit-form-group'),
            groups: _o.groups,
            value: _groupId,
            enabled: !busy,
            onChanged: (id) => setState(() => _groupId = id),
            errorText:
                dutiesFieldError(error, _groupFields) ??
                (tried && _groupId == null
                    ? l10n.dutiesFormGroupRequired
                    : null),
          ),
        ],
        const SizedBox(height: 16),
        _RowFields(
          keyPrefix: 'duty-edit-form',
          row: _row,
          matches: _o.matches,
          match: _o.isMatchBound,
          enabled: !busy,
          onChanged: () => setState(() {}),
          requiredError: tried
              ? (_o.isMatchBound
                    ? (_row.eventId == null
                          ? l10n.dutiesFormMatchRequired
                          : null)
                    : (_row.date == null ? l10n.dutiesFormDateRequired : null))
              : null,
          fieldError: dutiesFieldError(error, [..._rowFields, 'notes']),
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('duty-edit-form-save'),
          label: l10n.dutiesSave,
          expand: true,
          loading: busy,
          onPressed: busy ? null : _save,
        ),
        const SizedBox(height: 8),
        TextButton(
          key: const ValueKey('duty-edit-form-cancel'),
          onPressed: busy ? null : () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(foregroundColor: t.muted),
          child: Text(l10n.dutiesCancel),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

/// Wedstrijd of datum, van/tot en notitie van één regel.
class _RowFields extends StatelessWidget {
  const _RowFields({
    required this.keyPrefix,
    required this.row,
    required this.matches,
    required this.match,
    required this.enabled,
    required this.onChanged,
    this.requiredError,
    this.fieldError,
  });

  final String keyPrefix;
  final _Row row;
  final List<DutyMatch> matches;
  final bool match;
  final bool enabled;
  final VoidCallback onChanged;
  final String? requiredError;
  final String? fieldError;

  Future<void> _pickDate(BuildContext context) async {
    unawaited(Haptics.selection());
    final now = DateTime.now();
    final current = row.date == null ? null : DateTime.tryParse(row.date!);
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 3, 12, 31),
      locale: const Locale('nl'),
    );
    if (picked == null) return;
    row.date =
        '${picked.year.toString().padLeft(4, '0')}-'
        '${picked.month.toString().padLeft(2, '0')}-'
        '${picked.day.toString().padLeft(2, '0')}';
    onChanged();
  }

  Future<void> _pickTime(BuildContext context, {required bool from}) async {
    unawaited(Haptics.selection());
    final current = from ? row.from : row.to;
    final parts = current?.split(':');
    final initial = parts != null && parts.length >= 2
        ? TimeOfDay(
            hour: int.tryParse(parts[0]) ?? 12,
            minute: int.tryParse(parts[1]) ?? 0,
          )
        : const TimeOfDay(hour: 12, minute: 0);
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked == null) return;
    final value =
        '${picked.hour.toString().padLeft(2, '0')}:'
        '${picked.minute.toString().padLeft(2, '0')}';
    if (from) {
      row.from = value;
    } else {
      row.to = value;
    }
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final error = fieldError ?? requiredError;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (match) ...[
          DutiesFieldLabel(l10n.dutiesFormMatch),
          DropdownButtonFormField<int>(
            key: ValueKey('$keyPrefix-match'),
            initialValue: matches.any((m) => m.id == row.eventId)
                ? row.eventId
                : null,
            isExpanded: true,
            hint: Text(l10n.dutiesFormMatchHint),
            decoration: InputDecoration(errorText: error),
            items: [
              for (final m in matches)
                DropdownMenuItem(
                  value: m.id,
                  child: Text(
                    '${dutiesDateLabel(m.date)} · ${m.label}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
            onChanged: enabled
                ? (id) {
                    row.eventId = id;
                    onChanged();
                  }
                : null,
          ),
        ] else ...[
          DutiesFieldLabel(l10n.dutiesFormDate),
          _PickerField(
            key: ValueKey('$keyPrefix-date'),
            icon: PhosphorIconsBold.calendarBlank,
            text: row.date == null
                ? l10n.dutiesFormDateHint
                : dutiesDateLabel(row.date!),
            placeholder: row.date == null,
            errorText: error,
            onTap: enabled ? () => _pickDate(context) : null,
          ),
        ],
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final from in [true, false]) ...[
              if (!from) const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DutiesFieldLabel(
                      from ? l10n.dutiesFormFrom : l10n.dutiesFormTo,
                    ),
                    _PickerField(
                      key: ValueKey('$keyPrefix-${from ? 'from' : 'to'}'),
                      icon: PhosphorIconsBold.clock,
                      text: _timeText(from ? row.from : row.to),
                      placeholder: (from ? row.from : row.to) == null,
                      onTap: enabled
                          ? () => _pickTime(context, from: from)
                          : null,
                      onClear: enabled && (from ? row.from : row.to) != null
                          ? () {
                              if (from) {
                                row.from = null;
                              } else {
                                row.to = null;
                              }
                              onChanged();
                            }
                          : null,
                      clearLabel: l10n.dutiesFormClear,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        DutiesFieldLabel(l10n.dutiesFormNotes),
        TextField(
          key: ValueKey('$keyPrefix-notes'),
          controller: row.notes,
          enabled: enabled,
          maxLength: 255,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(counterText: ''),
        ),
      ],
    );
  }
}

String _timeText(String? time) =>
    time == null ? '--:--' : dutiesTimeLabel(time);

/// Een tikveld dat een kiezer opent (datum/tijd).
class _PickerField extends StatelessWidget {
  const _PickerField({
    super.key,
    required this.icon,
    required this.text,
    required this.placeholder,
    this.onTap,
    this.onClear,
    this.clearLabel,
    this.errorText,
  });

  final IconData icon;
  final String text;
  final bool placeholder;
  final VoidCallback? onTap;
  final VoidCallback? onClear;
  final String? clearLabel;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      child: InputDecorator(
        decoration: InputDecoration(
          errorText: errorText,
          prefixIcon: Icon(icon, size: 16, color: t.muted),
          suffixIcon: onClear == null
              ? null
              : IconButton(
                  tooltip: clearLabel,
                  visualDensity: VisualDensity.compact,
                  icon: Icon(PhosphorIconsBold.x, size: 14, color: t.muted),
                  onPressed: onClear,
                ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 15, color: placeholder ? t.muted : t.ink),
        ),
      ),
    );
  }
}

class _PersonDropdown extends StatelessWidget {
  const _PersonDropdown({
    super.key,
    required this.people,
    required this.value,
    required this.enabled,
    required this.onChanged,
    this.errorText,
  });

  final List<DutyPerson> people;
  final String? value;
  final bool enabled;
  final ValueChanged<String?> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DropdownButtonFormField<String>(
      initialValue: people.any((p) => p.key == value) ? value : null,
      isExpanded: true,
      hint: Text(l10n.dutiesFormWhoHint),
      decoration: InputDecoration(errorText: errorText),
      items: [
        for (final p in people)
          DropdownMenuItem(
            value: p.key,
            child: Text(
              '${dutiesPersonLabel(l10n, p)} · ${p.count}×',
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      onChanged: enabled ? onChanged : null,
    );
  }
}

class _GroupDropdown extends StatelessWidget {
  const _GroupDropdown({
    super.key,
    required this.groups,
    required this.value,
    required this.enabled,
    required this.onChanged,
    this.errorText,
  });

  final List<DutyGroup> groups;
  final int? value;
  final bool enabled;
  final ValueChanged<int?> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DropdownButtonFormField<int>(
      initialValue: groups.any((g) => g.id == value) ? value : null,
      isExpanded: true,
      hint: Text(l10n.dutiesFormGroupHint),
      decoration: InputDecoration(errorText: errorText),
      items: [
        for (final g in groups)
          DropdownMenuItem(
            value: g.id,
            child: Text(
              '${g.name} (${g.count}×)',
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      onChanged: enabled ? onChanged : null,
    );
  }
}
