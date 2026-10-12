import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../agenda/presentation/widgets/duty_icons.dart';
import '../../application/event_detail_controller.dart';
import '../../data/models/event_detail_models.dart';
import 'event_section_card.dart';

/// Amber voor "afgemeld" (Tailwind amber-600/400). Lokaal tot de core-
/// opruimslice `StatusColors` uitbreidt.
const Color _amber600 = StatusColors.amber600;
const Color _amber400 = StatusColors.amber400;

/// De diensten bij deze wedstrijd (`EventDutiesSection.tsx`): voor iedereen
/// leesbaar; een trainer ([canAssign]) tikt een regel aan en kiest een
/// persoon of groep. De vlaggersregel staat erbij maar is alleen-lezen
/// (wijzigen zit nog niet in de API).
class EventDutiesSection extends StatelessWidget {
  const EventDutiesSection({
    super.key,
    required this.eventKey,
    required this.duties,
    required this.canAssign,
    required this.onAssign,
    this.flag,
  });

  final EventKey eventKey;
  final List<EventDuty> duties;
  final FlagDuty? flag;
  final bool canAssign;

  /// Wijst optie `key` (of `null` = niemand) toe; geeft de fout terug.
  final Future<Object?> Function(EventDuty row, String? key) onAssign;

  Future<void> _open(BuildContext context, EventDuty row) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    await showAppSheet<void>(
      context: context,
      title: l10n.dutiesEventAssignTitle(row.name),
      scrollable: true,
      builder: (context) =>
          _AssignList(eventKey: eventKey, initial: row, onAssign: onAssign),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final flag = this.flag;
    final rows = <Widget>[
      for (final row in duties)
        _DutyRow(row: row, onTap: canAssign ? () => _open(context, row) : null),
      if (flag != null) _FlagRow(flag: flag),
    ];
    return EventSectionCard(
      key: const ValueKey('event-duties'),
      title: l10n.dutiesEventTitle,
      child: Column(
        children: [
          for (final (index, row) in rows.indexed) ...[
            if (index > 0) Divider(height: 1, color: t.lineSoft),
            row,
          ],
        ],
      ),
    );
  }
}

/// Het icoonrondje, groen als het jouw dienst is.
class _DutyIcon extends StatelessWidget {
  const _DutyIcon({required this.icon, required this.mine});

  final IconData icon;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: mine
            ? (dark
                  ? StatusColors.emerald500.withValues(alpha: 0.15)
                  : StatusColors.emerald50)
            : t.sunken,
      ),
      child: Icon(
        icon,
        size: 18,
        color: mine
            ? (dark ? StatusColors.emerald400 : StatusColors.emerald600)
            : t.muted,
      ),
    );
  }
}

/// "Jij"-badge.
class _MineBadge extends StatelessWidget {
  const _MineBadge();

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: dark
            ? StatusColors.emerald500.withValues(alpha: 0.15)
            : StatusColors.emerald50,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
      ),
      child: Text(
        AppLocalizations.of(context).dutiesEventMine,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: dark ? StatusColors.emerald400 : StatusColors.emerald700,
        ),
      ),
    );
  }
}

/// Eén regel: icoon, naam (+ Jij/gedaan), wie, en bij een groep of meerdere
/// mensen de namen plus de notitie.
class _RowBody extends StatelessWidget {
  const _RowBody({
    required this.icon,
    required this.name,
    required this.mine,
    required this.who,
    this.done = false,
    this.absent = false,
    this.detail,
    this.onTap,
  });

  final IconData icon;
  final String name;
  final bool mine;
  final bool done;
  final bool absent;
  final String who;
  final String? detail;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final detail = this.detail;
    final body = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _DutyIcon(icon: icon, mine: mine),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 2,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: t.ink,
                      ),
                    ),
                    if (mine) const _MineBadge(),
                    if (done)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            PhosphorIconsBold.check,
                            size: 12,
                            color: t.muted,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            l10n.dutiesEventDone,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: t.muted,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text.rich(
                  TextSpan(
                    text: who,
                    children: [
                      if (absent)
                        TextSpan(
                          text: ' · ${l10n.dutiesEventAbsent}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: dark ? _amber400 : _amber600,
                          ),
                        ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: t.muted),
                ),
                if (detail != null && detail.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      detail,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: t.muted),
                    ),
                  ),
              ],
            ),
          ),
          if (onTap != null) ...[
            const SizedBox(width: 8),
            Icon(PhosphorIconsBold.caretRight, size: 16, color: t.muted),
          ],
        ],
      ),
    );
    return onTap == null ? body : InkWell(onTap: onTap, child: body);
  }
}

class _DutyRow extends StatelessWidget {
  const _DutyRow({required this.row, this.onTap});

