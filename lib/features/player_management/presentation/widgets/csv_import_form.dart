import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/csv_file_picker.dart';
import '../../data/models/player_import_result.dart';
import 'pm_ui.dart';

/// Kiest een CSV (of `null`).
typedef PickCsv = Future<CsvFile?> Function();

/// Importeert een CSV; geeft de samenvatting of de fout terug.
typedef ImportCsv =
    Future<({PlayerImportResult? result, Object? error})> Function(
      CsvFile file, {
      required bool sendInvites,
    });

/// Het voorbeeld uit de PWA (`ImportCsvForm.tsx`).
const _csvExample =
    'naam,email,positie,rugnummer,geboortedatum\n'
    'Bram Visser,bram@example.nl,ST,9,1995-06-15\n'
    'Joris Peters,,CM,8,1998-11-02\n'
    'Test Speler,test@example.nl,GK,1,';

/// Spelers uit een CSV: het CSV-tabblad van "Teamleden toevoegen"
/// (`ImportCsvForm.tsx`). Kies een bestand, eventueel uitnodigingen
/// versturen, importeren; daarna de samenvatting (aangemaakt, overgeslagen,
/// per rij de fout).
class CsvImportForm extends StatefulWidget {
  const CsvImportForm({
    super.key,
    required this.positions,
    required this.pickCsv,
    required this.importCsv,
    required this.onBusyChanged,
  });

  /// De positiecodes van de sport, voor de uitleg.
  final Map<String, String> positions;
  final PickCsv pickCsv;
  final ImportCsv importCsv;
  final ValueChanged<bool> onBusyChanged;

  @override
  State<CsvImportForm> createState() => _CsvImportFormState();
}

class _CsvImportFormState extends State<CsvImportForm> {
  CsvFile? _file;
  bool _sendInvites = false;
  bool _helpOpen = false;
  bool _busy = false;
  String? _error;
  PlayerImportResult? _result;

  void _setBusy(bool busy) {
    setState(() => _busy = busy);
    widget.onBusyChanged(busy);
  }

  Future<void> _pick() async {
    if (_busy) return;
    final file = await widget.pickCsv();
    if (!mounted || file == null) return;
    setState(() {
      _file = file;
      _error = null;
    });
  }

