import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/seasons_models.dart';
import 'seasons_ui.dart';

/// Max. lengte van het seizoenslabel (zoals de API).
const int seasonLabelMaxLength = 16;

/// Opent "Seizoen bewerken": naam en grenzen van het lopende seizoen
/// (`SeasonForm` in SeasonTab.tsx). [onSubmit] geeft de fout terug of
/// `null`; de sheet sluit met `true` na een gelukte aanroep.
Future<bool?> showSeasonFormSheet(
  BuildContext context, {
  required Season season,
  required Future<Object?> Function(SeasonUpdate update) onSubmit,
}) => showAppSheet<bool>(
  context: context,
  title: AppLocalizations.of(context).seasonsSeasonFormTitle,
  scrollable: true,
  builder: (context) => _SeasonForm(season: season, onSubmit: onSubmit),
);

class _SeasonForm extends StatefulWidget {
  const _SeasonForm({required this.season, required this.onSubmit});

  final Season season;
  final Future<Object?> Function(SeasonUpdate update) onSubmit;

  @override
  State<_SeasonForm> createState() => _SeasonFormState();
}

class _SeasonFormState extends State<_SeasonForm> {
  late final TextEditingController _label = TextEditingController(
    text: widget.season.label,
  );
  late DateTime? _from = parseSeasonDate(widget.season.startsOn);
  late DateTime? _to = parseSeasonDate(widget.season.endsOn);
  String? _labelError;
  String? _datesError;
  Object? _error;
  bool _busy = false;

  @override
  void dispose() {
    _label.dispose();
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
    final label = _label.text.trim();
    final from = _from;
    final to = _to;
    final labelError = label.isEmpty ? l10n.seasonsLabelRequired : null;
    final datesError = from == null || to == null
        ? l10n.seasonsDatesRequired
        : (!to.isAfter(from) ? l10n.seasonsEndBeforeStart : null);
    if (labelError != null || datesError != null) {
      unawaited(Haptics.error());
      setState(() {
        _labelError = labelError;
        _datesError = datesError;
      });
      return;
    }
    setState(() {
      _busy = true;
      _labelError = null;
      _datesError = null;
      _error = null;
    });
    final error = await widget.onSubmit(
      SeasonUpdate(
        label: label,
        startsOn: isoSeasonDate(from!),
        endsOn: isoSeasonDate(to!),
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
      seasonsFieldError(error, ['label', 'starts_on', 'ends_on']) != null ||
      isSeasonsFormLevel(error);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final labelError = _labelError ?? seasonsFieldError(_error, ['label']);
    final fromError = seasonsFieldError(_error, ['starts_on']);
    final toError = seasonsFieldError(_error, ['ends_on']);
    final formError = isSeasonsFormLevel(_error)
        ? seasonsErrorText(l10n, _error)
        : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (formError != null)
            SeasonsFormError(
              formError,
              key: const ValueKey('season-form-error'),
            ),
          Text(
            l10n.seasonsLabel,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: t.inkSoft,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            key: const ValueKey('season-label'),
            controller: _label,
            enabled: !_busy,
            inputFormatters: [
              LengthLimitingTextInputFormatter(seasonLabelMaxLength),
            ],
            decoration: InputDecoration(
              hintText: l10n.seasonsLabelHint,
              errorText: labelError,
            ),
          ),
          const SizedBox(height: 16),
          SeasonDateField(
            key: const ValueKey('season-from'),
            label: l10n.seasonsStartsOn,
            value: _from,
            placeholder: l10n.seasonsPickDate,
            error: fromError,
            onTap: _busy ? null : () => _pick(from: true),
          ),
          const SizedBox(height: 12),
          SeasonDateField(
            key: const ValueKey('season-to'),
            label: l10n.seasonsEndsOn,
            value: _to,
            placeholder: l10n.seasonsPickDate,
            error: toError,
            onTap: _busy ? null : () => _pick(from: false),
          ),
          if (_datesError != null) ...[
            const SizedBox(height: 6),
            Text(
              _datesError!,
              key: const ValueKey('season-dates-error'),
              style: const TextStyle(fontSize: 13, color: StatusColors.red600),
            ),
          ],
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: t.raised,
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
            ),
            child: Text(
              l10n.seasonsSeasonFormNote,
              style: TextStyle(fontSize: 13, color: t.inkSoft),
            ),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            key: const ValueKey('season-save'),
            label: l10n.seasonsSave,
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
