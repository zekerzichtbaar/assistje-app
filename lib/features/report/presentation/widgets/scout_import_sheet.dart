import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/report_controller.dart';
import '../../data/models/report_models.dart';
import '../../data/report_repository.dart';
import 'report_ui.dart';

/// Hoogstens zo groot mag de PDF zijn (API: 10 MB).
const int maxScoutPdfBytes = 10 * 1024 * 1024;

/// Het rapport van de camerasoftware inlezen en laten zien wat erin staat,
/// vóórdat er iets in het blad terechtkomt (`ScoutImportSheet` in
/// `Report.tsx`). Alles is te corrigeren; pas "Overnemen" slaat op.
/// Sluit met `true` als het overgenomen is.
Future<bool?> showScoutImportSheet(
  BuildContext context, {
  required MatchReport report,
  required Future<ScoutFile?> Function() pickPdf,
  required Future<ScoutPreview> Function({ScoutFile? file, String? text})
  onRead,
  required Future<Object?> Function(ScoutImport import) onApply,
}) => showAppSheet<bool>(
  context: context,
  title: AppLocalizations.of(context).reportScoutTitle,
  scrollable: true,
  builder: (context) => ScoutImportForm(
    report: report,
    pickPdf: pickPdf,
    onRead: onRead,
    onApply: onApply,
  ),
);

class ScoutImportForm extends StatefulWidget {
  const ScoutImportForm({
    super.key,
    required this.report,
    required this.pickPdf,
    required this.onRead,
    required this.onApply,
  });

  final MatchReport report;
  final Future<ScoutFile?> Function() pickPdf;
  final Future<ScoutPreview> Function({ScoutFile? file, String? text}) onRead;
  final Future<Object?> Function(ScoutImport import) onApply;

  @override
  State<ScoutImportForm> createState() => _ScoutImportFormState();
}

class _ScoutImportFormState extends State<ScoutImportForm> {
  final _text = TextEditingController();
  ScoutFile? _file;
  bool _busy = false;
  String? _error;

  ScoutPreview? _preview;
  int _teamIndex = 0;

  /// Regel-index → gekoppelde speler (of `null` = overslaan).
  Map<int, int?> _links = const {};
  bool _takeSets = true;

  @override
  void initState() {
    super.initState();
    _text.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    final l10n = AppLocalizations.of(context);
    try {
      final file = await widget.pickPdf();
      if (!mounted || file == null) return;
      if (file.bytes.length > maxScoutPdfBytes) {
        setState(() => _error = l10n.reportScoutPdfTooBig);
        return;
      }
      setState(() {
        _file = file;
        _error = null;
      });
    } on Object {
      if (mounted) setState(() => _error = l10n.reportScoutPdfError);
    }
  }

