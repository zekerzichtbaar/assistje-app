import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/wheel_controller.dart';
import '../data/models/wheel_models.dart';
import 'widgets/wheel_painter.dart';
import 'widgets/wheel_spinner.dart';
import 'widgets/wheel_ui.dart';

const Color _amber900 = StatusColors.amber900;
const Color _amber950 = Color(0xFF451A03);

/// Het "Radje van onfortuin" (`Pages/Wheel.tsx` in de PWA): kies wie er
/// meedoet, draai, en de winnaar kan als vlagger aan de eerstvolgende
/// wedstrijd. De app kiest de winnaar zelf en legt de draai vast; het rad
/// maakt geen boetes. Verwijderen en (ont)koppelen alleen bij `can_delete`
/// (trainer of wie draaide).
class WheelScreen extends ConsumerStatefulWidget {
  const WheelScreen({super.key});

  @override
  ConsumerState<WheelScreen> createState() => _WheelScreenState();
}

class _WheelScreenState extends ConsumerState<WheelScreen> {
  final _spinner = GlobalKey<WheelSpinnerState>();
  final _confetti = GlobalKey<ConfettiBurstState>();

  bool _spinning = false;
  WheelPlayer? _winner;

  /// Een 422 (geen wedstrijd, ongeldige winnaar) staat inline in beeld.
  String? _inlineError;

  /// Draaien waar nu een verzoek voor loopt.
  final Set<int> _busy = {};

