import 'package:flutter/material.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import 'report_ui.dart';

/// De cijfers van één speler invullen: de hoofdcijfers en daaronder de
/// tellingen per groep, met de kolommen uit het verslag (`stat_columns`).
/// Sluit met `true` als het opgeslagen is.
Future<bool?> showPlayerStatsSheet(
  BuildContext context, {
  required String playerName,
  required List<String> columns,
  required Map<String, int> values,
  required Future<Object?> Function(Map<String, int> values) onSave,
}) => showAppSheet<bool>(
  context: context,
  title: playerName,
  scrollable: true,
  builder: (context) =>
      PlayerStatsForm(columns: columns, values: values, onSave: onSave),
);

class PlayerStatsForm extends StatefulWidget {
  const PlayerStatsForm({
    super.key,
    required this.columns,
    required this.values,
    required this.onSave,
  });

  final List<String> columns;
  final Map<String, int> values;
  final Future<Object?> Function(Map<String, int> values) onSave;

  @override
  State<PlayerStatsForm> createState() => _PlayerStatsFormState();
}

class _PlayerStatsFormState extends State<PlayerStatsForm> {
  late final Map<String, TextEditingController> _fields = {
    for (final column in widget.columns)
      column: TextEditingController(
        text: (widget.values[column] ?? 0) == 0
            ? ''
            : '${widget.values[column]}',
      ),
  };
  bool _busy = false;
  Object? _error;

  @override
  void dispose() {
    for (final field in _fields.values) {
      field.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _error = null;
    });
    final values = {
      for (final MapEntry(:key, :value) in _fields.entries)
        key: parseReportNumber(value.text) ?? 0,
    };
    final error = await widget.onSave(values);
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

  /// De 422-melding voor [column] (`stats.0.<kolom>`).
  String? _fieldError(String column) =>
      reportFieldError(_error, 'stats.0.$column');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final error = _error;
    final groups = groupStatColumns(widget.columns);
    final fieldErrors =
        error != null &&
        widget.columns.any((column) => _fieldError(column) != null);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null && !fieldErrors)
          ReportFormError(
            reportErrorText(l10n, error),
            key: const ValueKey('report-stats-error'),
          ),
        for (final MapEntry(key: group, value: columns) in groups.entries) ...[
          ReportLabel(statGroupLabel(l10n, group)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              for (final column in columns)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ReportNumberField(
                      key: ValueKey('report-stat-$column'),
                      controller: _fields[column]!,
                      digits: 3,
                      width: 72,
                      fontSize: 16,
                      semanticLabel: statLabel(l10n, column),
                      errorText: _fieldError(column),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      statLabel(l10n, column),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 16),
        ],
        PrimaryButton(
          key: const ValueKey('report-stats-save'),
          label: l10n.reportSave,
          loading: _busy,
          expand: true,
          onPressed: _busy ? null : _save,
        ),
      ],
    );
  }
}
