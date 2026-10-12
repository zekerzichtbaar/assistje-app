import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/report_models.dart';
import '../../data/report_repository.dart';
import 'report_ui.dart';

/// Hoogstens zoveel beurten (API).
const int maxFlagShifts = 10;

/// De grensrechter indelen (`FlagDutySheet.tsx`): een rij per beurt, elk
/// vanaf een eigen minuut; de eerste begint altijd bij de aftrap. Opslaan
/// vervangt alle beurten. Sluit met `true` als het opgeslagen is.
Future<bool?> showFlagDutySheet(
  BuildContext context, {
  required FlagDutyEdit flag,
  required Future<Object?> Function(List<FlagShiftInput> shifts) onSave,
}) => showAppSheet<bool>(
  context: context,
  title: AppLocalizations.of(context).reportFlagAssign,
  scrollable: true,
  builder: (context) => FlagDutyForm(flag: flag, onSave: onSave),
);

/// Een beurt in bewerking: wie (pool-sleutel, of `null`) en vanaf wanneer.
class _Draft {
  _Draft(this.key, int minute)
    : minute = TextEditingController(text: '$minute');

  String? key;
  final TextEditingController minute;
}

class FlagDutyForm extends StatefulWidget {
  const FlagDutyForm({super.key, required this.flag, required this.onSave});

  final FlagDutyEdit flag;
  final Future<Object?> Function(List<FlagShiftInput> shifts) onSave;

  @override
  State<FlagDutyForm> createState() => _FlagDutyFormState();
}

class _FlagDutyFormState extends State<FlagDutyForm> {
  late final List<_Draft> _shifts = [
    for (final shift in widget.flag.shifts)
      _Draft(
        widget.flag.candidate(shift.key) == null ? null : shift.key,
        shift.fromMinute,
      ),
  ];
  bool _busy = false;
  Object? _error;

  /// Welke beurt (index in [_shifts]) bij `shifts.N` van het verzoek hoort.
  List<int> _sent = const [];

  int get _maxMinute => widget.flag.matchMinutes - 1;

  @override
  void dispose() {
    for (final shift in _shifts) {
      shift.minute.dispose();
    }
    super.dispose();
  }

  int _minuteOf(int index) {
    if (index == 0) return 0;
    final parsed = parseReportNumber(_shifts[index].minute.text);
    if (parsed == null) return 1;
    return parsed.clamp(1, _maxMinute < 1 ? 1 : _maxMinute);
  }

  /// Een nieuwe beurt halverwege wat er nog over is, afgerond op vijf.
  void _add() {
    final last = _shifts.isEmpty ? 0 : _minuteOf(_shifts.length - 1);
    final halfway = (last + widget.flag.matchMinutes) / 2;
    final rounded = ((halfway / 5).round() * 5).clamp(last + 1, _maxMinute);
    setState(() => _shifts.add(_Draft(null, _shifts.isEmpty ? 0 : rounded)));
  }