  WheelController _controller(int teamId) =>
      ref.read(wheelControllerProvider(teamId).notifier);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showWheelError(
        context,
        AppLocalizations.of(context).wheelLoadError,
        error,
      );
    }
  }

  void _resetResult(int teamId) {
    _controller(teamId).forgetLastSpin();
    setState(() {
      _winner = null;
      _inlineError = null;
    });
  }

  void _toggle(int teamId, String key) {
    unawaited(Haptics.selection());
    _controller(teamId).toggle(key);
    _resetResult(teamId);
  }

  void _fill(int teamId, Iterable<String> keys) {
    unawaited(Haptics.selection());
    _controller(teamId).fill(keys);
    _resetResult(teamId);
  }

  void _clear(int teamId) {
    unawaited(Haptics.selection());
    _controller(teamId).clear();
    _resetResult(teamId);
  }

  Future<void> _spin(int teamId, WheelState state) async {
    final controller = _controller(teamId);
    final candidates = state.candidates;
    final index = controller.pickWinnerIndex();
    if (index == null || _spinning) return;
    controller.forgetLastSpin();
    setState(() {
      _spinning = true;
      _winner = null;
      _inlineError = null;
    });
    unawaited(Haptics.light());
    await _spinner.currentState?.spinTo(index);
    if (!mounted) return;
    final winner = candidates[index];
    setState(() {
      _spinning = false;
      _winner = winner;
    });
    _confetti.currentState?.fire();
    unawaited(Haptics.success());

    final result = await controller.recordSpin(
      winner: winner,
      candidates: candidates,
    );
    if (!mounted || result.error == null) return;
    _handleError(AppLocalizations.of(context).wheelRecordFailed, result.error);
  }

  /// 422 inline (met trilling), al het andere als toast.
  void _handleError(String title, Object? error) {
    final l10n = AppLocalizations.of(context);
    final inline = wheelValidationText(l10n, error);
    if (inline != null) {
      unawaited(Haptics.error());
      setState(() => _inlineError = inline);
    } else {
      showWheelError(context, title, error);
    }
  }

  /// Voert [request] uit voor draai [spinId]; geeft de fout terug.
  Future<Object?> _spinAction(
    int spinId,
    Future<Object?> Function() request,
    String success,
  ) async {
    if (_busy.contains(spinId)) return null;
    unawaited(Haptics.light());
    setState(() {
      _busy.add(spinId);
      _inlineError = null;
    });
    final error = await request();
    if (!mounted) return error;
    setState(() => _busy.remove(spinId));
    final l10n = AppLocalizations.of(context);
    if (error == null) {
      showWheelSuccess(context, success);
    } else {
      _handleError(l10n.wheelActionFailed, error);
    }
    return error;
  }

  Future<Object?> _assign(int teamId, int spinId) => _spinAction(
    spinId,
    () => _controller(teamId).assign(spinId),
    AppLocalizations.of(context).wheelAssigned,
  );

  Future<Object?> _unassign(int teamId, int spinId) => _spinAction(
    spinId,
    () => _controller(teamId).unassign(spinId),
    AppLocalizations.of(context).wheelUnassigned,
  );

  Future<void> _delete(int teamId, int spinId, {bool undo = false}) async {
    final l10n = AppLocalizations.of(context);
    if (!await confirmWheelDelete(
      context,
      undo ? l10n.wheelUndoConfirm : l10n.wheelDeleteConfirm,
    )) {
      return;
    }
    if (!mounted) return;
    final wasLast =
        ref.read(wheelControllerProvider(teamId)).value?.lastSpinId == spinId;
    final error = await _spinAction(
      spinId,
      () => _controller(teamId).deleteSpin(spinId),
      l10n.wheelDeleted,
    );
    // De net gedraaide winnaar is weg: de winnaarskaart ook.
    if (mounted && error == null && wasLast) setState(() => _winner = null);
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(wheelControllerProvider(teamId));
    final state = async.value;

    final List<Widget> content;
    if (state != null) {
      content = _content(teamId, state);
    } else if (async.hasError) {
      content = [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('wheel-error'),
            icon: PhosphorIconsDuotone.warningCircle,
            title: l10n.wheelLoadError,
            description: wheelErrorText(l10n, async.error),
            action: PrimaryButton(
              key: const ValueKey('wheel-retry'),
              label: l10n.retry,
              onPressed: () => _refresh(teamId),
            ),
          ),
        ),
      ];
    } else {
      content = const [
        SliverToBoxAdapter(
          child: Column(
            key: ValueKey('wheel-loading'),
            children: [
              Skeleton(height: 320, radius: AssistjeTokens.radius2xl),
              SizedBox(height: 12),
              SkeletonList(count: 4),
            ],
          ),
        ),
      ];
    }

    return Scaffold(
      key: const ValueKey('wheel-screen'),
      backgroundColor: t.sunken,
      body: AppRefresh(
        onRefresh: () => _refresh(teamId),
        padding: EdgeInsets.fromLTRB(
          12,
          ShellInsets.top(context),
          12,
          ShellInsets.bottom(context),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
              child: Semantics(
                header: true,
                child: Text(
                  l10n.navWheel,
                  // Zelfde key als de placeholder: de shell-tests lezen de
                  // schermtitel via `placeholder-title`.
                  key: const Key('placeholder-title'),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: t.ink,
                  ),
                ),
              ),
            ),
          ),
          ...content,
        ],
      ),
    );
  }

  List<Widget> _content(int teamId, WheelState state) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final candidates = state.candidates;
    final winner = _winner;
    final inlineError = _inlineError;

    return [
      SliverToBoxAdapter(
        child: ConfettiBurst(
          key: _confetti,
          alignment: Alignment.center,
          numberOfParticles: 40,
          colors: const [
            wheelGold,
            wheelGoldLight,
            wheelGoldDark,
            Color(0xFFFFF7D0),
          ],
          child: AppCard(
            key: const ValueKey('wheel-card'),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: WheelSpinner(
                    key: _spinner,
                    names: [for (final c in candidates) c.name],
                    semanticLabel: l10n.wheelSemantics(candidates.length),
                  ),
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  key: const ValueKey('wheel-spin'),
                  label: _spinning ? l10n.wheelSpinning : l10n.wheelSpin,
                  onPressed: candidates.length < 2 || _spinning
                      ? null
                      : () => _spin(teamId, state),
                ),
                if (candidates.length < 2 && !_spinning) ...[
                  const SizedBox(height: 8),
                  Text(
                    l10n.wheelMinPlayers,
                    key: const ValueKey('wheel-min-hint'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: t.muted),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      if (winner != null)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: _WinnerCard(
              winner: winner,
              state: state,
              busy:
                  state.lastSpinId != null && _busy.contains(state.lastSpinId),
              onAssign: (spinId) => _assign(teamId, spinId),
              onUndo: (spinId) => _delete(teamId, spinId, undo: true),
            ),
          ),
        ),
      if (inlineError != null)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 12, 4, 0),
            child: Text(
              inlineError,
              key: const ValueKey('wheel-inline-error'),
              style: const TextStyle(fontSize: 14, color: StatusColors.red600),
            ),
          ),
        ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: _ParticipantsCard(
            state: state,
            enabled: !_spinning,
            onToggle: (key) => _toggle(teamId, key),
            onFill: (keys) => _fill(teamId, keys),
            onClear: () => _clear(teamId),
          ),
        ),
      ),
      if (state.overview.recentSpins.isNotEmpty)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: _RecentSpinsCard(
              spins: state.overview.recentSpins,
              match: state.overview.upcomingMatch,
              busy: _busy,
              onAssign: (id) => _assign(teamId, id),
              onUnassign: (id) => _unassign(teamId, id),
              onDelete: (id) => _delete(teamId, id),
            ),
          ),
        ),
    ];
  }
}