  Future<void> _read() async {
    final l10n = AppLocalizations.of(context);
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final text = _text.text.trim();
      final preview = await widget.onRead(
        file: _file,
        text: text.isEmpty ? null : _text.text,
      );
      if (!mounted) return;
      setState(() {
        _busy = false;
        _preview = preview;
        _pickTeam(preview.ourTeamIndex ?? 0);
      });
    } on Object catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = error is ValidationException
            ? (error.message ?? l10n.reportScoutReadError)
            : reportErrorText(l10n, error);
      });
      unawaited(Haptics.error());
    }
  }

  void _pickTeam(int index) {
    final teams = _preview?.teams ?? const <ScoutTeam>[];
    _teamIndex = teams.isEmpty ? 0 : index.clamp(0, teams.length - 1);
    final players = teams.isEmpty
        ? const <ScoutRow>[]
        : teams[_teamIndex].players;
    _links = {for (final (i, p) in players.indexed) i: p.playerId};
  }

  Future<void> _apply() async {
    final preview = _preview;
    if (preview == null || preview.teams.isEmpty) return;
    final team = preview.teams[_teamIndex];
    final columns = widget.report.statColumns;
    final stats = <int, Map<String, int>>{};
    for (final (i, row) in team.players.indexed) {
      final playerId = _links[i];
      if (playerId == null) continue;
      stats[playerId] = {for (final c in columns) c: row.stat(c)};
    }
    // De setstanden staan in de volgorde van het rapport: eerst de ploeg die
    // daar bovenaan staat. Zijn wij dat niet, dan moeten thuis en uit om.
    final swap = (_teamIndex == 0) != widget.report.event.weAreHome;
    final sets = _showSets && _takeSets
        ? [
            for (final s in preview.sets)
              (home: swap ? s.away : s.home, away: swap ? s.home : s.away),
          ]
        : const <SetScore>[];

    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await widget.onApply((stats: stats, sets: sets));
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      _busy = false;
      _error = error is ValidationException
          ? reportErrorText(AppLocalizations.of(context), error)
          : null;
    });
    reportSheetFailure(context, error);
  }

  bool get _showSets =>
      widget.report.usesSets && (_preview?.sets.isNotEmpty ?? false);

  @override
  Widget build(BuildContext context) =>
      _preview == null ? _input(context) : _review(context, _preview!);

  Widget _errorText() => _error == null
      ? const SizedBox.shrink()
      : ReportFormError(_error!, key: const ValueKey('report-scout-error'));

  Widget _input(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final file = _file;
    final canRead = !_busy && (file != null || _text.text.trim().isNotEmpty);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.reportScoutIntro,
          style: TextStyle(fontSize: 14, color: t.inkSoft, height: 1.4),
        ),
        const SizedBox(height: 16),
        ReportLabel(l10n.reportScoutPdf),
        const SizedBox(height: 6),
        if (file == null)
          SecondaryButton(
            key: const ValueKey('report-scout-pick'),
            label: l10n.reportScoutPickPdf,
            icon: const Icon(PhosphorIconsBold.filePdf, size: 16),
            expand: true,
            onPressed: _busy ? null : _pick,
          )
        else
          Row(
            children: [
              Icon(PhosphorIconsDuotone.filePdf, color: t.inkSoft),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  file.name,
                  key: const ValueKey('report-scout-file'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: t.ink),
                ),
              ),
              IconButton(
                tooltip: l10n.reportScoutRemovePdf,
                icon: Icon(PhosphorIconsBold.x, size: 16, color: t.muted),
                onPressed: _busy ? null : () => setState(() => _file = null),
              ),
            ],
          ),
        const SizedBox(height: 16),
        ReportLabel(l10n.reportScoutPaste),
        const SizedBox(height: 6),
        TextField(
          key: const ValueKey('report-scout-text'),
          controller: _text,
          minLines: 3,
          maxLines: 6,
          maxLength: 200000,
          decoration: InputDecoration(
            hintText: l10n.reportScoutPasteHint,
            counterText: '',
          ),
        ),
        const SizedBox(height: 12),
        _errorText(),
        PrimaryButton(
          key: const ValueKey('report-scout-read'),
          label: l10n.reportScoutRead,
          loading: _busy,
          expand: true,
          onPressed: canRead ? _read : null,
        ),
      ],
    );
  }

  Widget _review(BuildContext context, ScoutPreview preview) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final team = preview.teams.isEmpty ? null : preview.teams[_teamIndex];
    final rows = team?.players ?? const <ScoutRow>[];
    final linked = _links.values.whereType<int>().length;
    final summaryColumns = headlineStatColumns(widget.report.statColumns);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ReportLabel(l10n.reportScoutWhichTeam),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final (i, team) in preview.teams.indexed)
              ChoiceChip(
                key: ValueKey('report-scout-team-$i'),
                label: Text(
                  team.name.isEmpty
                      ? l10n.reportScoutTeamFallback(i + 1)
                      : team.name,
                ),
                selected: i == _teamIndex,
                onSelected: _busy ? null : (_) => setState(() => _pickTeam(i)),
              ),
          ],
        ),
        if (_showSets) ...[
          const SizedBox(height: 8),
          CheckboxListTile(
            key: const ValueKey('report-scout-sets'),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            value: _takeSets,
            onChanged: _busy
                ? null
                : (value) => setState(() => _takeSets = value ?? false),
            title: Text(
              l10n.reportScoutTakeSets(
                preview.sets.map((s) => '${s.home}-${s.away}').join(' '),
              ),
              style: TextStyle(fontSize: 14, color: t.inkSoft),
            ),
          ),
        ],
        const SizedBox(height: 12),
        for (final (i, row) in rows.indexed)
          _ScoutRowTile(
            key: ValueKey('report-scout-row-$i'),
            index: i,
            row: row,
            roster: preview.roster,
            playerId: _links[i],
            summary: [
              for (final c in summaryColumns)
                '${statLabel(l10n, c)} ${row.stat(c)}',
            ].join(' · '),
            onChanged: _busy
                ? null
                : (id) => setState(() => _links = {..._links, i: id}),
          ),
        const SizedBox(height: 8),
        Text(
          l10n.reportScoutLinked(linked, rows.length),
          key: const ValueKey('report-scout-linked'),
          style: TextStyle(fontSize: 12, color: t.muted),
        ),
        const SizedBox(height: 12),
        _errorText(),
        PrimaryButton(
          key: const ValueKey('report-scout-apply'),
          label: l10n.reportScoutApply,
          loading: _busy,
          expand: true,
          onPressed: linked == 0 || _busy ? null : _apply,
        ),
      ],
    );
  }
}

class _ScoutRowTile extends StatelessWidget {
  const _ScoutRowTile({
    super.key,
    required this.index,
    required this.row,
    required this.roster,
    required this.playerId,
    required this.summary,
    required this.onChanged,
  });

  final int index;
  final ScoutRow row;
  final List<ScoutRosterEntry> roster;
  final int? playerId;
  final String summary;
  final ValueChanged<int?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final linked = playerId != null;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final amberBg = dark ? const Color(0x26F59E0B) : StatusColors.amber50;
    final amberText = dark ? StatusColors.amber400 : StatusColors.amber700;

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        color: linked ? t.raised : amberBg,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SizedBox(
                width: 28,
                child: Text(
                  row.shirtNumber?.toString() ?? '—',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: t.muted,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  row.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: t.ink),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 150,
                child: DropdownButton<int?>(
                  key: ValueKey('report-scout-link-$index'),
                  value: roster.any((r) => r.id == playerId) ? playerId : null,
                  isExpanded: true,
                  isDense: true,
                  underline: const SizedBox.shrink(),
                  style: TextStyle(fontSize: 12, color: t.ink),
                  items: [
                    DropdownMenuItem<int?>(child: Text(l10n.reportScoutSkip)),
                    for (final r in roster)
                      DropdownMenuItem<int?>(
                        value: r.id,
                        child: Text(
                          r.shirtNumber == null
                              ? r.name
                              : '${r.shirtNumber}. ${r.name}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28, top: 2),
            child: Text(
              linked ? summary : l10n.reportScoutUnmatched,
              style: TextStyle(
                fontSize: 12,
                color: linked ? t.muted : amberText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
