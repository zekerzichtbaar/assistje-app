import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import 'absences_ui.dart';

/// Wat het vakantieformulier oplevert (datums `YYYY-MM-DD`).
typedef VacationDraft = ({String startsOn, String endsOn, String? note});

/// Max. lengte van de notitie (zoals de API).
const int vacationNoteMaxLength = 80;

/// Opent de sheet "Vakantie toevoegen": van, tot en met, en een optionele
/// notitie. [onSubmit] geeft de fout terug of `null`; de sheet sluit met
/// `true` na een gelukte aanroep. Veldfouten (422) en een 422 met alleen
/// een melding blijven in de sheet staan; andere fouten worden een toast.
Future<bool?> showVacationFormSheet(
  BuildContext context, {
  required Future<Object?> Function(VacationDraft draft) onSubmit,
  DateTime? today,
}) => showAppSheet<bool>(
  context: context,
  title: AppLocalizations.of(context).absencesVacationAdd,
  scrollable: true,
  builder: (context) => _VacationForm(onSubmit: onSubmit, today: today),
);

class _VacationForm extends StatefulWidget {
  const _VacationForm({required this.onSubmit, this.today});

  final Future<Object?> Function(VacationDraft draft) onSubmit;
  final DateTime? today;

  @override
  State<_VacationForm> createState() => _VacationFormState();
}

class _VacationFormState extends State<_VacationForm> {
  final _note = TextEditingController();
  DateTime? _from;
  DateTime? _to;
  String? _datesError;
  Object? _error;
  bool _busy = false;

  DateTime get _today {
    final now = widget.today ?? DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _pick({required bool from}) async {
    unawaited(Haptics.selection());
    final today = _today;
    final first = from ? today : (_from ?? today);
    final current = from ? _from : _to;
    final initial = current != null && !current.isBefore(first)
        ? current
        : first;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: DateTime(today.year + 3, 12, 31),
      locale: const Locale('nl'),
    );
    if (picked == null || !mounted) return;
    setState(() {
      _datesError = null;
      if (from) {
        _from = picked;
        // Een einddatum vóór de nieuwe begindatum klopt niet meer.
        final to = _to;
        if (to != null && to.isBefore(picked)) _to = picked;
      } else {
        _to = picked;
      }
    });
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final from = _from;
    final to = _to;
    final datesError = from == null || to == null
        ? l10n.absencesVacationDatesRequired
        : (to.isBefore(from) ? l10n.absencesVacationEndBeforeStart : null);
    if (datesError != null) {
      unawaited(Haptics.error());
      setState(() => _datesError = datesError);
      return;
    }
    setState(() {
      _busy = true;
      _datesError = null;
      _error = null;
    });
    final note = _note.text.trim();
    final error = await widget.onSubmit((
      startsOn: isoAbsenceDate(from!),
      endsOn: isoAbsenceDate(to!),
      note: note.isEmpty ? null : note,
    ));
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      _busy = false;
      _error = error;
    });
    if (_inline(error)) {
      unawaited(Haptics.error());
    } else {
      showAbsencesError(context, l10n.absencesSaveFailed, error);
    }
  }

  /// Hoort deze fout in het formulier (422) in plaats van in een toast?
  static bool _inline(Object? error) =>
      absencesFieldError(error, 'starts_on') != null ||
      absencesFieldError(error, 'ends_on') != null ||
      absencesFieldError(error, 'note') != null ||
      isFormLevelValidation(error);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final fromError = absencesFieldError(_error, 'starts_on');
    final toError = absencesFieldError(_error, 'ends_on');
    final noteError = absencesFieldError(_error, 'note');
    final formError = isFormLevelValidation(_error)
        ? absencesErrorText(l10n, _error)
        : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (formError != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                formError,
                key: const ValueKey('vacation-form-error'),
                style: const TextStyle(
                  fontSize: 14,
                  color: StatusColors.red600,
                ),
              ),
            ),
          _DateField(
            key: const ValueKey('vacation-from'),
            label: l10n.absencesVacationFrom,
            value: _from,
            placeholder: l10n.absencesVacationPickDate,
            error: fromError,
            onTap: _busy ? null : () => _pick(from: true),
          ),
          const SizedBox(height: 12),
          _DateField(
            key: const ValueKey('vacation-to'),
            label: l10n.absencesVacationTo,
            value: _to,
            placeholder: l10n.absencesVacationPickDate,
            error: toError,
            onTap: _busy ? null : () => _pick(from: false),
          ),
          if (_datesError != null) ...[
            const SizedBox(height: 6),
            Text(
              _datesError!,
              key: const ValueKey('vacation-dates-error'),
              style: const TextStyle(fontSize: 13, color: StatusColors.red600),
            ),
          ],
          const SizedBox(height: 16),
          Text(
            l10n.absencesVacationNote,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: t.inkSoft,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            key: const ValueKey('vacation-note'),
            controller: _note,
            enabled: !_busy,
            textCapitalization: TextCapitalization.sentences,
            inputFormatters: [
              LengthLimitingTextInputFormatter(vacationNoteMaxLength),
            ],
            decoration: InputDecoration(
              hintText: l10n.absencesVacationNoteHint,
              errorText: noteError,
            ),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            key: const ValueKey('vacation-save'),
            label: l10n.absencesSave,
            expand: true,
            loading: _busy,
            onPressed: _busy ? null : _submit,
          ),
          TextButton(
            onPressed: _busy ? null : () => Navigator.of(context).pop(false),
            child: Text(l10n.absencesCancel),
          ),
        ],
      ),
    );
  }
}

/// Een tikbaar datumveld met label, waarde (of placeholder) en veldfout.
class _DateField extends StatelessWidget {
  const _DateField({
    super.key,
    required this.label,
    required this.value,
    required this.placeholder,
    required this.onTap,
    this.error,
  });

  final String label;
  final DateTime? value;
  final String placeholder;
  final VoidCallback? onTap;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final value = this.value;
    final text = value == null
        ? placeholder
        : DateFormat('EEEE d MMMM y', 'nl').format(value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: t.inkSoft,
          ),
        ),
        const SizedBox(height: 6),
        Semantics(
          button: true,
          label: label,
          value: value == null ? null : text,
          child: Material(
            color: t.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: error != null ? StatusColors.red600 : t.line,
              ),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Icon(PhosphorIconsRegular.calendarBlank, color: t.muted),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ExcludeSemantics(
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 15,
                            color: value == null ? t.muted : t.ink,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 4),
          Text(
            error!,
            style: const TextStyle(fontSize: 13, color: StatusColors.red600),
          ),
        ],
      ],
    );
  }
}
