import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/report_models.dart';
import '../../data/report_repository.dart';
import 'report_ui.dart';

/// De stand aanpassen: doelpunten of setstanden, afhankelijk van het
/// scoremodel uit het verslag. Sluit met `true` als het opgeslagen is.
Future<bool?> showScoreSheet(
  BuildContext context, {
  required MatchReport report,
  required Future<Object?> Function(int? home, int? away) onSaveScore,
  required Future<Object?> Function(List<SetScore> sets) onSaveSets,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: report.usesSets ? l10n.reportEditSets : l10n.reportEditScore,
    scrollable: true,
    builder: (context) => report.usesSets
        ? SetsForm(report: report, onSave: onSaveSets)
        : ScoreForm(report: report, onSave: onSaveScore),
  );
}

/// Thuis – uit, twee vakjes. Leeg = uitslag wissen.
class ScoreForm extends StatefulWidget {
  const ScoreForm({super.key, required this.report, required this.onSave});

  final MatchReport report;
  final Future<Object?> Function(int? home, int? away) onSave;

  @override
  State<ScoreForm> createState() => _ScoreFormState();
}

class _ScoreFormState extends State<ScoreForm> {
  late final _home = TextEditingController(
    text: widget.report.homeScore?.toString() ?? '',
  );
  late final _away = TextEditingController(
    text: widget.report.awayScore?.toString() ?? '',
  );
  bool _busy = false;
  Object? _error;

  @override
  void dispose() {
    _home.dispose();
    _away.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await widget.onSave(
      parseReportNumber(_home.text),
      parseReportNumber(_away.text),
    );
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      _busy = false;
      _error = error is ValidationException ? error : null;
    });
    reportSheetFailure(context, error);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final event = widget.report.event;
    final error = _error;
    final team = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: t.ink,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null &&
            reportFieldError(error, 'home_score') == null &&
            reportFieldError(error, 'away_score') == null)
          ReportFormError(
            reportErrorText(l10n, error),
            key: const ValueKey('report-score-error'),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  event.homeTeam ?? l10n.reportHome,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: team,
                ),
              ),
            ),
            const SizedBox(width: 12),
            ReportNumberField(
              key: const ValueKey('report-score-home'),
              controller: _home,
              fontSize: 22,
              semanticLabel: event.homeTeam ?? l10n.reportHome,
              errorText: reportFieldError(error, 'home_score'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
              child: Text(
                '-',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: t.muted,
                ),
              ),
            ),
            ReportNumberField(
              key: const ValueKey('report-score-away'),
              controller: _away,
              fontSize: 22,
              textInputAction: TextInputAction.done,
              semanticLabel: event.awayTeam ?? l10n.reportAway,
              errorText: reportFieldError(error, 'away_score'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  event.awayTeam ?? l10n.reportAway,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: team,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        PrimaryButton(
          key: const ValueKey('report-score-save'),
          label: l10n.reportSave,
          loading: _busy,
          expand: true,
          onPressed: _busy ? null : _save,
        ),
      ],
    );
  }
}

/// Een rij per set (tot `max_sets`); lege of `0-0`-sets tellen niet mee.
class SetsForm extends StatefulWidget {
  const SetsForm({super.key, required this.report, required this.onSave});

  final MatchReport report;
  final Future<Object?> Function(List<SetScore> sets) onSave;

  @override
  State<SetsForm> createState() => _SetsFormState();
}

class _SetsFormState extends State<SetsForm> {
  late final List<(TextEditingController, TextEditingController)> _rows;
  bool _busy = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    final report = widget.report;
    final count = math.max(
      report.maxSets ?? 5,
      report.sets.fold<int>(0, (n, s) => math.max(n, s.setNumber)),
    );
    _rows = [for (var i = 1; i <= count; i++) _controllers(report.sets, i)];
    for (final (home, away) in _rows) {
      home.addListener(_changed);
      away.addListener(_changed);
    }
  }

  static (TextEditingController, TextEditingController) _controllers(
    List<ReportSet> sets,
    int number,
  ) {
    for (final set in sets) {
      if (set.setNumber == number) {
        return (
          TextEditingController(text: '${set.homePoints}'),
          TextEditingController(text: '${set.awayPoints}'),
        );
      }
    }
    return (TextEditingController(), TextEditingController());
  }

  void _changed() => setState(() {});

  @override
  void dispose() {
    for (final (home, away) in _rows) {
      home.dispose();
      away.dispose();
    }
    super.dispose();
  }

  int get _filled =>
      _rows.where((r) => r.$1.text.isNotEmpty || r.$2.text.isNotEmpty).length;

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _error = null;
    });
    final sets = [
      for (final (home, away) in _rows)
        (
          home: parseReportNumber(home.text) ?? 0,
          away: parseReportNumber(away.text) ?? 0,
        ),
    ];
    final error = await widget.onSave(sets);
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      _busy = false;
      _error = error is ValidationException ? error : null;
    });
    reportSheetFailure(context, error);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final event = widget.report.event;
    final error = _error;
    final muted = TextStyle(fontSize: 12, color: t.muted);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null)
          ReportFormError(
            reportFieldError(error, 'sets') ?? reportErrorText(l10n, error),
            key: const ValueKey('report-sets-error'),
          ),
        Row(
          children: [
            const SizedBox(width: 64),
            SizedBox(
              width: 64,
              child: Text(
                event.homeTeam ?? l10n.reportHome,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: muted,
              ),
            ),
            const SizedBox(width: 24),
            SizedBox(
              width: 64,
              child: Text(
                event.awayTeam ?? l10n.reportAway,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: muted,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final (i, (home, away)) in _rows.indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 64,
                  child: Text(
                    l10n.reportSetLabel(i + 1),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: t.muted,
                    ),
                  ),
                ),
                ReportNumberField(
                  key: ValueKey('report-set-${i + 1}-home'),
                  controller: home,
                  fontSize: 16,
                  semanticLabel:
                      '${l10n.reportSetLabel(i + 1)} ${event.homeTeam ?? l10n.reportHome}',
                ),
                SizedBox(
                  width: 24,
                  child: Text(
                    '-',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: t.muted),
                  ),
                ),
                ReportNumberField(
                  key: ValueKey('report-set-${i + 1}-away'),
                  controller: away,
                  fontSize: 16,
                  semanticLabel:
                      '${l10n.reportSetLabel(i + 1)} ${event.awayTeam ?? l10n.reportAway}',
                ),
              ],
            ),
          ),
        Text(
          l10n.reportSetsFilled(_filled),
          key: const ValueKey('report-sets-filled'),
          style: muted,
        ),
        const SizedBox(height: 20),
        PrimaryButton(
          key: const ValueKey('report-sets-save'),
          label: l10n.reportSave,
          loading: _busy,
          expand: true,
          onPressed: _busy ? null : _save,
        ),
      ],
    );
  }
}
