import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/session/models/team_membership.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/lineup_controller.dart';
import '../data/models/lineup_models.dart';
import 'widgets/field_painters.dart';
import 'widgets/lineup_bench.dart';
import 'widgets/lineup_field.dart';
import 'widgets/lineup_ui.dart';

/// De opstelling van wedstrijd [eventId] (`Pages/Trainer/Events/Lineup` in de
/// PWA): het veld van de sport met de posities van de formatie, de bank
/// eronder en — voor wie mag bewerken — slepen, tikken, formatie, C en delen.
/// Wie niet mag bewerken ziet de gedeelde opstelling, of "nog niet gedeeld".
class LineupView extends ConsumerStatefulWidget {
  const LineupView({super.key, required this.eventId});

  final int eventId;

  @override
  ConsumerState<LineupView> createState() => _LineupViewState();
}

class _LineupViewState extends ConsumerState<LineupView> {
  /// Aangetikte positie op het veld (C- en verwijderknop).
  String? _selectedSlot;

  /// Opgepakte bankspeler (tikken in plaats van slepen).
  int? _pickedId;

  /// Lopende opslagverzoeken.
  int _saving = 0;
  bool _publishing = false;

  LineupKey _key(int teamId) => (teamId: teamId, eventId: widget.eventId);

  LineupController _controller(int teamId) =>
      ref.read(lineupControllerProvider(_key(teamId)).notifier);

  void _clearSelection() {
    if (_selectedSlot == null && _pickedId == null) return;
    setState(() {
      _selectedSlot = null;
      _pickedId = null;
    });
  }

  /// Voert een opslag-actie uit met "opslaan…" in de kop en een toast bij
  /// een fout (het veld springt dan al terug).
  Future<void> _save(Future<Object?> Function() action) async {
    final l10n = AppLocalizations.of(context);
    setState(() => _saving++);
    final error = await action();
    if (!mounted) return;
    setState(() => _saving--);
    if (error != null) showLineupError(context, l10n.lineupSaveError, error);
  }

  void _drop(int teamId, String slotCode, LineupPlayer player) {
    unawaited(Haptics.success());
    setState(() {
      _selectedSlot = null;
      _pickedId = null;
    });
    unawaited(_save(() => _controller(teamId).place(slotCode, player.id)));
  }

  void _tapSlot(int teamId, String slotCode) {
    final picked = _pickedId;
    if (picked == null) return;
    unawaited(Haptics.success());
    setState(() => _pickedId = null);
    unawaited(_save(() => _controller(teamId).place(slotCode, picked)));
  }

  void _pick(LineupPlayer player) {
    unawaited(Haptics.light());
    setState(() {
      _selectedSlot = null;
      _pickedId = _pickedId == player.id ? null : player.id;
    });
  }

  void _select(String slotCode) {
    unawaited(Haptics.selection());
    setState(() {
      _pickedId = null;
      _selectedSlot = _selectedSlot == slotCode ? null : slotCode;
    });
  }

  void _remove(int teamId, String slotCode) {
    setState(() => _selectedSlot = null);
    unawaited(_save(() => _controller(teamId).remove(slotCode)));
  }

  void _removePlayer(int teamId, Lineup lineup, LineupPlayer player) {
    final slot = lineup.slotOf(player.id);
    if (slot == null) return;
    unawaited(Haptics.success());
    _remove(teamId, slot);
  }

  void _toggleCaptain(int teamId, int playerId) {
    unawaited(_save(() => _controller(teamId).toggleCaptain(playerId)));
  }

  Future<void> _changeFormation(int teamId, String formation) async {
    unawaited(Haptics.selection());
    final l10n = AppLocalizations.of(context);
    setState(() {
      _selectedSlot = null;
      _pickedId = null;
      _saving++;
    });
    final error = await _controller(teamId).changeFormation(formation);
    if (!mounted) return;
    setState(() => _saving--);
    if (error != null) {
      showLineupError(context, l10n.lineupFormationError, error);
    }
  }

  Future<void> _share(int teamId, Lineup lineup) async {
    final l10n = AppLocalizations.of(context);
    final again = lineup.isShared;
    unawaited(Haptics.light());
    final ok = await showAppSheet<bool>(
      context: context,
      title: again
          ? l10n.lineupShareAgainConfirmTitle
          : l10n.lineupShareConfirmTitle,
      builder: (sheetContext) => _ConfirmShare(again: again),
    );
    if (!(ok ?? false) || !mounted) return;
    setState(() {
      _publishing = true;
      _selectedSlot = null;
      _pickedId = null;
    });
    final error = await _controller(teamId).publish();
    if (!mounted) return;
    setState(() => _publishing = false);
    if (error == null) {
      showLineupSuccess(context, l10n.lineupSharedToast);
    } else {
      showLineupError(context, l10n.lineupShareError, error);
    }
  }