/// De gouden winnaarskaart met koppelen en "Foutje?".
class _WinnerCard extends StatelessWidget {
  const _WinnerCard({
    required this.winner,
    required this.state,
    required this.busy,
    required this.onAssign,
    required this.onUndo,
  });

  final WheelPlayer winner;
  final WheelState state;
  final bool busy;
  final void Function(int spinId) onAssign;
  final void Function(int spinId) onUndo;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final spinId = state.lastSpinId;
    final match = state.overview.upcomingMatch;
    final assigned = state.lastSpin?.eventId != null;

    return Container(
      key: const ValueKey('wheel-winner'),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AssistjeTokens.radius2xl),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF9E7A8), wheelGold, wheelGoldDark],
        ),
      ),
      child: Column(
        children: [
          Text(
            l10n.wheelWinnerLabel.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
              color: _amber900.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            winner.name,
            key: const ValueKey('wheel-winner-name'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: _amber950,
              shadows: [
                Shadow(offset: Offset(0, 1), color: Color(0x66FFFFFF)),
                Shadow(
                  offset: Offset(0, 2),
                  blurRadius: 6,
                  color: Color(0x26000000),
                ),
              ],
            ),
          ),
          if (winner.isGuest || winner.isStaff)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xB3FFFFFF),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                winner.isStaff ? l10n.wheelStaffBadge : l10n.wheelGuestBadge,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _amber900,
                ),
              ),
            ),
          if (spinId != null && match != null && !assigned)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: FilledButton(
                key: const ValueKey('wheel-winner-assign'),
                style: FilledButton.styleFrom(
                  backgroundColor: _amber950,
                  foregroundColor: StatusColors.amber50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AssistjeTokens.radiusLg,
                    ),
                  ),
                ),
                onPressed: busy ? null : () => onAssign(spinId),
                child: Text(
                  l10n.wheelAssignTo(match.label, match.date),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          if (spinId != null && match != null && assigned)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    PhosphorIconsBold.check,
                    size: 16,
                    color: _amber950,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      l10n.wheelAssignedOn(match.date),
                      key: const ValueKey('wheel-winner-assigned'),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _amber950,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (spinId != null && match == null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                l10n.wheelNoMatch,
                key: const ValueKey('wheel-winner-no-match'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: _amber950.withValues(alpha: 0.8),
                ),
              ),
            ),
          if (spinId != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextButton(
                key: const ValueKey('wheel-winner-undo'),
                style: TextButton.styleFrom(
                  foregroundColor: _amber950.withValues(alpha: 0.8),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onPressed: busy ? null : () => onUndo(spinId),
                child: Text(l10n.wheelUndo),
              ),
            ),
        ],
      ),
    );
  }
}

/// "Wie doet er mee?": de vulknoppen en een vinkje per deelnemer.
class _ParticipantsCard extends StatelessWidget {
  const _ParticipantsCard({
    required this.state,
    required this.enabled,
    required this.onToggle,
    required this.onFill,
    required this.onClear,
  });

  final WheelState state;
  final bool enabled;
  final void Function(String key) onToggle;
  final void Function(List<String> keys) onFill;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final players = state.overview.players;
    final roster = [
      for (final p in players)
        if (p.isRoster) p,
    ];
    final guests = [
      for (final p in players)
        if (p.isGuest) p,
    ];
    final staff = [
      for (final p in players)
        if (p.isStaff && !p.isGuest) p,
    ];
    final present = state.presentKeys;
    final bench = state.benchKeys;
    final preset = state.overview.preset;

