import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/seasons_models.dart';
import 'seasons_ui.dart';

/// Max. lengte van een periodenaam (zoals de API).
const int periodNameMaxLength = 40;

/// Opent het periodeformulier: nieuw ([period] `null`, `NewPeriodForm` in
/// SeasonTab.tsx) of bestaand. Bij een nieuwe periode staan de datums al
/// op [defaultFrom] en [defaultTo].
///
/// In de modus `matches` mag de einddatum leeg (schuift mee) en is er een
/// veld voor het aantal wedstrijden. [onSubmit] geeft de fout terug of
/// `null`; de sheet sluit met `true` na een gelukte aanroep.
Future<bool?> showPeriodFormSheet(
  BuildContext context, {
  required SeasonPeriod? period,
  required PeriodMode mode,
  required Future<Object?> Function(PeriodInput input) onSubmit,
  DateTime? defaultFrom,
  DateTime? defaultTo,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: period == null ? l10n.seasonsPeriodAdd : l10n.seasonsPeriodEditTitle,
    scrollable: true,
    builder: (context) => _PeriodForm(
      period: period,
      mode: mode,
      onSubmit: onSubmit,
      defaultFrom: defaultFrom,
      defaultTo: defaultTo,
    ),
  );
}

class _PeriodForm extends StatefulWidget {
  const _PeriodForm({
    required this.period,
    required this.mode,
    required this.onSubmit,
    this.defaultFrom,
    this.defaultTo,
  });

  final SeasonPeriod? period;
  final PeriodMode mode;
  final Future<Object?> Function(PeriodInput input) onSubmit;
  final DateTime? defaultFrom;
  final DateTime? defaultTo;

  @override
  State<_PeriodForm> createState() => _PeriodFormState();
}

class _PeriodFormState extends State<_PeriodForm> {
  late final TextEditingController _name = TextEditingController(
    text: widget.period?.name ?? '',
  );
  late final TextEditingController _target = TextEditingController(
    text: widget.period?.targetMatches?.toString() ?? '',
  );
  late DateTime? _from = widget.period == null
      ? widget.defaultFrom
      : parseSeasonDate(widget.period!.startsOn);
  late DateTime? _to = widget.period == null
      ? widget.defaultTo
      : parseSeasonDate(widget.period!.endsOn);
  String? _nameError;
  String? _datesError;
  String? _targetError;
  Object? _error;
  bool _busy = false;

  bool get _isNew => widget.period == null;

  /// Einddatum mag leeg: alleen bij een bestaande periode op wedstrijden.
  bool get _openEndAllowed => !_isNew && widget.mode == PeriodMode.matches;

  bool get _showTarget => !_isNew && widget.mode == PeriodMode.matches;

  @override
  void dispose() {
    _name.dispose();
    _target.dispose();
    super.dispose();
  }