  final EventDuty row;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Bij een groep of meerdere mensen zeggen de namen meer dan de kop; de
    // notitie komt er los achteraan.
    final detail = [
      if (row.mode != 'individual' && row.memberNames.isNotEmpty)
        row.memberNames.join(', '),
      if ((row.notes ?? '').trim().isNotEmpty) row.notes!,
    ].join(' · ');
    return KeyedSubtree(
      key: ValueKey('event-duty-${row.dutyTypeId}'),
      child: _RowBody(
        icon: dutyIconFor(row.icon),
        name: row.name,
        mine: row.mine,
        done: row.done,
        absent: row.assigneeAbsent,
        who: row.label ?? l10n.dutiesEventNobody,
        detail: detail,
        onTap: onTap,
      ),
    );
  }
}

class _FlagRow extends StatelessWidget {
  const _FlagRow({required this.flag});

  final FlagDuty flag;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // De wisselminuten, zonder die van de eerste beurt (die begint bij de
    // aftrap).
    final switches = flag.shifts.length > 1
        ? l10n.dutiesEventFlagSwitch(
            flag.shifts.skip(1).map((s) => "${s.fromMinute}'").join(' en '),
          )
        : null;
    return KeyedSubtree(
      key: const ValueKey('event-duty-flag'),
      child: _RowBody(
        icon: PhosphorIconsDuotone.flag,
        name: l10n.dutiesEventFlag,
        mine: flag.mine,
        who: flag.names.isEmpty
            ? l10n.dutiesEventNobody
            : flag.names.join(' → '),
        detail: switches,
      ),
    );
  }
}

/// De keuzelijst in de sheet. Leest de dienst live uit het detail, zodat bij
/// `multi` (de sheet blijft open) de vinkjes meelopen na elke tik.
class _AssignList extends ConsumerStatefulWidget {
  const _AssignList({
    required this.eventKey,
    required this.initial,
    required this.onAssign,
  });

  final EventKey eventKey;
  final EventDuty initial;
  final Future<Object?> Function(EventDuty row, String? key) onAssign;

  @override
  ConsumerState<_AssignList> createState() => _AssignListState();
}

class _AssignListState extends ConsumerState<_AssignList> {
  String? _busyKey;
  bool _busy = false;

  Future<void> _pick(EventDuty row, String? key) async {
    if (_busy) return;
    unawaited(Haptics.selection());
    setState(() {
      _busy = true;
      _busyKey = key ?? '';
    });
    final error = await widget.onAssign(row, key);
    if (!mounted) return;
    setState(() {
      _busy = false;
      _busyKey = null;
    });
    final l10n = AppLocalizations.of(context);
    if (error != null) {
      unawaited(Haptics.error());
      showAppToast(
        context,
        title: l10n.dutiesEventAssignFailed,
        message: _message(error),
        variant: AppToastVariant.error,
        closeLabel: l10n.close,
      );
      return;
    }
    unawaited(Haptics.success());
    // Bij meerdere personen blijft de lijst open: je vinkt er doorgaans een
    // paar achter elkaar aan.
    if (!row.isMulti) Navigator.of(context).pop();
  }

  static String? _message(Object error) =>
      error is ApiException ? error.message : null;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final detail = ref.watch(eventDetailControllerProvider(widget.eventKey));
    final row =
        detail.value?.duties
            .where((d) => d.dutyTypeId == widget.initial.dutyTypeId)
            .firstOrNull ??
        widget.initial;

    if (row.options.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Text(
          row.isGroup ? l10n.dutiesEventNoGroups : l10n.dutiesEventNoPeople,
          key: const ValueKey('event-duty-options-empty'),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: t.muted),
        ),
      );
    }

    Widget option({
      required String keyName,
      required String? pickKey,
      required String title,
      required bool selected,
      String? kind,
      String? subtitle,
      bool quiet = false,
    }) {
      final loading = _busyKey == (pickKey ?? '');
      return InkWell(
        key: ValueKey(keyName),
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
        onTap: _busy ? null : () => _pick(row, pickKey),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: title,
                        children: [
                          if (kind != null)
                            TextSpan(
                              text: '  $kind',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: t.muted,
                              ),
                            ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: quiet ? FontWeight.w400 : FontWeight.w500,
                        color: quiet ? t.muted : t.ink,
                      ),
                    ),
                    if (subtitle != null && subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: t.muted),
                      ),
                  ],
                ),
              ),
              if (loading)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else if (selected)
                const Icon(
                  PhosphorIconsBold.check,
                  key: ValueKey('event-duty-option-check'),
                  size: 18,
                  color: StatusColors.emerald600,
                ),
            ],
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        option(
          keyName: 'event-duty-option-none',
          pickKey: null,
          title: l10n.dutiesEventNone,
          selected: row.nobodyPicked,
          quiet: true,
        ),
        for (final opt in row.options)
          option(
            keyName: 'event-duty-option-${opt.key}',
            pickKey: opt.key,
            title: opt.name,
            selected: row.isPicked(opt.key),
            kind: switch (opt.kind) {
              'staff' => l10n.dutiesKindStaff,
              'spectator' => l10n.dutiesKindSpectator,
              'guest' => l10n.dutiesKindGuest,
              _ => null,
            },
            subtitle: opt.members.join(', '),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}