    Widget section(String title, List<WheelPlayer> list) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 16, 4, 4),
          child: WheelCardTitle(title, color: t.muted),
        ),
        for (final p in list) _tile(context, p),
      ],
    );

    return AppCard(
      key: const ValueKey('wheel-participants'),
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: WheelCardTitle(l10n.wheelParticipantsTitle, color: t.muted),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AppPill(
                key: const ValueKey('wheel-fill-team'),
                label: l10n.wheelFillTeam,
                onTap: enabled ? () => onFill(state.teamKeys) : null,
              ),
              if (present.isNotEmpty)
                AppPill(
                  key: const ValueKey('wheel-fill-present'),
                  label: l10n.wheelFillPresent(present.length),
                  onTap: enabled ? () => onFill(present) : null,
                ),
              if (bench.isNotEmpty)
                AppPill(
                  key: const ValueKey('wheel-fill-bench'),
                  label: l10n.wheelFillBench(bench.length),
                  onTap: enabled ? () => onFill(bench) : null,
                ),
              AppPill(
                key: const ValueKey('wheel-fill-clear'),
                label: l10n.wheelFillClear,
                onTap: enabled ? onClear : null,
              ),
            ],
          ),
          // Welk event de vulknoppen bedoelen.
          if (preset != null && (present.isNotEmpty || bench.isNotEmpty))
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 10, 4, 0),
              child: Text(
                '${preset.date} · ${preset.label}',
                key: const ValueKey('wheel-preset'),
                style: TextStyle(fontSize: 12, color: t.muted),
              ),
            ),
          const SizedBox(height: 8),
          if (players.isEmpty)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                l10n.wheelNoPlayers,
                style: TextStyle(fontSize: 14, color: t.muted),
              ),
            ),
          for (final p in roster) _tile(context, p),
          if (guests.isNotEmpty) section(l10n.wheelGuests, guests),
          if (staff.isNotEmpty) section(l10n.wheelStaff, staff),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, WheelPlayer player) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return CheckboxListTile(
      key: ValueKey('wheel-player-${player.key}'),
      value: state.selected.contains(player.key),
      onChanged: enabled ? (_) => onToggle(player.key) : null,
      controlAffinity: ListTileControlAffinity.leading,
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      activeColor: t.primary,
      checkColor: t.primaryContrast,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusLg),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              player.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, color: t.ink),
            ),
          ),
          if (player.isGuest) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: StatusColors.amber100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                l10n.wheelGuestBadge,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: _amber900,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// "Laatste 10 draaien" met koppelen/ontkoppelen en verwijderen.
class _RecentSpinsCard extends StatelessWidget {
  const _RecentSpinsCard({
    required this.spins,
    required this.match,
    required this.busy,
    required this.onAssign,
    required this.onUnassign,
    required this.onDelete,
  });

  final List<WheelSpin> spins;
  final WheelMatch? match;
  final Set<int> busy;
  final void Function(int id) onAssign;
  final void Function(int id) onUnassign;
  final void Function(int id) onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final match = this.match;

    return AppCard(
      key: const ValueKey('wheel-recent'),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
            child: WheelCardTitle(l10n.wheelRecentTitle, color: t.muted),
          ),
          for (final (index, spin) in spins.indexed) ...[
            if (index > 0)
              Divider(height: 1, indent: 16, endIndent: 16, color: t.lineSoft),
            _row(context, spin, match),
          ],
        ],
      ),
    );
  }

  Widget _row(BuildContext context, WheelSpin spin, WheelMatch? match) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final isBusy = busy.contains(spin.id);
    final assignedHere =
        spin.eventId != null && match != null && spin.eventId == match.id;
    final assignedElsewhere = spin.eventId != null && !assignedHere;

    return Padding(
      key: ValueKey('wheel-spin-${spin.id}'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        runSpacing: 6,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 140),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: spin.winnerName,
                    style: TextStyle(fontWeight: FontWeight.w700, color: t.ink),
                  ),
                  if (spin.drawnBy case final by?)
                    TextSpan(
                      text: ' · ${l10n.wheelDrawnBy(by)}',
                      style: TextStyle(color: t.muted),
                    ),
                ],
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          if (spin.drawnAt case final at?)
            Text(
              wheelSpinDate(at),
              style: TextStyle(fontSize: 12, color: t.muted),
            ),
          if (assignedHere)
            AppPill(
              key: ValueKey('wheel-spin-${spin.id}-unassign'),
              icon: PhosphorIconsBold.check,
              label: l10n.wheelFlaggerOn(match.date),
              selected: true,
              selectedColor: StatusColors.emerald100,
              selectedForeground: StatusColors.emerald700,
              onTap: spin.canDelete && !isBusy
                  ? () => onUnassign(spin.id)
                  : null,
            ),
          if (assignedElsewhere)
            AppPill(
              key: ValueKey('wheel-spin-${spin.id}-elsewhere'),
              label: l10n.wheelAssignedElsewhere,
            ),
          if (spin.eventId == null && match != null && spin.canDelete)
            AppPill(
              key: ValueKey('wheel-spin-${spin.id}-assign'),
              label: l10n.wheelAssignShort,
              onTap: isBusy ? null : () => onAssign(spin.id),
            ),
          if (spin.canDelete)
            IconButton(
              key: ValueKey('wheel-spin-${spin.id}-delete'),
              tooltip: l10n.wheelDeleteSpin,
              visualDensity: VisualDensity.compact,
              color: t.muted,
              icon: const Icon(PhosphorIconsBold.x, size: 16),
              onPressed: isBusy ? null : () => onDelete(spin.id),
            ),
        ],
      ),
    );
  }
}