  Future<void> _pick({required bool from}) async {
    unawaited(Haptics.selection());
    final picked = await pickSeasonDate(
      context,
      initial: from ? _from : (_to ?? _from),
    );
    if (picked == null || !mounted) return;
    setState(() {
      _datesError = null;
      if (from) {
        _from = picked;
      } else {
        _to = picked;
      }
    });
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final name = _name.text.trim();
    final from = _from;
    final to = _to;
    final targetText = _target.text.trim();
    final target = targetText.isEmpty ? null : int.tryParse(targetText);

    final nameError = name.isEmpty ? l10n.seasonsPeriodNameRequired : null;
    String? datesError;
    if (from == null || (to == null && !_openEndAllowed)) {
      datesError = l10n.seasonsDatesRequired;
    } else if (to != null && !to.isAfter(from)) {
      datesError = l10n.seasonsEndBeforeStart;
    }
    final targetError =
        _showTarget &&
            targetText.isNotEmpty &&
            (target == null || target < 1 || target > 50)
        ? l10n.seasonsPeriodTargetInvalid
        : null;
    if (nameError != null || datesError != null || targetError != null) {
      unawaited(Haptics.error());
      setState(() {
        _nameError = nameError;
        _datesError = datesError;
        _targetError = targetError;
      });
      return;
    }

    setState(() {
      _busy = true;
      _nameError = null;
      _datesError = null;
      _targetError = null;
      _error = null;
    });
    final error = await widget.onSubmit(
      PeriodInput(
        name: name,
        startsOn: isoSeasonDate(from!),
        endsOn: to == null ? null : isoSeasonDate(to),
        targetMatches: target,
        includeTarget: _showTarget,
      ),
    );
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
      showSeasonsError(context, error);
    }
  }

  static bool _inline(Object? error) =>
      seasonsFieldError(error, [
            'name',
            'starts_on',
            'ends_on',
            'target_matches',
          ]) !=
          null ||
      isSeasonsFormLevel(error);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final nameError = _nameError ?? seasonsFieldError(_error, ['name']);
    final fromError = seasonsFieldError(_error, ['starts_on']);
    final toError = seasonsFieldError(_error, ['ends_on']);
    final targetError =
        _targetError ?? seasonsFieldError(_error, ['target_matches']);
    final formError = isSeasonsFormLevel(_error)
        ? seasonsErrorText(l10n, _error)
        : null;
    final labelStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: t.inkSoft,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (formError != null)
            SeasonsFormError(
              formError,
              key: const ValueKey('period-form-error'),
            ),
          Text(l10n.seasonsPeriodName, style: labelStyle),
          const SizedBox(height: 6),
          TextField(
            key: const ValueKey('period-name'),
            controller: _name,
            enabled: !_busy,
            textCapitalization: TextCapitalization.sentences,
            inputFormatters: [
              LengthLimitingTextInputFormatter(periodNameMaxLength),
            ],
            decoration: InputDecoration(
              hintText: l10n.seasonsPeriodNameHint,
              errorText: nameError,
            ),
          ),
          const SizedBox(height: 16),
          SeasonDateField(
            key: const ValueKey('period-from'),
            label: l10n.seasonsPeriodFrom,
            value: _from,
            placeholder: l10n.seasonsPickDate,
            error: fromError,
            onTap: _busy ? null : () => _pick(from: true),
          ),
          const SizedBox(height: 12),
          SeasonDateField(
            key: const ValueKey('period-to'),
            label: l10n.seasonsPeriodTo,
            value: _to,
            placeholder: _openEndAllowed
                ? l10n.seasonsPeriodToOpen
                : l10n.seasonsPickDate,
            error: toError,
            onTap: _busy ? null : () => _pick(from: false),
            clearLabel: l10n.seasonsPeriodClearEnd,
            onClear: _openEndAllowed && !_busy
                ? () => setState(() => _to = null)
                : null,
          ),
          if (_datesError != null) ...[
            const SizedBox(height: 6),
            Text(
              _datesError!,
              key: const ValueKey('period-dates-error'),
              style: const TextStyle(fontSize: 13, color: StatusColors.red600),
            ),
          ],
          if (_showTarget) ...[
            const SizedBox(height: 16),
            Text(l10n.seasonsPeriodTargetLabel, style: labelStyle),
            const SizedBox(height: 6),
            TextField(
              key: const ValueKey('period-target'),
              controller: _target,
              enabled: !_busy,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              decoration: InputDecoration(
                helperText: l10n.seasonsPeriodTargetHint,
                errorText: targetError,
              ),
            ),
          ],
          const SizedBox(height: 16),
          PrimaryButton(
            key: const ValueKey('period-save'),
            label: _isNew ? l10n.seasonsAdd : l10n.seasonsSave,
            expand: true,
            loading: _busy,
            onPressed: _busy ? null : _submit,
          ),
          TextButton(
            onPressed: _busy ? null : () => Navigator.of(context).pop(false),
            child: Text(l10n.seasonsCancel),
          ),
        ],
      ),
    );
  }
}
