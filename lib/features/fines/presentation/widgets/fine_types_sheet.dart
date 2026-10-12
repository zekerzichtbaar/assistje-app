import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/fines_controller.dart';
import '../../application/money.dart';
import '../../data/models/fines_models.dart';
import 'fine_type_sheet.dart';
import 'fines_ui.dart';

/// "Boetes beheren" (`SettingsForm` in de PWA): de soorten van dit team in
/// twee groepen. Bovenaan wat de app zelf uitschrijft — bedrag en aan/uit;
/// daaronder de eigen soorten — bedrag, bewerken en weghalen. Aan/uit,
/// toevoegen, bewerken en weghalen gaan meteen; de bedragen samen met
/// "Opslaan" (`PATCH fine-settings`). Sluit met `true` na opslaan.
Future<bool?> showFineTypesSheet(BuildContext context, {required int teamId}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: l10n.finesTypesTitle,
    scrollable: true,
    builder: (context) => FineTypesManager(teamId: teamId),
  );
}

class FineTypesManager extends ConsumerStatefulWidget {
  const FineTypesManager({super.key, required this.teamId});

  final int teamId;

  @override
  ConsumerState<FineTypesManager> createState() => _FineTypesManagerState();
}

class _FineTypesManagerState extends ConsumerState<FineTypesManager> {
  /// Invoervelden per soort-id; nieuw aangemaakt als een soort opduikt.
  final Map<int, TextEditingController> _amounts = {};

  /// Soorten waarvoor nu een verzoek loopt (aan/uit, weghalen).
  final Set<int> _pending = {};
  bool _saving = false;
  bool _tried = false;
  Object? _error;

  FinesController get _controller =>
      ref.read(finesControllerProvider(widget.teamId).notifier);

  @override
  void dispose() {
    for (final controller in _amounts.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController _amountFor(FineType type) => _amounts.putIfAbsent(
    type.id,
    () => TextEditingController(text: centsToInput(type.defaultCents)),
  );

  /// Een eerder ingevuld bedrag weer van de server laten komen.
  void _forget(int typeId) => _amounts.remove(typeId)?.dispose();

  Future<void> _save(List<FineType> types) async {
    setState(() => _tried = true);
    final amounts = <int, int>{};
    for (final type in types) {
      final cents = parseFineTypeCents(_amountFor(type).text);
      if (cents == null) return;
      amounts[type.id] = cents;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    final error = await _controller.updateFineSettings(amounts);
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    if (finesShowForbidden(context, error)) {
      Navigator.of(context).pop(false);
      return;
    }
    setState(() {
      _saving = false;
      _error = error;
    });
  }

  /// Voert een directe actie op soort [typeId] uit; fouten als toast.
  Future<Object?> _act(int typeId, Future<Object?> Function() request) async {
    setState(() => _pending.add(typeId));
    final error = await request();
    if (!mounted) return error;
    setState(() => _pending.remove(typeId));
    if (error != null && !finesShowForbidden(context, error)) {
      showFinesError(
        context,
        AppLocalizations.of(context).finesSaveFailed,
        error,
      );
    }
    return error;
  }

  Future<void> _toggle(FineType type, bool on) async {
    unawaited(Haptics.selection());
    await _act(type.id, () => _controller.updateFineType(type.id, active: on));
  }

  Future<void> _delete(FineType type) async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmFinesAction(
      context,
      message: l10n.finesTypeDeleteConfirm(type.label),
      confirmLabel: l10n.finesDelete,
      destructive: true,
    );
    if (!ok || !mounted) return;
    var archived = false;
    final error = await _act(type.id, () async {
      final result = await _controller.deleteFineType(type.id);
      archived = result.archived;
      return result.error;
    });
    if (error == null && mounted) {
      _forget(type.id);
      showFinesSuccess(
        context,
        archived ? l10n.finesTypeArchived : l10n.finesDeleted,
      );
    }
  }

  Future<void> _edit(FineType type) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final done = await showFineTypeSheet(
      context,
      type: type,
      onSubmit: (label, cents) =>
          _controller.updateFineType(type.id, label: label, amountCents: cents),
    );
    if ((done ?? false) && mounted) {
      setState(() => _forget(type.id));
      showFinesSuccess(context, l10n.finesSaved);
    }
  }

  Future<void> _add() async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final done = await showFineTypeSheet(
      context,
      onSubmit: (label, cents) =>
          _controller.createFineType(label: label, amountCents: cents),
    );
    if ((done ?? false) && mounted) {
      showFinesSuccess(context, l10n.finesTypeAdded);
    }
  }

  /// De 422 van `fine-settings` voor soort [typeId] (`amounts.<id>`).
  String? _serverAmountError(int typeId) =>
      finesFieldError(_error, 'amounts.$typeId') ??
      finesFieldError(_error, 'amounts');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final overview = ref
        .watch(finesControllerProvider(widget.teamId))
        .value
        ?.overview;
    if (overview == null) return const SizedBox.shrink();

    final types = overview.fineTypes;
    final automatic = [
      for (final type in types)
        if (type.trigger != null) type,
    ];
    final manual = [
      for (final type in types)
        if (type.trigger == null && !type.archived) type,
    ];
    final invalid =
        _tried &&
        types.any((type) => parseFineTypeCents(_amountFor(type).text) == null);
    final error = _error;
    // Veldfouten staan bij het bedrag; anders de melding bovenaan.
    final generalError =
        types.any((type) => _serverAmountError(type.id) != null) ? null : error;

