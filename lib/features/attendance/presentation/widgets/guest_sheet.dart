import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../event/application/event_detail_controller.dart';
import '../../application/attendance_controller.dart';
import '../../data/models/attendance_models.dart';
import 'attendance_ui.dart';

/// "Gast toevoegen" (`GuestModal.tsx`): kies een bestaande gast van het team
/// of maak een nieuwe aan (naam, rugnummer, positie uit het sportprofiel).
/// Geeft `true` terug als er een gast is toegevoegd.
Future<bool?> showGuestSheet(
  BuildContext context, {
  required EventKey eventKey,
  required Map<String, String> positions,
  required Future<Object?> Function(int playerId) onAddExisting,
  required Future<Object?> Function(NewGuest guest) onCreate,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: l10n.attendanceAddGuest,
    scrollable: true,
    builder: (context) => _GuestForm(
      eventKey: eventKey,
      positions: positions,
      onAddExisting: onAddExisting,
      onCreate: onCreate,
    ),
  );
}

class _GuestForm extends ConsumerStatefulWidget {
  const _GuestForm({
    required this.eventKey,
    required this.positions,
    required this.onAddExisting,
    required this.onCreate,
  });

  final EventKey eventKey;
  final Map<String, String> positions;
  final Future<Object?> Function(int playerId) onAddExisting;
  final Future<Object?> Function(NewGuest guest) onCreate;

  @override
  ConsumerState<_GuestForm> createState() => _GuestFormState();
}

class _GuestFormState extends ConsumerState<_GuestForm> {
  final _name = TextEditingController();
  final _shirt = TextEditingController();
  String? _position;
  bool _busy = false;
  Map<String, String> _fieldErrors = const {};
  String? _error;

  @override
  void initState() {
    super.initState();
    _name.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _name.dispose();
    _shirt.dispose();
    super.dispose();
  }

  Future<void> _run(Future<Object?> Function() action) async {
    setState(() {
      _busy = true;
      _error = null;
      _fieldErrors = const {};
    });
    final error = await action();
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busy = false;
      if (error is ValidationException) {
        _fieldErrors = {
          for (final field in const [
            'name',
            'shirt_number',
            'position',
            'existing_player_id',
          ])
            field: ?error.fieldError(field),
        };
      }
      if (_fieldErrors.isEmpty) _error = attendanceErrorText(l10n, error);
    });
  }

  void _create() {
    final name = _name.text.trim();
    if (name.isEmpty || _busy) return;
    _run(
      () => widget.onCreate(
        NewGuest(
          name: name,
          shirtNumber: int.tryParse(_shirt.text.trim()),
          position: _position,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final options = ref.watch(guestOptionsProvider(widget.eventKey));

    Widget label(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: t.inkSoft,
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              _error!,
              key: const ValueKey('guest-error'),
              style: const TextStyle(fontSize: 14, color: StatusColors.red600),
            ),
          ),
        label(l10n.attendanceExistingGuests),
        options.when(
          data: (list) => list.isEmpty
              ? Text(
                  l10n.attendanceExistingGuestsEmpty,
                  key: const ValueKey('guest-options-empty'),
                  style: TextStyle(fontSize: 13, color: t.muted),
                )
              : Column(
                  key: const ValueKey('guest-options'),
                  children: [
                    for (final option in list)
                      _OptionTile(
                        option: option,
                        enabled: !_busy,
                        onTap: () =>
                            _run(() => widget.onAddExisting(option.id)),
                      ),
                  ],
                ),
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: SkeletonList(count: 2),
          ),
          error: (error, _) => Text(
            l10n.attendanceOptionsError,
            key: const ValueKey('guest-options-error'),
            style: TextStyle(fontSize: 13, color: t.muted),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          l10n.attendanceNewGuest.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            color: t.muted,
          ),
        ),
        const SizedBox(height: 8),
        label(l10n.attendanceGuestName),
        TextField(
          key: const ValueKey('guest-name'),
          controller: _name,
          maxLength: 120,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          enabled: !_busy,
          decoration: InputDecoration(
            counterText: '',
            errorText: _fieldErrors['name'],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  label(l10n.attendanceGuestShirt),
                  TextField(
                    key: const ValueKey('guest-shirt'),
                    controller: _shirt,
                    enabled: !_busy,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    decoration: InputDecoration(
                      hintText: l10n.attendanceOptional,
                      errorText: _fieldErrors['shirt_number'],
                    ),
                  ),
                ],
              ),
            ),
            if (widget.positions.isNotEmpty) ...[
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    label(l10n.attendanceGuestPosition),
                    DropdownButtonFormField<String?>(
                      key: const ValueKey('guest-position'),
                      initialValue: _position,
                      isExpanded: true,
                      decoration: InputDecoration(
                        errorText: _fieldErrors['position'],
                      ),
                      items: [
                        DropdownMenuItem<String?>(
                          child: Text(l10n.attendanceGuestPositionNone),
                        ),
                        for (final entry in widget.positions.entries)
                          DropdownMenuItem<String?>(
                            value: entry.key,
                            child: Text(
                              '${entry.key} · ${entry.value}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                      onChanged: _busy
                          ? null
                          : (value) => setState(() => _position = value),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 20),
        PrimaryButton(
          key: const ValueKey('guest-submit'),
          label: l10n.attendanceAdd,
          expand: true,
          loading: _busy,
          onPressed: _name.text.trim().isEmpty || _busy ? null : _create,
        ),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.option,
    required this.enabled,
    required this.onTap,
  });

  final GuestOption option;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final position = option.position?.trim() ?? '';
    final details = [
      if (option.shirtNumber != null) '#${option.shirtNumber}',
      if (position.isNotEmpty) position,
    ].join(' · ');
    return InkWell(
      key: ValueKey('guest-option-${option.id}'),
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            AppAvatar(name: option.name, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: t.ink,
                    ),
                  ),
                  if (details.isNotEmpty)
                    Text(
                      details,
                      style: TextStyle(fontSize: 12, color: t.muted),
                    ),
                ],
              ),
            ),
            PhosphorIcon(
              PhosphorIconsDuotone.plusCircle,
              size: 22,
              color: t.primary,
            ),
          ],
        ),
      ),
    );
  }
}