  Future<void> _submit() async {
    final file = _file;
    if (_busy || file == null) return;
    _setBusy(true);
    setState(() => _error = null);
    final outcome = await widget.importCsv(file, sendInvites: _sendInvites);
    if (!mounted) return;
    _setBusy(false);
    final l10n = AppLocalizations.of(context);
    setState(() {
      if (outcome.result != null) {
        _result = outcome.result;
        _file = null;
      } else {
        _error =
            pmFieldError(outcome.error, 'file') ??
            pmErrorText(l10n, outcome.error);
      }
    });
    if (outcome.result != null) {
      await Haptics.success();
    } else {
      await Haptics.error();
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;
    return result == null ? _form(context) : _summary(context, result);
  }

  Widget _form(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final file = _file;
    return Column(
      key: const ValueKey('pm-csv-form'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.pmCsvIntro, style: TextStyle(fontSize: 14, color: t.muted)),
        const SizedBox(height: 16),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              _error!,
              key: const ValueKey('pm-csv-error'),
              style: const TextStyle(fontSize: 14, color: StatusColors.red600),
            ),
          ),
        _PickButton(
          label: file?.name ?? l10n.pmCsvPick,
          onTap: _busy ? null : _pick,
        ),
        const SizedBox(height: 8),
        CheckboxListTile(
          key: const ValueKey('pm-csv-invites'),
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: _sendInvites,
          onChanged: _busy
              ? null
              : (v) => setState(() => _sendInvites = v ?? false),
          title: Text(
            l10n.pmCsvSendInvites,
            style: TextStyle(fontSize: 14, color: t.inkSoft),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            key: const ValueKey('pm-csv-help-toggle'),
            onPressed: () => setState(() => _helpOpen = !_helpOpen),
            icon: PhosphorIcon(
              _helpOpen
                  ? PhosphorIconsRegular.caretUp
                  : PhosphorIconsRegular.caretDown,
              size: 14,
              color: t.inkSoft,
            ),
            label: Text(
              l10n.pmCsvHelpToggle,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: t.inkSoft,
              ),
            ),
          ),
        ),
        if (_helpOpen) _Help(positions: widget.positions),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('pm-csv-submit'),
          label: l10n.pmCsvSubmit,
          expand: true,
          loading: _busy,
          onPressed: file == null || _busy ? null : _submit,
        ),
        const SizedBox(height: 4),
        TextButton(
          key: const ValueKey('pm-csv-cancel'),
          onPressed: _busy ? null : () => Navigator.of(context).pop(),
          child: Text(l10n.pmCancel, style: TextStyle(color: t.muted)),
        ),
      ],
    );
  }

  Widget _summary(BuildContext context, PlayerImportResult result) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return Column(
      key: const ValueKey('pm-csv-result'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.pmCsvResultTitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: t.ink,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.pmCsvResultCreated(result.created),
          key: const ValueKey('pm-csv-created'),
          style: TextStyle(fontSize: 14, color: t.inkSoft),
        ),
        if (result.skipped > 0)
          Text(
            l10n.pmCsvResultSkipped(result.skipped),
            key: const ValueKey('pm-csv-skipped'),
            style: TextStyle(fontSize: 14, color: t.inkSoft),
          ),
        if (result.errors.isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: t.raised,
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.pmCsvResultErrorsTitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: t.ink,
                  ),
                ),
                const SizedBox(height: 4),
                for (final (i, error) in result.errors.indexed)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      error,
                      key: ValueKey('pm-csv-row-error-$i'),
                      style: TextStyle(fontSize: 12, color: t.inkSoft),
                    ),
                  ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('pm-csv-done'),
          label: l10n.pmCsvDone,
          expand: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
        const SizedBox(height: 4),
        TextButton(
          key: const ValueKey('pm-csv-again'),
          onPressed: () => setState(() {
            _result = null;
            _error = null;
          }),
          child: Text(l10n.pmCsvAnother, style: TextStyle(color: t.muted)),
        ),
      ],
    );
  }
}

class _PickButton extends StatelessWidget {
  const _PickButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final radius = BorderRadius.circular(AssistjeTokens.radiusXl);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: const ValueKey('pm-csv-pick'),
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: t.line, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PhosphorIcon(
                PhosphorIconsRegular.uploadSimple,
                size: 20,
                color: t.inkSoft,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: t.inkSoft),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// "Hoe maak ik een geldige CSV?" (uitklapbaar, PWA-tekst).
class _Help extends StatelessWidget {
  const _Help({required this.positions});

  final Map<String, String> positions;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final body = TextStyle(fontSize: 12, color: t.inkSoft);
    final mono = body.copyWith(fontFamily: 'monospace', height: 1.4);

    Widget block(String title, Widget child) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: t.ink,
            ),
          ),
          const SizedBox(height: 2),
          child,
        ],
      ),
    );

    return Container(
      key: const ValueKey('pm-csv-help'),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      decoration: BoxDecoration(
        color: t.raised,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          block(
            l10n.pmCsvHelpColumnsTitle,
            Text(l10n.pmCsvHelpColumns, style: body),
          ),
          if (positions.isNotEmpty)
            block(
              l10n.pmCsvHelpPositionsTitle,
              Text(positions.keys.join(', '), style: mono),
            ),
          block(l10n.pmCsvHelpDateTitle, Text(l10n.pmCsvHelpDate, style: body)),
          block(
            l10n.pmCsvHelpSeparatorTitle,
            Text(l10n.pmCsvHelpSeparator, style: body),
          ),
          block(
            l10n.pmCsvHelpExampleTitle,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: t.surface,
                borderRadius: BorderRadius.circular(6),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(_csvExample, style: mono.copyWith(fontSize: 11)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              l10n.pmCsvHelpTip,
              style: TextStyle(fontSize: 12, color: t.muted),
            ),
          ),
        ],
      ),
    );
  }
}