    Widget groupTitle(String text) => Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
          color: t.muted,
        ),
      ),
    );

    return Column(
      key: const ValueKey('fine-types-sheet'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (generalError != null)
          FinesFormError(
            finesErrorText(l10n, generalError),
            key: const ValueKey('fine-types-error'),
          ),
        if (invalid)
          FinesFormError(
            l10n.finesTypesAmountsInvalid,
            key: const ValueKey('fine-types-invalid'),
          ),
        if (automatic.isNotEmpty) ...[
          groupTitle(l10n.finesTypesAutomatic),
          Text(
            [
              l10n.finesTypesNoteInjured,
              if (overview.guestsInFines)
                l10n.finesTypesNoteGuestsOn
              else
                l10n.finesTypesNoteGuestsOff,
              if (overview.staffInFines)
                l10n.finesTypesNoteStaffOn
              else
                l10n.finesTypesNoteStaffOff,
            ].join(' '),
            style: TextStyle(fontSize: 12, height: 1.35, color: t.muted),
          ),
          const SizedBox(height: 4),
          for (final type in automatic)
            _TypeRow(
              key: ValueKey('fine-type-${type.id}'),
              type: type,
              amount: _amountFor(type),
              tried: _tried,
              serverError: _serverAmountError(type.id),
              onAmountChanged: () => setState(() {}),
              trailing: Switch.adaptive(
                key: ValueKey('fine-type-toggle-${type.id}'),
                value: !type.archived,
                onChanged: _pending.contains(type.id) || _saving
                    ? null
                    : (on) => _toggle(type, on),
              ),
              trailingLabel: type.archived
                  ? l10n.finesTypeToggleOn(type.label)
                  : l10n.finesTypeToggleOff(type.label),
            ),
        ],
        groupTitle(l10n.finesTypesManual),
        if (manual.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              l10n.finesTypesManualEmpty,
              key: const ValueKey('fine-types-manual-empty'),
              style: TextStyle(fontSize: 14, color: t.muted),
            ),
          ),
        for (final type in manual)
          _TypeRow(
            key: ValueKey('fine-type-${type.id}'),
            type: type,
            amount: _amountFor(type),
            tried: _tried,
            serverError: _serverAmountError(type.id),
            onAmountChanged: () => setState(() {}),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  key: ValueKey('fine-type-edit-${type.id}'),
                  tooltip: l10n.finesTypeEditLabel(type.label),
                  icon: Icon(
                    PhosphorIconsRegular.pencilSimple,
                    size: 18,
                    color: t.inkSoft,
                  ),
                  onPressed: _pending.contains(type.id) || _saving
                      ? null
                      : () => _edit(type),
                ),
                IconButton(
                  key: ValueKey('fine-type-delete-${type.id}'),
                  tooltip: l10n.finesTypeDeleteLabel(type.label),
                  icon: const Icon(
                    PhosphorIconsRegular.trash,
                    size: 18,
                    color: StatusColors.red600,
                  ),
                  onPressed: _pending.contains(type.id) || _saving
                      ? null
                      : () => _delete(type),
                ),
              ],
            ),
          ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            key: const ValueKey('fine-types-add'),
            onPressed: _saving ? null : _add,
            icon: const Icon(PhosphorIconsBold.plus, size: 16),
            label: Text(l10n.finesTypesAdd),
          ),
        ),
        const SizedBox(height: 8),
        PrimaryButton(
          key: const ValueKey('fine-types-save'),
          label: l10n.finesSave,
          expand: true,
          loading: _saving,
          onPressed: _saving || types.isEmpty ? null : () => _save(types),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

/// Eén soort: naam (met wanneer hij automatisch komt), bedrag en acties.
class _TypeRow extends StatelessWidget {
  const _TypeRow({
    super.key,
    required this.type,
    required this.amount,
    required this.tried,
    required this.onAmountChanged,
    required this.trailing,
    this.trailingLabel,
    this.serverError,
  });

  final FineType type;
  final TextEditingController amount;
  final bool tried;
  final VoidCallback onAmountChanged;
  final Widget trailing;
  final String? trailingLabel;
  final String? serverError;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final invalid = tried && parseFineTypeCents(amount.text) == null;
    final hasError = invalid || serverError != null;
    final triggerLabel = type.triggerLabel;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type.label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: type.archived ? t.muted : t.ink,
                      ),
                    ),
                    if (triggerLabel != null)
                      Text(
                        triggerLabel,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.3,
                          color: t.muted,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text('€', style: TextStyle(fontSize: 14, color: t.muted)),
              const SizedBox(width: 4),
              SizedBox(
                width: 84,
                child: TextField(
                  key: ValueKey('fine-type-amount-${type.id}'),
                  controller: amount,
                  enabled: !type.archived,
                  textAlign: TextAlign.right,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (_) => onAmountChanged(),
                  decoration: InputDecoration(
                    isDense: true,
                    errorText: hasError ? '' : null,
                    errorStyle: const TextStyle(height: 0, fontSize: 0),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              if (trailingLabel case final label?)
                Semantics(label: label, child: trailing)
              else
                trailing,
            ],
          ),
          if (serverError case final message?)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                message,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 12,
                  color: StatusColors.red600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