  Future<void> _retry(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showLineupError(
        context,
        AppLocalizations.of(context).lineupLoadError,
        error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final async = ref.watch(lineupControllerProvider(_key(teamId)));
    final lineup = async.value;
    if (lineup != null) return _lineup(membership, lineup);
    if (async.hasError) return _status(_errorState(teamId, async.error));
    return _status(
      const Column(
        key: ValueKey('lineup-loading'),
        children: [
          Skeleton(height: 44, radius: AssistjeTokens.radiusFull),
          SizedBox(height: 12),
          Skeleton(height: 420, radius: AssistjeTokens.radius2xl),
          SizedBox(height: 12),
          SkeletonList(count: 2),
        ],
      ),
    );
  }

  /// Laden en fouten: gewoon scherm met titel.
  Widget _status(Widget child) {
    final t = AssistjeTokens.of(context);
    return Scaffold(
      key: const ValueKey('lineup-screen'),
      backgroundColor: t.sunken,
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          16,
          ShellInsets.top(context),
          16,
          ShellInsets.bottom(context),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
            child: _title(t.ink),
          ),
          child,
        ],
      ),
    );
  }

  /// Schermtitel; zelfde key als de placeholder (de shell-tests lezen hem).
  Widget _title(Color color, {double size = 28}) => Semantics(
    header: true,
    child: Text(
      AppLocalizations.of(context).screenEventLineup,
      key: const Key('placeholder-title'),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.2,
      ),
    ),
  );

  Widget _errorState(int teamId, Object? error) {
    final l10n = AppLocalizations.of(context);
    return switch (error) {
      ForbiddenException() => EmptyState(
        key: const ValueKey('lineup-not-shared'),
        icon: PhosphorIconsDuotone.clipboardText,
        title: l10n.lineupNotSharedTitle,
        description: l10n.lineupNotSharedBody,
      ),
      NotFoundException() => EmptyState(
        key: const ValueKey('lineup-not-found'),
        icon: PhosphorIconsDuotone.question,
        title: l10n.lineupNotFoundTitle,
        description: l10n.lineupNotFoundBody,
      ),
      _ => EmptyState(
        key: const ValueKey('lineup-error'),
        icon: PhosphorIconsDuotone.warningCircle,
        title: l10n.lineupLoadError,
        description: lineupErrorText(l10n, error),
        action: PrimaryButton(
          key: const ValueKey('lineup-retry'),
          label: l10n.retry,
          onPressed: () => _retry(teamId),
        ),
      ),
    };
  }

  Widget _lineup(TeamMembership membership, Lineup lineup) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final teamId = membership.team.id;
    final painter = fieldPainterFor(lineup.fieldVariant);
    final chrome = painter.chrome;
    final assignments = lineup.assignments;
    final bench = lineup.bench;
    final canEdit = lineup.canEdit;
    final picking = canEdit && _pickedId != null;
    final selectedPlayer = _selectedSlot == null
        ? null
        : assignments[_selectedSlot];

    String? hint;
    if (canEdit && (bench.isNotEmpty || selectedPlayer != null)) {
      hint = _pickedId != null
          ? l10n.lineupHintPlace
          : selectedPlayer != null
          ? l10n.lineupHintCaptain
          : l10n.lineupHintPick;
    }

    final status = canEdit
        ? (_saving > 0 ? l10n.lineupSaving : l10n.lineupSaved)
        : lineup.formationLabel;

    return Scaffold(
      key: const ValueKey('lineup-screen'),
      backgroundColor: chrome.shell,
      body: Column(
        children: [
          // Kop: titel tussen de zwevende pills, daaronder formatie + stand.
          ColoredBox(
            color: chrome.header,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top + ShellInsets.pillTopGap,
                left: ShellInsets.pillSize + 24,
                right: ShellInsets.pillSize + 24,
                bottom: ShellInsets.pillTopGap,
              ),
              child: SizedBox(
                height: ShellInsets.pillSize,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _title(Colors.white, size: 17),
                    if (lineup.event.title.isNotEmpty)
                      Text(
                        lineup.event.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 11, color: chrome.subtle),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Row(
              children: [
                Expanded(
                  child: canEdit && lineup.formations.isNotEmpty
                      ? _FormationPicker(
                          formations: lineup.formations,
                          current: lineup.formation,
                          chrome: chrome,
                          onChanged: (key) => _changeFormation(teamId, key),
                        )
                      : const SizedBox(height: 36),
                ),
                const SizedBox(width: 12),
                Text(
                  l10n.lineupFilled(
                    lineup.filled,
                    lineup.formationSlots.length,
                  ),
                  key: const ValueKey('lineup-filled'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  status,
                  key: const ValueKey('lineup-status'),
                  style: TextStyle(
                    fontSize: 12,
                    color: canEdit && _saving > 0
                        ? StatusColors.amber300
                        : chrome.subtle,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: LineupField(
              painter: painter,
              slots: lineup.formationSlots,
              assignments: assignments,
              captainId: lineup.captainPlayerId,
              canEdit: canEdit,
              selectedSlot: _selectedSlot,
              picking: picking,
              onDrop: (code, player) => _drop(teamId, code, player),
              onTapSlot: (code) => _tapSlot(teamId, code),
              onSelect: _select,
              onRemove: (code) => _remove(teamId, code),
              onToggleCaptain: (id) => _toggleCaptain(teamId, id),
              onBackgroundTap: _clearSelection,
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: t.surface,
              border: Border(top: BorderSide(color: t.lineSoft)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0F000000),
                  blurRadius: 16,
                  offset: Offset(0, -4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: ShellInsets.bottom(context)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LineupBench(
                    bench: bench,
                    poolEmpty: lineup.pool.isEmpty && lineup.filled == 0,
                    sport: membership.sport,
                    canEdit: canEdit,
                    pickedId: _pickedId,
                    hint: hint,
                    onPick: _pick,
                    onDropFromField: (player) =>
                        _removePlayer(teamId, lineup, player),
                  ),
                  if (canEdit)
                    LineupShareBar(
                      lineup: lineup,
                      busy: _publishing,
                      disabled:
                          lineup.filled == 0 || _saving > 0 || _publishing,
                      onShare: () => _share(teamId, lineup),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Formatiekiezer: segmented pills op de kleur van het veld.
class _FormationPicker extends StatelessWidget {
  const _FormationPicker({
    required this.formations,
    required this.current,
    required this.chrome,
    required this.onChanged,
  });

  final List<FormationOption> formations;
  final String current;
  final FieldChrome chrome;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Semantics(
      label: l10n.lineupFormations,
      container: true,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: chrome.track,
          borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
        ),
        child: ListView(
          key: const ValueKey('lineup-formations'),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(3),
          children: [
            for (final formation in formations)
              _FormationChip(
                option: formation,
                active: formation.key == current,
                chrome: chrome,
                onTap: () => onChanged(formation.key),
              ),
          ],
        ),
      ),
    );
  }
}

class _FormationChip extends StatelessWidget {
  const _FormationChip({
    required this.option,
    required this.active,
    required this.chrome,
    required this.onTap,
  });

  final FormationOption option;
  final bool active;
  final FieldChrome chrome;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: active,
    child: GestureDetector(
      key: ValueKey('lineup-formation-${option.key}'),
      behavior: HitTestBehavior.opaque,
      onTap: active ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
          boxShadow: active ? AssistjeTokens.shadowSm : null,
        ),
        child: Text(
          option.label.isEmpty ? option.key : option.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFeatures: const [FontFeature.tabularFigures()],
            color: active
                ? chrome.activeText
                : Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ),
    ),
  );
}

/// Inhoud van de deel-bevestiging.
class _ConfirmShare extends StatelessWidget {
  const _ConfirmShare({required this.again});

  final bool again;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          again
              ? l10n.lineupShareAgainConfirmBody
              : l10n.lineupShareConfirmBody,
          style: TextStyle(fontSize: 15, color: t.inkSoft, height: 1.4),
        ),
        const SizedBox(height: 20),
        PrimaryButton(
          key: const ValueKey('lineup-share-confirm'),
          label: again
              ? l10n.lineupShareAgainConfirmYes
              : l10n.lineupShareConfirmYes,
          expand: true,
          onPressed: () => Navigator.of(context).pop(true),
        ),
        const SizedBox(height: 8),
        SecondaryButton(
          key: const ValueKey('lineup-share-cancel'),
          label: l10n.lineupShareConfirmNo,
          expand: true,
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    );
  }
}