  void _remove(int index) {
    late final _Draft removed;
    setState(() {
      removed = _shifts.removeAt(index);
      _error = null;
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => removed.minute.dispose(),
    );
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    // Alleen beurten met een naam: een half ingevulde rij is nog geen
    // toewijzing.
    final sent = <int>[];
    final shifts = <FlagShiftInput>[];
    for (var i = 0; i < _shifts.length; i++) {
      final candidate = widget.flag.candidate(_shifts[i].key);
      if (candidate == null) continue;
      sent.add(i);
      shifts.add((
        playerId: candidate.playerId,
        userId: candidate.userId,
        fromMinute: _minuteOf(i),
      ));
    }
    setState(() {
      _busy = true;
      _error = null;
      _sent = sent;
    });
    final error = await widget.onSave(shifts);
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

  /// De 422-melding voor beurt [index] (op `player_id`, `user_id` of
  /// `from_minute`).
  String? _rowError(int index) {
    final n = _sent.indexOf(index);
    if (n < 0) return null;
    for (final field in ['player_id', 'user_id', 'from_minute']) {
      final message = reportFieldError(_error, 'shifts.$n.$field');
      if (message != null) return message;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final error = _error;
    final rowErrors = [for (var i = 0; i < _shifts.length; i++) _rowError(i)];
    final canAdd =
        _shifts.length < maxFlagShifts &&
        (_shifts.isEmpty || _shifts.last.key != null);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null && rowErrors.every((e) => e == null))
          ReportFormError(
            reportFieldError(error, 'shifts') ?? reportErrorText(l10n, error),
            key: const ValueKey('report-flag-error'),
          ),
        if (_shifts.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              l10n.reportFlagNone,
              style: TextStyle(fontSize: 14, color: t.muted),
            ),
          ),
        for (var i = 0; i < _shifts.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _ShiftCard(
              key: ObjectKey(_shifts[i]),
              index: i,
              draft: _shifts[i],
              pool: [
                for (final c in widget.flag.pool)
                  if (c.key == _shifts[i].key ||
                      !_shifts.any((s) => s != _shifts[i] && s.key == c.key))
                    c,
              ],
              error: rowErrors[i],
              onPerson: (key) => setState(() => _shifts[i].key = key),
              onRemove: i == 0 ? null : () => _remove(i),
            ),
          ),
        if (canAdd)
          SecondaryButton(
            key: const ValueKey('report-flag-add'),
            label: _shifts.isEmpty
                ? l10n.reportFlagAdd
                : l10n.reportFlagAddSwitch,
            icon: const Icon(PhosphorIconsBold.plus, size: 16),
            expand: true,
            onPressed: _busy ? null : _add,
          ),
        const SizedBox(height: 12),
        PrimaryButton(
          key: const ValueKey('report-flag-save'),
          label: l10n.reportSave,
          loading: _busy,
          expand: true,
          onPressed: _busy ? null : _save,
        ),
      ],
    );
  }
}

class _ShiftCard extends StatelessWidget {
  const _ShiftCard({
    super.key,
    required this.index,
    required this.draft,
    required this.pool,
    required this.error,
    required this.onPerson,
    required this.onRemove,
  });

  final int index;
  final _Draft draft;
  final List<FlagCandidate> pool;
  final String? error;
  final ValueChanged<String?> onPerson;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final first = index == 0;

    final person = DropdownButtonFormField<String>(
      key: ValueKey('report-flag-person-$index'),
      initialValue: pool.any((c) => c.key == draft.key) ? draft.key : null,
      isExpanded: true,
      hint: Text(l10n.reportFlagChoose),
      decoration: InputDecoration(
        labelText: first ? l10n.reportFlagPerson : l10n.reportFlagBy,
        errorText: error,
        errorMaxLines: 3,
      ),
      items: [
        for (final c in pool)
          DropdownMenuItem(
            value: c.key,
            child: Text(
              c.guest
                  ? l10n.reportFlagGuest(c.name)
                  : c.staff
                  ? l10n.reportFlagStaff(c.name)
                  : c.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      onChanged: onPerson,
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: t.raised,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: ReportLabel(
                  first
                      ? l10n.reportFlagFromKickoff
                      : l10n.reportFlagSwitch(index),
                ),
              ),
              if (onRemove != null)
                IconButton(
                  key: ValueKey('report-flag-remove-$index'),
                  tooltip: l10n.reportFlagRemove,
                  visualDensity: VisualDensity.compact,
                  icon: Icon(PhosphorIconsBold.x, size: 16, color: t.muted),
                  onPressed: onRemove,
                ),
            ],
          ),
          const SizedBox(height: 6),
          if (first)
            person
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 96,
                  child: TextField(
                    key: ValueKey('report-flag-minute-$index'),
                    controller: draft.minute,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    decoration: InputDecoration(
                      labelText: l10n.reportFlagFromMinute,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: person),
              ],
            ),
        ],
      ),
    );
  }
}
