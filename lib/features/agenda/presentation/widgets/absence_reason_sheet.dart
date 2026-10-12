import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/agenda_models.dart';

/// Vraagt waarom je er niet bent (`AbsenceReasonSheet` in de PWA): vier
/// snelle redenen als knop, of zelf typen. Geeft de reden terug, of `null`
/// als de sheet weggeveegd is.
Future<String?> showAbsenceReasonSheet(
  BuildContext context, {
  required AttendanceStatus status,
  String? error,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<String>(
    context: context,
    title: status == AttendanceStatus.nonplay
        ? l10n.reasonTitleNonplay
        : l10n.reasonTitleAbsent,
    builder: (context) => _AbsenceReasonForm(error: error),
  );
}

class _AbsenceReasonForm extends StatefulWidget {
  const _AbsenceReasonForm({this.error});

  final String? error;

  @override
  State<_AbsenceReasonForm> createState() => _AbsenceReasonFormState();
}

class _AbsenceReasonFormState extends State<_AbsenceReasonForm> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final value = _controller.text.trim();
    if (value.isEmpty) return;
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final quick = [
      l10n.reasonQuickInjury,
      l10n.reasonQuickWork,
      l10n.reasonQuickSick,
      l10n.reasonQuickVacation,
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.error != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              widget.error!,
              key: const ValueKey('reason-error'),
              style: const TextStyle(fontSize: 14, color: StatusColors.red600),
            ),
          ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final q in quick)
              GestureDetector(
                key: ValueKey('reason-quick-$q'),
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(context).pop(q),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: t.raised,
                    borderRadius: BorderRadius.circular(
                      AssistjeTokens.radiusXl,
                    ),
                  ),
                  child: Text(
                    q,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: t.inkSoft,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          l10n.reasonOwnLabel,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: t.inkSoft,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          key: const ValueKey('reason-input'),
          controller: _controller,
          maxLength: 120,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _submit(),
          decoration: InputDecoration(
            hintText: l10n.reasonOwnHint,
            counterText: '',
          ),
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('reason-submit'),
          label: l10n.reasonSubmit,
          expand: true,
          onPressed: _controller.text.trim().isEmpty ? null : _submit,
        ),
      ],
    );
  }
}
